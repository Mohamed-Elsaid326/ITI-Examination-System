
-------------------------- ctreate DataBase-------------------

CREATE DATABASE ExamSystem
ON 
PRIMARY (
    NAME = 'ExamSystem_Data',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\\ExamSystem_Data.mdf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
),
FILEGROUP exam_FG1 (
    NAME = 'ExamSystem_DataFG1',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\\ExamSystem_DataFG1.ndf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
),
FILEGROUP exam_FG2 (
    NAME = 'ExamSystem_DataFG2',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExamSystem_DataFG2.ndf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
),
FILEGROUP exam_FG3 (
    NAME = 'ExamSystem_DataFG3',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExamSystem_DataFG3.ndf',
    SIZE = 10MB,
    MAXSIZE = 50MB,
    FILEGROWTH = 5MB
)
LOG ON (
    NAME = 'ExamSystem_Log',
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ExamSystem_Log.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB
);


---------------------------- Ctreate New Schema --------------------------
create schema std

alter schema std
transfer dbo.student


------------------------ create Backup----------------------------

BACKUP DATABASE [ExamSystem]
TO DISK = 'E:\courses\ExamSystem.bak'
WITH FORMAT,
MEDIANAME = 'SQLServerBackups',
NAME = 'Full Backup of testExamination'


-- Create Dialy Backup ----------------------
-- Done
