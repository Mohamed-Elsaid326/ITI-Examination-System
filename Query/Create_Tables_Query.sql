use ExamSystem
go
create table training_manager
(
manager_id int primary key ,
[name] varchar(20) ,
phone varchar(11)
)on exam_FG1


--------------------------------------------------
create table Department(
	Id int primary key identity(1,1),
	[Name] varchar(30) not null
)on  exam_FG1
-------------------------------------------------
create table Intake(
	Id int primary key identity(1,1),
	[Name] varchar(30),
    startDate Date,
	endDate Date,
)on  exam_FG1
----------------------------------------------------
create table Track(
	 Id int primary key identity(1,1),
	 [Name] varchar(70),
	 Dept_Id int foreign key  references Department(Id)
)on exam_FG1
---------------------------------------------------
create table Branch(
	Id int primary key identity(1,1),
	[Name] varchar(30),
	[location] varchar(40)
	)on exam_FG1

alter table Branch
add manager_id int foreign key references training_manager 

-------------------------------------------------------
create table  Branch_Track_Intake(
	Track_Id int not null ,
	Branch_Id int not null,
	Intake_Id  int not null,
	constraint PK_Brch_Intk_Trk primary key(Branch_Id ,Track_Id,Intake_Id )
	
)

alter table Branch_Track_Intake
add constraint FK_Brch_Intk_Trk_Trk foreign key (Track_Id) references Track(ID) on delete cascade on update cascade

alter table Branch_Track_Intake
add constraint FK_Brch_Intk_Trk_Brch foreign key (Branch_Id) references Branch(ID)on delete cascade on update cascade

alter table Branch_Track_Intake
add constraint FK_Brch_Intk_Trk_Intk foreign key (Intake_Id) references Intake(ID)on delete cascade on update cascade



----------------------------------
create table Student(
	Id int primary key identity(1,1),
	Fname varchar(15),
	Lname varchar(15),
	Phone varchar(11),
	BirthDate Date,
	City varchar(25),
	Street varchar(50),
	Email varchar(100),
	Class_Id int 
)

--------------------------
create table Instructor(
	Id int primary key identity(1,1),
	Fname varchar(15),
	Lname varchar(15),
	Phone varchar(11) ,
	BirthDate Date,
	City varchar(25),
	Street varchar(50),
	Email varchar(100),
	Salary int ,
	Class_Id int  
)
alter table Instructor
alter column Phone varchar(11)
--------------------------
create  table Course(
	Id int primary key identity(1,1),
	[Name] varchar(50),
	[Description] varchar(200),
	Max_Degree int ,
	Min_Degree int 
)on exam_FG1

---------------------------------------
create table  Student_in_Track(
	Std_Id int not null ,
	Track_Id int not null,
	constraint PK_Std_Trk primary key(Std_Id,Track_Id)
	
)on exam_FG1
alter table Student_in_Track
add constraint FK_Std_Trk_Trk foreign key (Track_Id) references Track(ID) on delete cascade on update cascade
ALTER TABLE Student_in_Track
DROP CONSTRAINT FK_Std_Trk_Std
alter table Student_in_Track
add constraint FK_Std_Trk_Std foreign key (Std_Id) references std.student(id) on delete cascade on update cascade

---------------------------------------
create table  Courses_in_Track(
	Crs_Id int not null ,
	Track_Id int not null,
	constraint PK_Crs_Trk primary key(Crs_Id,Track_Id)
	
)on exam_FG1
alter table Courses_in_Track
add constraint FK_Crs_Trk_Trk foreign key (Track_Id) references Track(ID) on delete cascade on update cascade

alter table Courses_in_Track
add constraint FK_Crs_Trk_Crs foreign key (Crs_Id) references Student(ID) on delete cascade on update cascade

-------------------------------
create table  Instructor_Course(
	Ins_Id int not null ,
	Crs_Id int not null,
	Class_Id int,
	yearOfInstructor int check (yearOfInstructor between 2005 and 2040),
	constraint PK_Ins_Crs primary key(Ins_Id,Crs_Id)
	
)on exam_FG1
alter table Instructor_Course
add constraint FK_Ins_Crs_Crs foreign key (Crs_Id) references Course(Id) on delete cascade on update cascade

alter table Instructor_Course
add constraint FK_Ins_Crs_Ins foreign key (Ins_Id) references Instructor(Id) on delete cascade on update cascade



--------------------------
create  table Question(
	Id int primary key identity(1,1) not null,
	Content varchar(300) not null,
	[Type] varchar(40) not null,
	Correct_Answer varchar(50) not null,
	Ins_Id  int foreign key  references Instructor(Id) ,
	Crs_Id int foreign key  references Course(Id) 
)on exam_FG2


create  table Question_Choices(
	Quest_Id int not null foreign key  references Question(Id) on delete cascade on update cascade ,
	Choice_Text varchar(300) not null,
	constraint PK_Choice_Quest primary key(Quest_Id,Choice_Text),	
)on exam_FG2

---------------------------------------
create  table Exam(
	Id int primary key identity(1,1)not null,
	[Year] int ,
	[Type] varchar(40),
	Allowance_Options varchar(40),
	Start_Time int,
	End_Time int,
	Total_Time int,
	Total_Degree int ,
	Class_Id int,
	Crs_Id int foreign key  references Course(Id) on delete cascade on update cascade
)on exam_FG2
  
-------------------------
create table  Exam_Qestions(
	Quest_Id int not null ,
	Exam_Id int not null,
	Quest_Degree int not null,
	constraint PK_Exam_Quest primary key(Quest_Id,Exam_Id)
	
)on exam_FG3
alter table Exam_Qestions
add constraint FK_Exam_Quest_Exam foreign key (Exam_Id) references Exam(Id) on delete cascade on update cascade

alter table Exam_Qestions
add constraint FK_Exam_Quest_Quest foreign key (Quest_Id) references Question(Id) on delete cascade on update cascade

---------------------------------
create table  Student_Exam(
	Std_Id int not null ,
	Exam_Id int not null,
	results int not null,
	constraint PK_Std_Exam primary key(Std_Id,Exam_Id)
	
)on exam_FG3
alter table Student_Exam
add constraint FK_Std_Exam_Exam foreign key (Exam_Id) references Exam(ID) on delete cascade on update cascade

ALTER TABLE Student_Exam
DROP CONSTRAINT  FK_Std_Exam_Std
alter table Student_Exam
add constraint FK_Std_Exam_Std foreign key (Std_Id) references std.Student(ID) on delete cascade on update cascade


create table answers (
    std_id int  not null,
    quest_id int not null,
    answer_text varchar(300),
    is_correct bit ,
    primary key (std_id, quest_id),
    foreign key (std_id) references std.student(id) on delete cascade on update cascade,
    foreign key (quest_id) references question(id)on delete cascade on update cascade
)on exam_FG3
