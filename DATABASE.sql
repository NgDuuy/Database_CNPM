-- 1. Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS SMART_LIBRARY_CNPM;
USE SMART_LIBRARY_CNPM;
SET foreign_key_checks = 0;
CREATE TABLE USERS (
    UserID INT PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Password VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15),
    DateOfBirth DATE,
    Sex CHAR(1) CHECK (Sex IN ('M', 'F')),
    Active CHAR(1) CHECK (Active IN ('T', 'F')),
    NoActive CHAR(1) CHECK (NoActive IN ('T', 'F'))
);
CREATE TABLE STUDENT (
    UserID INT,
    MSSV INT,
    UNIQUE(MSSV),
    Department_Class VARCHAR(50),
    FullName VARCHAR(50),
    Date_Start_SignUp DATE,
    Student_NoRoom INT,
    Student_Location VARCHAR(10),
    Student_Building VARCHAR(10),
    PRIMARY KEY(UserID, MSSV),
    FOREIGN KEY (UserID) REFERENCES USERS(UserID) ON DELETE CASCADE,
    FOREIGN KEY (Student_NoRoom, Student_Location, Student_Building)
        REFERENCES SPACE_ROOM(NoRoom, Location, Building) ON DELETE SET NULL
);
CREATE TABLE ADMIN (
    UserID INT,
    MSNV_Admin INT,
    Salary DECIMAL(10,2),
    PRIMARY KEY(UserID, MSNV_Admin),
    UNIQUE(MSNV_Admin),
    FOREIGN KEY (UserID) REFERENCES USERS(UserID) ON DELETE CASCADE
);
CREATE TABLE STAFF (
    UserID INT,
    MSNV_Staff INT ,
    Salary DECIMAL(10,2),
    PRIMARY KEY(UserID, MSNV_Staff),
	UNIQUE(MSNV_Staff),
    FOREIGN KEY (UserID) REFERENCES USERS(UserID) ON DELETE CASCADE
);
CREATE TABLE SPACE_ROOM (
    NoRoom INT ,
    TypeRoom VARCHAR(50),
    Amount INT,
    QRCheckIn VARCHAR(100),
    QRCheckOut VARCHAR(100),
    Emptys INT,
    NoEmpty INT,
    MSNV_Admin_Room INT,
    Location VARCHAR(50),
    Building VARCHAR(50),
    PRIMARY KEY(NoRoom,Location,Building),
    FOREIGN KEY (MSNV_Admin_Room) REFERENCES ADMIN(MSNV_Admin) ON DELETE SET NULL
);
CREATE TABLE EQUIPMENT (
    MTB INT PRIMARY KEY,
    Name_s VARCHAR(100),
    Amount INT,
    TimeStart DATETIME,
    TimeEnd DATETIME,
    Status VARCHAR(20),
    MSSV_Equipment INT,
    MSNV_Staff_Equipment INT,
    FOREIGN KEY (MSSV_Equipment) REFERENCES STUDENT(MSSV) ON DELETE SET NULL,
    FOREIGN KEY (MSNV_Staff_Equipment) REFERENCES STAFF(MSNV_Staff) ON DELETE SET NULL
);
CREATE TABLE NOTIFICATION (
    STT INT PRIMARY KEY,
    Statistical VARCHAR(100),
    Content TEXT,
    Date_s DATE,
    Read_s CHAR(1),
    News CHAR(1),
    Notification_Before_Time DATETIME,
    MSSV_Notification INT,
    MSNV_Admin_Notification INT,
    FOREIGN KEY (MSSV_Notification) REFERENCES STUDENT(MSSV) ON DELETE CASCADE,
    FOREIGN KEY (MSNV_Admin_Notification) REFERENCES ADMIN(MSNV_Admin) ON DELETE CASCADE
);
CREATE TABLE REPORT (
    STT INT PRIMARY KEY,
    Report_Date DATE,
    Content TEXT,
    Date_Sent DATE,
    Amount INT,
    MSNV_Staff_Report INT,
    FOREIGN KEY (MSNV_Staff_Report) REFERENCES STAFF(MSNV_Staff) ON DELETE CASCADE
);
SET foreign_key_checks = 1;
