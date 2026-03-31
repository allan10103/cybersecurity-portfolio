-- ========================================================
-- Group 33 Relationship.sql
-- Foreign Key & Composite PK Definitions (11-Table BCNF)
-- ========================================================

USE [BelliniClasses-33];
GO

-- ========================================================
-- STEP 1: ADD COMPOSITE PRIMARY KEYS
-- (For the linking tables)
-- ========================================================

ALTER TABLE SectionStaffing
ADD CONSTRAINT PK_SectionStaffing PRIMARY KEY (SectionID, TAEmail);

ALTER TABLE ProgramRequirements
ADD CONSTRAINT PK_ProgramRequirements PRIMARY KEY (ProgramID, CourseID);

ALTER TABLE CoursePrerequisites
ADD CONSTRAINT PK_CoursePrerequisites PRIMARY KEY (CourseID, PrereqCourseID);
GO

-- ========================================================
-- STEP 2: MASTER CATALOG FOREIGN KEYS
-- ========================================================

-- Curriculum Logic
ALTER TABLE ProgramRequirements
ADD CONSTRAINT FK_ProgReq_Program
FOREIGN KEY (ProgramID) REFERENCES DegreePrograms(ProgramID);

ALTER TABLE ProgramRequirements
ADD CONSTRAINT FK_ProgReq_Course
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE CoursePrerequisites
ADD CONSTRAINT FK_CoursePre_Course
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE CoursePrerequisites
ADD CONSTRAINT FK_CoursePre_Prereq
FOREIGN KEY (PrereqCourseID) REFERENCES Courses(CourseID);
GO

-- ========================================================
-- STEP 3: SCHEDULE TRANSACTION FOREIGN KEYS
-- ========================================================

-- Link ClassSections to the Master Catalog
ALTER TABLE ClassSections
ADD CONSTRAINT FK_ClassSections_Terms
FOREIGN KEY (TermCode) REFERENCES Terms(TermCode);

ALTER TABLE ClassSections
ADD CONSTRAINT FK_ClassSections_Courses
FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);

ALTER TABLE ClassSections
ADD CONSTRAINT FK_ClassSections_Instructors
FOREIGN KEY (InstructorEmail) REFERENCES Instructors(InstructorEmail);
GO

-- ========================================================
-- STEP 4: 1NF/BCNF "DETAIL" TABLE FOREIGN KEYS
-- ========================================================

-- Link the SectionMeetings table to ClassSections
ALTER TABLE SectionMeetings
ADD CONSTRAINT FK_SectionMeetings_ClassSections
FOREIGN KEY (SectionID) REFERENCES ClassSections(SectionID);

-- Link the OfficeHours table to Instructors
ALTER TABLE OfficeHours
ADD CONSTRAINT FK_OfficeHours_Instructors
FOREIGN KEY (InstructorEmail) REFERENCES Instructors(InstructorEmail);

-- Link Staffing to both Sections and TAs
ALTER TABLE SectionStaffing
ADD CONSTRAINT FK_Staffing_Section
FOREIGN KEY (SectionID) REFERENCES ClassSections(SectionID);

ALTER TABLE SectionStaffing
ADD CONSTRAINT FK_Staffing_TA
FOREIGN KEY (TAEmail) REFERENCES TeachingAssistants(TAEmail);
GO