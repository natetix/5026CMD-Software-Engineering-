-- ============================================================
-- SIMS Full Database Setup Script
-- Run against CollegeDB in SQL Server Management Studio
-- Safe to re-run: uses IF NOT EXISTS checks on all objects
-- ============================================================

USE CollegeDB;
GO

-- ============================================================
-- 1. LECTURERS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Lecturers' AND xtype='U')
BEGIN
    CREATE TABLE Lecturers (
        LecturerID   INT IDENTITY(1,1) PRIMARY KEY,
        LecturerName NVARCHAR(100) NOT NULL,
        Email        NVARCHAR(100) NULL,
        Password     NVARCHAR(100) NULL,
        Phone        NVARCHAR(20)  NULL,
        Department   NVARCHAR(100) NULL
    );
END
ELSE
BEGIN
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Lecturers' AND COLUMN_NAME='Email')
        ALTER TABLE Lecturers ADD Email NVARCHAR(100) NULL;
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Lecturers' AND COLUMN_NAME='Password')
        ALTER TABLE Lecturers ADD Password NVARCHAR(100) NULL;
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Lecturers' AND COLUMN_NAME='Phone')
        ALTER TABLE Lecturers ADD Phone NVARCHAR(20) NULL;
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Lecturers' AND COLUMN_NAME='Department')
        ALTER TABLE Lecturers ADD Department NVARCHAR(100) NULL;
END
GO

-- ============================================================
-- 2. COURSES
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Courses' AND xtype='U')
BEGIN
    CREATE TABLE Courses (
        CourseID    INT IDENTITY(1,1) PRIMARY KEY,
        CourseCode  NVARCHAR(20)  NOT NULL,
        CourseName  NVARCHAR(100) NOT NULL,
        SessionName NVARCHAR(50)  NULL,
        Semester    NVARCHAR(20)  NULL,
        CreditHours INT           NULL
    );
END
GO

-- ============================================================
-- 3. LECTURER COURSE ASSIGNMENT
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LecturerCourseAssignment' AND xtype='U')
BEGIN
    CREATE TABLE LecturerCourseAssignment (
        AssignmentID INT IDENTITY(1,1) PRIMARY KEY,
        LecturerID   INT NOT NULL REFERENCES Lecturers(LecturerID),
        CourseID     INT NOT NULL REFERENCES Courses(CourseID),
        SessionName  NVARCHAR(50) NULL,
        Semester     NVARCHAR(20) NULL
    );
END
GO

-- ============================================================
-- 4. ENROLLMENT MASTER
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EnrollmentMaster' AND xtype='U')
BEGIN
    CREATE TABLE EnrollmentMaster (
        EnrolmentID  INT IDENTITY(1,1) PRIMARY KEY,
        StudentName  NVARCHAR(100) NULL,
        StudentEmail NVARCHAR(100) NULL,
        SessionName  NVARCHAR(50)  NULL,
        Semester     NVARCHAR(20)  NULL,
        Status       NVARCHAR(20)  NOT NULL DEFAULT 'Pending'
    );
END
GO

-- ============================================================
-- 5. ENROLLMENT DETAILS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='EnrollmentDetails' AND xtype='U')
BEGIN
    CREATE TABLE EnrollmentDetails (
        DetailID    INT IDENTITY(1,1) PRIMARY KEY,
        EnrolmentID INT NOT NULL REFERENCES EnrollmentMaster(EnrolmentID),
        CourseID    INT NOT NULL REFERENCES Courses(CourseID)
    );
END
GO

-- ============================================================
-- 6. ATTENDANCE
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Attendance' AND xtype='U')
BEGIN
    CREATE TABLE Attendance (
        AttendanceID   INT IDENTITY(1,1) PRIMARY KEY,
        CourseID       INT           NULL REFERENCES Courses(CourseID),
        StudentEmail   NVARCHAR(100) NULL,
        AttendanceDate DATE          NULL,
        Status         NVARCHAR(20)  NULL
    );
END
GO

-- ============================================================
-- 7. COURSE MARKS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CourseMarks' AND xtype='U')
BEGIN
    CREATE TABLE CourseMarks (
        MarksID         INT IDENTITY(1,1) PRIMARY KEY,
        EnrolmentID     INT          NULL REFERENCES EnrollmentMaster(EnrolmentID),
        CourseID        INT          NULL REFERENCES Courses(CourseID),
        AssignmentMarks DECIMAL(5,2) NOT NULL DEFAULT 0,
        QuizMarks       DECIMAL(5,2) NOT NULL DEFAULT 0,
        MidTestMarks    DECIMAL(5,2) NOT NULL DEFAULT 0,
        FinalExamMarks  DECIMAL(5,2) NOT NULL DEFAULT 0,
        TotalMarks      DECIMAL(5,2) NOT NULL DEFAULT 0
    );
END
GO

-- ============================================================
-- 8. NOTES (course file uploads)
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Notes' AND xtype='U')
BEGIN
    CREATE TABLE Notes (
        NoteID     INT IDENTITY(1,1) PRIMARY KEY,
        LecturerID INT           NULL,
        CourseID   INT           NULL,
        WeekNo     NVARCHAR(10)  NULL,
        FileName   NVARCHAR(200) NULL,
        FilePath   NVARCHAR(500) NULL,
        UploadDate DATETIME      NULL
    );
END
GO

-- ============================================================
-- 9. STUDENTS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Students' AND xtype='U')
BEGIN
    CREATE TABLE Students (
        StudentID   INT IDENTITY(1,1) PRIMARY KEY,
        StudentName NVARCHAR(100) NOT NULL,
        Email       NVARCHAR(100) NOT NULL UNIQUE,
        Password    NVARCHAR(100) NOT NULL,
        Programme   NVARCHAR(100) NULL,
        Phone       NVARCHAR(20)  NULL,
        IC          NVARCHAR(20)  NULL,
        CreatedDate DATETIME      DEFAULT GETDATE()
    );
END
GO

-- ============================================================
-- 10. ADMIN USERS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AdminUsers' AND xtype='U')
BEGIN
    CREATE TABLE AdminUsers (
        AdminID   INT IDENTITY(1,1) PRIMARY KEY,
        AdminName NVARCHAR(100) NOT NULL,
        Email     NVARCHAR(100) NOT NULL UNIQUE,
        Password  NVARCHAR(100) NOT NULL
    );
END
GO

-- ============================================================
-- 11. ANNOUNCEMENTS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Announcements' AND xtype='U')
BEGIN
    CREATE TABLE Announcements (
        AnnouncementID INT IDENTITY(1,1) PRIMARY KEY,
        LecturerID     INT           NOT NULL REFERENCES Lecturers(LecturerID),
        CourseID       INT           NULL     REFERENCES Courses(CourseID),
        Title          NVARCHAR(200) NOT NULL,
        Content        NVARCHAR(MAX) NOT NULL,
        PostedDate     DATETIME      DEFAULT GETDATE()
    );
END
GO

-- ============================================================
-- 12. NOTIFICATIONS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Notifications' AND xtype='U')
BEGIN
    CREATE TABLE Notifications (
        NotificationID INT IDENTITY(1,1) PRIMARY KEY,
        RecipientEmail NVARCHAR(100) NOT NULL,
        Message        NVARCHAR(500) NOT NULL,
        IsRead         BIT           NOT NULL DEFAULT 0,
        CreatedDate    DATETIME      NOT NULL DEFAULT GETDATE(),
        Category       NVARCHAR(50)  NULL
    );
END
GO

-- ============================================================
-- SEED DATA
-- ============================================================

IF NOT EXISTS (SELECT * FROM AdminUsers WHERE Email = 'admin@gmail.com')
    INSERT INTO AdminUsers (AdminName, Email, Password)
    VALUES ('Administrator', 'admin@gmail.com', 'admin123');

IF NOT EXISTS (SELECT * FROM Lecturers WHERE Email = 'david@gmail.com')
    INSERT INTO Lecturers (LecturerName, Email, Password, Department)
    VALUES ('David Lee', 'david@gmail.com', '12345', 'Computer Science');
ELSE
    UPDATE Lecturers SET Email='david@gmail.com', Password='12345'
    WHERE Email='david@gmail.com';

IF NOT EXISTS (SELECT * FROM Students WHERE Email = 'student@gmail.com')
    INSERT INTO Students (StudentName, Email, Password, Programme)
    VALUES ('John Tan', 'student@gmail.com', '12345', 'Software Engineering');

IF NOT EXISTS (SELECT * FROM Courses WHERE CourseCode = 'SE101')
    INSERT INTO Courses (CourseCode, CourseName, SessionName, Semester, CreditHours)
    VALUES ('SE101', 'Software Engineering', 'SEP2025', '1', 3);

GO
PRINT 'Database setup completed successfully.';
