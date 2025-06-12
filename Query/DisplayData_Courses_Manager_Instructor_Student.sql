

--create a procedure that enter id from branch and give the detials about branch and manager who manage this branch 

create or alter proc sp_getbranchdetails  @id int , @name varchar(max) output , @location  varchar(50) output ,@managername varchar(max) output
with encryption
AS
  select @id=b.Id, @name=B.[Name],@location=B.[location] ,@managername=M.[name] 
  from Branch B , training_manager M
  where B.manager_id = M.manager_id and  B.Id = @id

   

Declare  @BranchName varchar(max) , @branchlocation varchar(50) ,@ManName varchar (max)
EXEC sp_getbranchdetails  4 ,@BranchName  output ,@branchlocation output ,@ManName output       
select @ManName AS 'manager Name' ,@BranchName AS 'Branch Name' ,@branchlocation AS 'Branch Location' 

-------------------------------------------------------------------------------------------------------
create or alter view Branch_Track_Intake_V 
as
select 
    bti.Branch_ID, b.Name  'Branch_Name',
    bti.Track_ID, t.Name  'Track_Name',
    bti.Intake_ID,i.Name  'Intake_Name',

    i.startDate 'Intake_Start_Date',
    i.endDate 'Intake_End_Date'
from 
    Branch_Track_Intake bti
inner join 
    Branch b ON b.Id = bti.Branch_ID
inner join 
    Track t ON t.Id = bti.Track_ID
inner join 
    Intake i ON i.Id = bti.Intake_ID;

select * from Branch_Track_Intake_V


  ------------------------------------------------------------------------------------------------------------
create view showAllInstructor_V 
as
	select * from Instructor

select * from showAllInstructor_V

------------------------------------------------------------------
create proc showAllInstructorById @id int
as
begin
	select * from Instructor
	where Id = @id
end
exec showAllInstructorById 1


---------------------------------view to show all details  of course-------------
CREATE or ALter View view_all_courses
AS
SELECT 
    [id], [name], [description],  [Max_Degree],[Min_Degree]
FROM [course];

 select * from view_all_courses


-------------------------------------Show All Results or students --------------------------
CREATE OR ALTER PROC Student_AllCoursesResult (@std INT)
    
AS 
BEGIN
    SELECT 
        CONCAT(s.Fname, ' ', s.Lname) AS FullName,
        c.[Name] AS CourseName
    FROM 
        Course c, Courses_in_Track ST, std.Student as S
    WHERE 
        c.Id = ST.[Crs_Id]
        AND ST.Track_Id = s.Id
        AND s.Id = @std;
END
GO
exec Student_AllCoursesResult 1

----------------------------------------------------------------

--VIEW ==> dispaly the students and his courses in the track
CREATE VIEW StudentCourseNames AS
SELECT 
    S.Id AS StudentId,
    S.Fname+' '+S.Lname AS StudentName,
    C.Id AS CourseId,
    C.Name AS CourseName
FROM 
    std.Student S
INNER JOIN 
    Student_in_Track SIT ON S.Id = Std_Id
INNER JOIN 
    Courses_in_Track CIT ON SIT.Track_Id = CIT.Track_Id
INNER JOIN 
    Course C ON CIT.Crs_Id = C.Id;

--dispaly view
select * from StudentCourseNames

