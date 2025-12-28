/* =========================================================
   Visitor Management System - Database Schema
   Database: MS SQL Server
   ========================================================= */

/* -------------------------
   Users (Admin / Security)
   ------------------------- */
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Username VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

/* -------------------------
   Departments
   ------------------------- */
CREATE TABLE Departments (
    DepartmentId INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

/* -------------------------
   Visitors
   ------------------------- */
CREATE TABLE Visitors (
    VisitorId INT IDENTITY(1,1) PRIMARY KEY,
    VisitorName VARCHAR(150) NOT NULL,
    VisitorAddress VARCHAR(255),
    Designation VARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

/* -------------------------
   Visitor Requests
   ------------------------- */
CREATE TABLE VisitorRequests (
    RequestId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    VisitorId INT NOT NULL,
    VisitPurpose VARCHAR(255) NOT NULL,
    VisitDate DATE NOT NULL,
    ToBeVisited VARCHAR(150) NOT NULL,
    AllowedItems VARCHAR(255),
    DepartmentId INT NOT NULL,
    Status VARCHAR(50) DEFAULT 'Pending',
    RequestedAt DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_VisitorRequests_Visitors
        FOREIGN KEY (VisitorId) REFERENCES Visitors(VisitorId),

    CONSTRAINT FK_VisitorRequests_Departments
        FOREIGN KEY (DepartmentId) REFERENCES Departments(DepartmentId)
);

/* -------------------------
   Gate Passes
   ------------------------- */
CREATE TABLE GatePasses (
    GatePassId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    RequestId UNIQUEIDENTIFIER NOT NULL,
    ApprovedBy INT,
    ApprovedAt DATETIME,
    IsPrinted BIT DEFAULT 0,

    CONSTRAINT FK_GatePasses_Requests
        FOREIGN KEY (RequestId) REFERENCES VisitorRequests(RequestId),

    CONSTRAINT FK_GatePasses_Users
        FOREIGN KEY (ApprovedBy) REFERENCES Users(UserId)
);

/* =========================================================
   End of Schema
   ========================================================= */
