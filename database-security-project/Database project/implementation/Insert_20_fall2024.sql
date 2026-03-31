-- =========================================================================
-- Group 33's Insert_20_fall2024.sql
-- Purpose: Inserts the first 20 Fall 2024 classes (COP4703 to COT4521) and assigns their respective Teaching Assistants, along with their section assignments.
--
-- *PLEASE NOTE*
-- 1. Because these specific class sections were already successfully loaded during our initial ETL phase (through custom Python scripting), 
-- the INSERT statements for the classes are wrapped in IF NOT EXISTS clauses. 
-- This fulfills the requirement of providing the exact SQL code to insert the classes without causing duplicate key errors in the database.
--
-- 2. The Task 3 Job 1 instructions noted to ignore Grad/UG hours. 
-- However, our SectionStaffing table schema specifically allows for Hours to be filled to prevent incomplete records. 
-- Rather than using dummy data (like 0), we extracted the actual hours from the data file and inserted them. 
-- This perfectly satisfies the database constraints while preserving the accuracy of the staffing records.
--
-- =========================================================================

USE [BelliniClasses-33];
GO

-- =========================================================================
-- 1. ADD CLASS SECTIONS
-- (Only inserts them if they don't already exist in the database)
-- Again, we did this due to us previously extracting all 9 datafiles during the design phase, before the project scope was changed by Dr. Fang.
-- =========================================================================

IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92505')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92505', 202408, '92505', 'COP4703', '001', 'fang1@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92502')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92502', 202408, '92502', 'COP3515', '001', 'jmanderson@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-93583')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-93583', 202408, '93583', 'CIS4930', '005', 'hjeanty@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-94153')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-94153', 202408, '94153', 'COP6536', '001', 'attilaayavuz@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92506')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92506', 202408, '92506', 'COT4400', '001', 'topsakal@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-96618')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-96618', 202408, '96618', 'CIS4930', '002', 'zhaohan@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-94200')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-94200', 202408, '94200', 'CIS6930', '009', 'zhaohan@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92510')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92510', 202408, '92510', 'COT4210', '001', 'sriramc@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-94406')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-94406', 202408, '94406', 'COT4210', '002', 'korzhova@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92512')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92512', 202408, '92512', 'CIS4930', '001', 'marbin@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92514')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92514', 202408, '92514', 'COP4931', '001', 'marbin@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-93949')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-93949', 202408, '93949', 'CIS6082', '001', 'pventura@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92516')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92516', 202408, '92516', 'CIS4083', '001', 'pventura@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92517')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92517', 202408, '92517', 'CDA4213', '001', 'dayane3@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-92372')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-92372', 202408, '92372', 'CIS6930', '005', 'dayane3@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-93638')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-93638', 202408, '93638', 'CDA4213L', '001', 'dayane3@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-93639')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-93639', 202408, '93639', 'CDA4213L', '002', 'dayane3@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-96620')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-96620', 202408, '96620', 'CDA4213L', '003', 'dayane3@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-97130')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-97130', 202408, '97130', 'CIS6930', '011', 'korzhova@usf.edu');
IF NOT EXISTS (SELECT * FROM ClassSections WHERE SectionID = '202408-96762')
    INSERT INTO ClassSections (SectionID, TermCode, CRN, CourseID, SectionNumber, InstructorEmail)
    VALUES ('202408-96762', 202408, '96762', 'COT4521', '001', 'korzhova@usf.edu');

GO

-- =========================================================================
-- 2. ADD NEW TEACHING ASSISTANTS
-- (Only inserts them if they don't already exist in the database)
-- =========================================================================

IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'hmarichettysudhakar@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('hmarichettysudhakar@usf.edu', 'Harshitha Marichetty Sudhakar');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'nafisazad@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('nafisazad@usf.edu', 'Nafis Saami Azad');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'nsambhu@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('nsambhu@usf.edu', 'Neilesh Sambu');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'adekunmi@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('adekunmi@usf.edu', 'Moyosoreoluwa Ayoade');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'avn253@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('avn253@usf.edu', 'Anh Nguyen');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'homatask@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('homatask@usf.edu', 'Kayla Homatas');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'saisharans@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('saisharans@usf.edu', 'Sai Sharan Sripada');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'kiarashs@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('kiarashs@usf.edu', 'Kiarash Sedghi');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'labiba@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('labiba@usf.edu', 'Nishat Nayla Labiba');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'bprada@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('bprada@usf.edu', 'Benjamin Prada');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'harshavardanyuvaraj@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('harshavardanyuvaraj@usf.edu', 'Harshavardan Yuvaraj');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'hongw@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('hongw@usf.edu', 'Hong Wang');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'fahimrahman@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('fahimrahman@usf.edu', 'Fahim Rahman');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'nazeefamuzammil@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('nazeefamuzammil@usf.edu', 'Nazeefa Muzammil');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'khan162@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('khan162@usf.edu', 'Umar Khan');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'adsouza34@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('adsouza34@usf.edu', 'Aanthoni Nevan Dsouza');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'mazapatamontano@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('mazapatamontano@usf.edu', 'Maria Zapata');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'susmithab@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('susmithab@usf.edu', 'Susmitha Boyidapu');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'dvitel@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('dvitel@usf.edu', 'Dmytro Vitel');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'phaneshwar@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('phaneshwar@usf.edu', 'Phaneshwar Dundigalla');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'bnadimi@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('bnadimi@usf.edu', 'Bardia Nadmi');
IF NOT EXISTS (SELECT * FROM TeachingAssistants WHERE TAEmail = 'lakshmikavya@usf.edu')
    INSERT INTO TeachingAssistants (TAEmail, TAName) VALUES ('lakshmikavya@usf.edu', 'Kavya Lakshmi Kalyanam');

GO

-- =========================================================================
-- 3. ASSIGN TAs TO CLASS SECTIONS (SectionStaffing)
-- =========================================================================

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92505' AND TAEmail = 'hmarichettysudhakar@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92505', 'hmarichettysudhakar@usf.edu', 'Grad', 10);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92505' AND TAEmail = 'nafisazad@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92505', 'nafisazad@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92502' AND TAEmail = 'nsambhu@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92502', 'nsambhu@usf.edu', 'Grad', 10);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92502' AND TAEmail = 'adekunmi@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92502', 'adekunmi@usf.edu', 'UG', 10);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92502' AND TAEmail = 'avn253@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92502', 'avn253@usf.edu', 'UG', 10);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92502' AND TAEmail = 'homatask@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92502', 'homatask@usf.edu', 'UG', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-93583' AND TAEmail = 'saisharans@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-93583', 'saisharans@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-94153' AND TAEmail = 'kiarashs@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-94153', 'kiarashs@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92506' AND TAEmail = 'labiba@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92506', 'labiba@usf.edu', 'Grad', 20);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92506' AND TAEmail = 'bprada@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92506', 'bprada@usf.edu', 'Grad', 20);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92506' AND TAEmail = 'harshavardanyuvaraj@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92506', 'harshavardanyuvaraj@usf.edu', 'UG', 10);

-- Section 202408-96618 (CIS4930) has no TAs listed.

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-94200' AND TAEmail = 'hongw@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-94200', 'hongw@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92510' AND TAEmail = 'fahimrahman@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92510', 'fahimrahman@usf.edu', 'Grad', 20);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92510' AND TAEmail = 'nazeefamuzammil@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92510', 'nazeefamuzammil@usf.edu', 'Grad', 20);
IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92510' AND TAEmail = 'khan162@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92510', 'khan162@usf.edu', 'UG', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-94406' AND TAEmail = 'adsouza34@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-94406', 'adsouza34@usf.edu', 'UG', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92512' AND TAEmail = 'mazapatamontano@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92512', 'mazapatamontano@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92514' AND TAEmail = 'susmithab@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92514', 'susmithab@usf.edu', 'Grad', 10);

-- Section 202408-93949 (CIS6082) has no TAs listed.

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92516' AND TAEmail = 'dvitel@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92516', 'dvitel@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92517' AND TAEmail = 'phaneshwar@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92517', 'phaneshwar@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-92372' AND TAEmail = 'bnadimi@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-92372', 'bnadimi@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-93638' AND TAEmail = 'lakshmikavya@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-93638', 'lakshmikavya@usf.edu', 'Grad', 10);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-93639' AND TAEmail = 'bnadimi@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-93639', 'bnadimi@usf.edu', 'Grad', 5);

IF NOT EXISTS (SELECT * FROM SectionStaffing WHERE SectionID = '202408-96620' AND TAEmail = 'bnadimi@usf.edu')
    INSERT INTO SectionStaffing (SectionID, TAEmail, TAType, Hours) VALUES ('202408-96620', 'bnadimi@usf.edu', 'Grad', 5);

-- Section 202408-97130 (CIS6930) has no TAs listed.
-- Section 202408-96762 (COT4521) has no TAs listed.

GO