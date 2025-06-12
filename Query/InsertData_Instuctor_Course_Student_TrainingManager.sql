----procedure that whice a manager leave a branch another manager can take its place by id

create or alter procedure newmanager_proc
 @oldmananagernum int ,
 @newmananagernum int ,
 @branchNum int 
as
begin
      if Exists (
	           select 1
			   from Branch 
			   where manager_id = @oldmananagernum and Id =  @branchNum
	          )
     begin 
		 update Branch  --to replace old b new
		 set manager_id = @newmananagernum 
		 where manager_id = @oldmananagernum and Id = @branchNum;

		 print 'new employee has been replaced'
	 end
	 else 
	 begin
	      print 'there no records found '
     end
End;

EXEC newmanager_proc @oldmananagernum = 3 ,  @newmananagernum= 4 , @branchNum = 4


---------------------------------------------
CREATE PROCEDURE RegisterStudentInTrack
    @StudentId INT, 
    @TrackId INT    
AS
BEGIN
    INSERT INTO Student_in_Track (Std_Id, Track_Id)
    VALUES (@StudentId, @TrackId);
END

exec RegisterStudentInTrack 1,2
---------------------------------------------------
create or alter proc AddInstructor 
(
	@Fname varchar(15),
	@Lname varchar(15),
	@Phone varchar(11) ,
	@BirthDate Date,
	@City varchar(25),
	@Street varchar(50),
	@Email varchar(100),
	@Salary int ,
	@Class_Id int  )
as
begin
insert into Instructor 
(
	Fname ,
	Lname ,
	Phone ,
	BirthDate ,
	City ,
	Street ,
	Email ,
	Salary ,
	Class_Id )
values (
	@Fname ,
	@Lname ,
	@Phone ,
	@BirthDate ,
	@City ,
	@Street ,
	@Email ,
	@Salary ,
	@Class_Id )
end

exec AddInstructor 'sarah','ahmed','01234567890','2000-12-12','Minya','Malawi','sarahSalah@iti.org',6000,5

update Instructor
set Class_Id = 5
where Id = 1


-----------

create proc AddInstructor_Cource
(
	@Ins_Id int  ,
	@Crs_Id int ,
	@Class_Id int,
	@yearOfInstructor int )
as
begin
insert into Instructor_Course 
(
	Ins_Id  ,
	Crs_Id ,
	Class_Id ,
	yearOfInstructor )
values (
	@Ins_Id  ,
	@Crs_Id ,
	@Class_Id ,
	@yearOfInstructor    )
end


exec AddInstructor_Cource 1,4,5,2015

select * from Instructor_Course

