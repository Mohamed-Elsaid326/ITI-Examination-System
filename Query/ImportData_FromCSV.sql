BULK INSERT Course
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\Courses.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n', 
	TABLOCK
   
)
-------------------------------------------
BULK INSERT Branch
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\Branch1.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n', 
	TABLOCK
   
)
-------------------------------------------
BULK INSERT Question
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\Quest1.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n', 
	TABLOCK
   
)
----------------------------------
BULK INSERT Question_Choices
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\choice1.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',  
	TABLOCK
   
)
---------------------------------
BULK INSERT std.Student
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\student1.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2, 
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',  
	TABLOCK
   
)
--------------------------------------------------------------------------------
BULK INSERT Intake
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\Intake1.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n', 
	TABLOCK
   
)

-----------------------------------------------------------------------------------
BULK INSERT Courses_In_Track
FROM 'C:\Users\Zahraa\Music\Data_Examination_System\Courses_in_Track.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n', 
	TABLOCK
   
)




