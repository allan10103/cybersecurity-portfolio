-- =========================================================================================
-- Group 33's Queries.sql
-- 
-- 10 Advanced DML Queries testing our 11-Table BCNF Database Schema
-- Concepts Used: INNER/LEFT JOINs, Aggregates (SUM, COUNT), GROUP BY, HAVING, 
--                Window Functions, Subqueries (CTEs), and SET Operators (EXCEPT, INTERSECT)
-- =========================================================================================

USE [BelliniClasses-33];
GO

-- =========================================================================================
-- QUERY 1: Instructor statistics per semester
-- *NOTE*: The original db design instructions never specified extracting enrollment data,
--         nor did all of the data files contain such information. When attempting to locate
--         this data view the USF Staff Schedule Search, multiple other data anomalies were
--         found, including that courses on the data file had changed instructors, times, etc.
--
--         After speaking with Dr. Fang in office hours, he noted to just add this comment
--         and ensure Enrollment columns are set to 0 to fulfill the display requirement.
-- =========================================================================================
SELECT 
    I.Name AS InstructorName,
    T.Semester,
    T.Year,
    COUNT(DISTINCT CS.SectionID) AS TotalClasses,
    0 AS TotalEnrollments, 
    ISNULL(SUM(SS.Hours), 0) AS TotalTAHours,
    COUNT(DISTINCT SS.TAEmail) AS TotalTAs,
    0 AS EnrollmentsPerClass,
    0 AS EnrollmentsPerTAHour
FROM Instructors I
JOIN ClassSections CS ON I.InstructorEmail = CS.InstructorEmail
JOIN Terms T ON CS.TermCode = T.TermCode
LEFT JOIN SectionStaffing SS ON CS.SectionID = SS.SectionID
GROUP BY I.Name, T.Semester, T.Year
ORDER BY EnrollmentsPerClass DESC, T.Year DESC, T.Semester DESC;
GO

-- =========================================================================================
-- QUERY 2: Spring 2026 Daily Room Schedule 
-- Uses our SectionMeetings table to accurately pull daily schedules.
-- Uses CONVERT(108) to format the TIME data type into clean HH:MM format.
-- =========================================================================================
SELECT 
    SM.Room,
    SM.DayOfWeek,
    CONVERT(VARCHAR(5), SM.StartTime, 108) AS StartTime,
    CONVERT(VARCHAR(5), SM.EndTime, 108) AS EndTime,
    (C.Subject + C.CourseNumber + ' ' + C.Title) AS ClassName,
    I.Name AS InstructorName
FROM SectionMeetings SM
JOIN ClassSections CS ON SM.SectionID = CS.SectionID
JOIN Terms T ON CS.TermCode = T.TermCode
JOIN Courses C ON CS.CourseID = C.CourseID
JOIN Instructors I ON CS.InstructorEmail = I.InstructorEmail
WHERE T.Semester = 'Spring' AND T.Year = 2026 
  AND SM.Room IS NOT NULL AND SM.Room NOT LIKE '%OFF%' AND SM.Room NOT LIKE '%TBA%'
ORDER BY 
    SM.Room ASC, 
    CASE SM.DayOfWeek 
        WHEN 'Monday' THEN 1 WHEN 'Tuesday' THEN 2 
        WHEN 'Wednesday' THEN 3 WHEN 'Thursday' THEN 4 WHEN 'Friday' THEN 5 ELSE 6 
    END,
    SM.StartTime ASC;
GO

-- =========================================================================================
-- QUERY 3: Multi-semester TAs with Subtotals and Grand Totals
-- Uses Conditional Aggregation (SUM + CASE) to pivot the semesters into columns, 
-- alongside a HAVING clause to filter for TAs who worked >= 2 semesters.
-- =========================================================================================
WITH MultiTermTAs AS (
    SELECT SS.TAEmail
    FROM SectionStaffing SS
    JOIN ClassSections CS ON SS.SectionID = CS.SectionID
    GROUP BY SS.TAEmail
    HAVING COUNT(DISTINCT CS.TermCode) >= 2
)
SELECT 
    TA.TAName,
    TA.TAEmail,
    -- Pivoting the hours into specific semester columns
    SUM(CASE WHEN CS.TermCode = 202408 THEN SS.Hours ELSE 0 END) AS [Fall 2024 Hours],
    SUM(CASE WHEN CS.TermCode = 202501 THEN SS.Hours ELSE 0 END) AS [Spring 2025 Hours],
    SUM(CASE WHEN CS.TermCode = 202508 THEN SS.Hours ELSE 0 END) AS [Fall 2025 Hours],
    SUM(CASE WHEN CS.TermCode = 202601 THEN SS.Hours ELSE 0 END) AS [Spring 2026 Hours],
    -- The Grand Total
    SUM(SS.Hours) AS GrandTotalTAHours
FROM TeachingAssistants TA
JOIN MultiTermTAs M ON TA.TAEmail = M.TAEmail
JOIN SectionStaffing SS ON TA.TAEmail = SS.TAEmail
JOIN ClassSections CS ON SS.SectionID = CS.SectionID
GROUP BY TA.TAName, TA.TAEmail
ORDER BY TA.TAName;
GO

-- =========================================================================================
-- QUERY 4: TAs who worked the same course multiple times
-- =========================================================================================
SELECT 
    TA.TAName,
    TA.TAEmail,
    SS.TAType,
    C.Subject,
    C.CourseNumber,
    COUNT(CS.SectionID) AS TimesAsTA
FROM TeachingAssistants TA
JOIN SectionStaffing SS ON TA.TAEmail = SS.TAEmail
JOIN ClassSections CS ON SS.SectionID = CS.SectionID
JOIN Courses C ON CS.CourseID = C.CourseID
GROUP BY TA.TAName, TA.TAEmail, SS.TAType, C.Subject, C.CourseNumber
HAVING COUNT(CS.SectionID) > 1
ORDER BY TA.TAName;
GO

-- =========================================================================================
-- QUERY 5: Instructors teaching ONLY Online Graduate Level courses
-- Uses ISNULL to protect against missing meeting rooms, and strictly filters out
-- any instructor who has taught an Undergrad (1000-4000) or In-Person class.
-- =========================================================================================
WITH InstructorFlags AS (
    SELECT 
        CS.InstructorEmail,
        -- Flag as 1 if the course is Undergrad (starts with 1, 2, 3, or 4)
        CASE WHEN C.CourseNumber LIKE '[1-4]%' THEN 1 ELSE 0 END AS IsUndergrad,
        -- Flag as 1 if the room is NOT online (i.e., doesn't contain OFF or TBA)
        CASE WHEN ISNULL(SM.Room, 'OFFT OFF') NOT LIKE '%OFF%' 
              AND ISNULL(SM.Room, 'OFFT OFF') NOT LIKE '%TBA%' 
              AND ISNULL(SM.Room, 'OFFT OFF') NOT LIKE '%Online%' 
             THEN 1 ELSE 0 END AS IsInPerson
    FROM ClassSections CS
    JOIN Courses C ON CS.CourseID = C.CourseID
    LEFT JOIN SectionMeetings SM ON CS.SectionID = SM.SectionID
),
StrictOnlineGradInstructors AS (
    SELECT InstructorEmail
    FROM InstructorFlags
    GROUP BY InstructorEmail
    -- To qualify, they must have ZERO undergrad classes and ZERO in-person classes
    HAVING SUM(IsUndergrad) = 0 AND SUM(IsInPerson) = 0
)
SELECT DISTINCT
    I.Name,
    I.InstructorEmail,
    ISNULL(OH.DayOfWeek + ' ' + CONVERT(VARCHAR(5), OH.StartTime, 108) + '-' + CONVERT(VARCHAR(5), OH.EndTime, 108) + ' (' + OH.MeetingType + ')', 'No Office Hours') AS OfficeHours,
    (C.Subject + C.CourseNumber + ' ' + C.Title) AS CourseName,
    T.Semester,
    T.Year
FROM StrictOnlineGradInstructors OGI
JOIN Instructors I ON OGI.InstructorEmail = I.InstructorEmail
JOIN ClassSections CS ON I.InstructorEmail = CS.InstructorEmail
JOIN Courses C ON CS.CourseID = C.CourseID
JOIN Terms T ON CS.TermCode = T.TermCode
LEFT JOIN OfficeHours OH ON I.InstructorEmail = OH.InstructorEmail
ORDER BY I.Name, T.Year, T.Semester;
GO

-- =========================================================================================
-- QUERY 6: Courses serving as a prerequisite for 2 or more courses
-- Uses a self-referencing subquery structure based on our BCNF design.
-- =========================================================================================
WITH PopularPrereqs AS (
    SELECT PrereqCourseID
    FROM CoursePrerequisites
    GROUP BY PrereqCourseID
    HAVING COUNT(CourseID) >= 2
)
SELECT 
    (P.Subject + P.CourseNumber + ' ' + P.Title) AS PrerequisiteCourse,
    (T.Subject + T.CourseNumber + ' ' + T.Title) AS RequiredByCourse
FROM PopularPrereqs PP
JOIN Courses P ON PP.PrereqCourseID = P.CourseID
JOIN CoursePrerequisites CP ON PP.PrereqCourseID = CP.PrereqCourseID
JOIN Courses T ON CP.CourseID = T.CourseID
ORDER BY PrerequisiteCourse, RequiredByCourse;
GO

-- =========================================================================================
-- QUERY 7: Spring 2026 Schedule for courses required by BSIT or BSCYS
-- Uses CONVERT(108) to format the TIME data types into clean HH:MM format.
-- =========================================================================================
SELECT DISTINCT
    CS.CRN,
    (C.Subject + C.CourseNumber + ' ' + C.Title) AS CourseName,
    SM.DayOfWeek,
    CONVERT(VARCHAR(5), SM.StartTime, 108) AS StartTime,
    CONVERT(VARCHAR(5), SM.EndTime, 108) AS EndTime,
    SM.Room,
    I.Name AS InstructorName
FROM ClassSections CS
JOIN Terms T ON CS.TermCode = T.TermCode
JOIN Courses C ON CS.CourseID = C.CourseID
JOIN ProgramRequirements PR ON C.CourseID = PR.CourseID
JOIN SectionMeetings SM ON CS.SectionID = SM.SectionID
JOIN Instructors I ON CS.InstructorEmail = I.InstructorEmail
WHERE T.Semester = 'Spring' AND T.Year = 2026
  AND PR.ProgramID IN ('BSIT', 'BSCYS')
  AND PR.ProgramRequirementType = 'Core'
ORDER BY CourseName, SM.DayOfWeek;
GO

-- =========================================================================================
-- QUERY 8: Fall 2025 TAs (20 hours) for courses ONLY required by BSCP
-- Uses the EXCEPT set operator to isolate courses exclusive to BSCP.
--
-- *NOTE*: This query returns 0 rows because there are no 20-hour TAs in Fall 2025 
-- assigned to courses that are EXCLUSIVELY required by BSCP (all candidate courses 
-- like CDA4205 and COP4600 are also required by BSCS, and are thus filtered out by the EXCEPT operator).
--
-- We weren't sure if this is what Dr. Fang was asking for, so we've included a second Query 8 after the first one!
-- =========================================================================================
WITH CoursesOnlyBSCP AS (
    SELECT CourseID 
    FROM ProgramRequirements 
    WHERE ProgramID = 'BSCP' AND ProgramRequirementType = 'Core'
    EXCEPT
    SELECT CourseID 
    FROM ProgramRequirements 
    WHERE ProgramID <> 'BSCP' AND ProgramRequirementType = 'Core'
)
SELECT 
    TA.TAName,
    TA.TAEmail,
    (C.Subject + C.CourseNumber + ' ' + C.Title) AS CourseName
FROM SectionStaffing SS
JOIN ClassSections CS ON SS.SectionID = CS.SectionID
JOIN Terms T ON CS.TermCode = T.TermCode
JOIN Courses C ON CS.CourseID = C.CourseID
JOIN TeachingAssistants TA ON SS.TAEmail = TA.TAEmail
JOIN CoursesOnlyBSCP COB ON C.CourseID = COB.CourseID
WHERE T.Semester = 'Fall' AND T.Year = 2025
  AND SS.Hours = 20;
GO
-- =========================================================================================
-- *OTHER VERSION OF QUERY 8: Fall 2025 TAs (20 hours) for courses required by BSCP
--
-- This query assumes that Dr. Fang meant "any course required by BSCP".
-- This will in fact give us results of the TAs who have 20 hours per week in a BSCP core course.
-- =========================================================================================
SELECT DISTINCT
    TA.TAName,
    TA.TAEmail,
    (C.Subject + C.CourseNumber + ' ' + C.Title) AS CourseName
FROM SectionStaffing SS
JOIN ClassSections CS ON SS.SectionID = CS.SectionID
JOIN Terms T ON CS.TermCode = T.TermCode
JOIN Courses C ON CS.CourseID = C.CourseID
JOIN TeachingAssistants TA ON SS.TAEmail = TA.TAEmail
JOIN ProgramRequirements PR ON C.CourseID = PR.CourseID
WHERE T.Semester = 'Fall' AND T.Year = 2025
  AND SS.Hours = 20
  AND PR.ProgramID = 'BSCP'
  AND PR.ProgramRequirementType = 'Core'
ORDER BY TA.TAName;
GO

-- =========================================================================================
-- QUERY 9: Instructors with more UG TA hours than Grad TA hours
-- Uses a PIVOT-style conditional SUM logic inside the SELECT and HAVING clauses.
-- =========================================================================================
SELECT 
    I.Name AS InstructorName,
    ISNULL(SUM(CASE WHEN SS.TAType = 'UG' THEN SS.Hours ELSE 0 END), 0) AS TotalUGHours,
    ISNULL(SUM(CASE WHEN SS.TAType = 'Grad' THEN SS.Hours ELSE 0 END), 0) AS TotalGradHours
FROM Instructors I
JOIN ClassSections CS ON I.InstructorEmail = CS.InstructorEmail
JOIN SectionStaffing SS ON CS.SectionID = SS.SectionID
GROUP BY I.Name
HAVING ISNULL(SUM(CASE WHEN SS.TAType = 'UG' THEN SS.Hours ELSE 0 END), 0) > 
       ISNULL(SUM(CASE WHEN SS.TAType = 'Grad' THEN SS.Hours ELSE 0 END), 0);
GO

-- =========================================================================================
-- QUERY 10: TAs for courses that offer both MW and TR patterns
-- Uses the INTERSECT set operator to find matching multi-pattern courses.
-- =========================================================================================
WITH MWCourses AS (
    SELECT DISTINCT CS.CourseID
    FROM ClassSections CS
    JOIN SectionMeetings SM ON CS.SectionID = SM.SectionID
    WHERE SM.DayOfWeek IN ('Monday', 'Wednesday')
),
TRCourses AS (
    SELECT DISTINCT CS.CourseID
    FROM ClassSections CS
    JOIN SectionMeetings SM ON CS.SectionID = SM.SectionID
    WHERE SM.DayOfWeek IN ('Tuesday', 'Thursday')
),
TargetCourses AS (
    SELECT CourseID FROM MWCourses
    INTERSECT
    SELECT CourseID FROM TRCourses
)
SELECT 
    TA.TAName,
    -- CAST is used on CourseNumber and SectionNumber to prevent implicit conversion errors
    (C.Subject + CAST(C.CourseNumber AS VARCHAR(10)) + ' ' + C.Title + ' - Sec ' + CAST(CS.SectionNumber AS VARCHAR(10))) AS ClassName,
    -- CAST is used here to safely concatenate the TIME data types with strings
    SM.DayOfWeek + ' ' + ISNULL(CONVERT(VARCHAR(5), SM.StartTime, 108), '') + '-' + ISNULL(CONVERT(VARCHAR(5), SM.EndTime, 108), '') AS MeetingTime,
    SM.Room,
    T.Semester,
    T.Year
FROM TargetCourses TC
JOIN Courses C ON TC.CourseID = C.CourseID
JOIN ClassSections CS ON C.CourseID = CS.CourseID
JOIN SectionMeetings SM ON CS.SectionID = SM.SectionID
JOIN SectionStaffing SS ON CS.SectionID = SS.SectionID
JOIN TeachingAssistants TA ON SS.TAEmail = TA.TAEmail
JOIN Terms T ON CS.TermCode = T.TermCode
WHERE SM.DayOfWeek IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday')
ORDER BY C.CourseID, T.Year, T.Semester, CS.SectionNumber;
GO