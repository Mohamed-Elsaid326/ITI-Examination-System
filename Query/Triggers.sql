

---------crate table for auditting insert_update_delete in trake ---------

create table audit_track_insert_update_delete
(
trake_id int ,
track_name nvarchar(30),
track_date  date,
tuser_name nvarchar(30),
new_track_name nvarchar(30)
);


----create trigger  after_insert_delete_update_trg to keep tracke any changed in track-------
create or alter trigger after_insert_delete_update_trg
on dbo.track
after delete, update , insert
as
Begin
	declare @newtrack_name nvarchar(30)
	declare @track_name nvarchar(30)
	declare @track_id int
	select @track_name =(select [name] from deleted)
	select @newtrack_name=(select [name] from inserted)
	select @track_id =(select id from inserted)
	insert into audit_track_insert_update_delete(trake_id,track_name,track_date,tuser_name,new_track_name)
	values(@track_id,@track_name,GETDATE(),SUSER_NAME(),@newtrack_name)
	select*from inserted
	select*from deleted
End

insert into Track (Name)
values('melad')


---------------------------------------------------------------------------------------------------
----------------table to audit modufication in course ------------------
create  table audit_Course
(
	users_name nvarchar(35),
	Id int,
	[Name] varchar(50),
	[Description] varchar(200),
	Max_Degree int ,
	Min_Degree int ,
	modification_date date,
	
)
----------------trigger to keep track in course modification------------------

Create trigger trg_course_audit
on dbo.course
after Delete ,Update ,insert 
as
Begin
declare @course_id int,@name int,
@description nvarchar(30),@max_degre int,@min_degree int
select @course_id =(select id from inserted)
select @name=(select Name from inserted)
select @description =(select Description from inserted)
select @min_degree =(select Min_Degree from inserted)
select @max_degre =(select Max_Degree from inserted)
insert into audit_Course (users_name,Id,name,[Description],Max_Degree,Min_Degree,modification_date)
values(suser_name(),@course_id,@name,@description,@max_degre,@min_degree,GETDATE())
select*from inserted
select*from deleted

END;
------------teiger to prevent any one from deleting ---------
CREATE TRIGGER trg_instead_of_delete
ON dbo.Question
INSTEAD OF delete
AS
BEGIN
    PRINT 'You cannot insert or update any question here';
END;

--TRIGGER ==> trigger to show if the answer of the students inserted coreect or not 
--if it is correct set 1 else set 0 in Is_Correct column
CREATE TRIGGER trig_student_question_exam
ON Answers
AFTER INSERT

AS
BEGIN
    DECLARE @StudentId INT, @QuestionId INT, @AnswerText NVARCHAR(MAX), @CorrectAnswer NVARCHAR(MAX);

	--select data insertrd from insertred table
    SELECT 
        @StudentId = INSERTED.Std_Id,
        @QuestionId = INSERTED.Quest_Id,
        @AnswerText = INSERTED.Answer_Text
    FROM INSERTED;

    --set coreect answer in the varaiable
    SELECT 
        @CorrectAnswer = Correct_Answer
    FROM 
        Question
    WHERE 
        Id = @QuestionId;

	--if the answer correct set 1 else set 0 
    UPDATE Answers
    SET Is_Correct = CASE 
                        WHEN @AnswerText = @CorrectAnswer THEN 1
                        ELSE 0
                     END
    WHERE 
        Std_Id = @StudentId AND  
        Quest_Id = @QuestionId;
END;


--Trigger fire when insert data 
INSERT INTO Answers (Std_Id, Quest_Id, Answer_Text)
VALUES (2, 6, 'Sample Answer');

SELECT * FROM Answers WHERE Std_Id = 15 AND Quest_Id = 13;



---------------------------------------------------------------------------
------------------------------ Set Degree Of Student ------------------
create or alter trigger trg_updatestudentresults
on answers
after insert , update 
as
begin
    update student_exam 
    set results = (
        select isnull(sum(eq.quest_degree), 0)
        from answers a
        inner join exam_questions eq on a.quest_id = eq.quest_id
        where a.std_id = student_exam.std_id and a.is_correct = 1 and eq.exam_id = student_exam.exam_id
    )
	print ('Updated Result Of Student')
end

----------------------------------------------------------------
---- update total degree of exam after enter Question in exam
create  or alter trigger trg_updateExamTotaldegree
on exam_questions
after insert, update, delete
as
begin
    update exam
    set total_degree = (
        select coalesce(sum(eq.quest_degree), 0)
        from Exam_Questions eq
        where eq.exam_id = exam.id
    )
    where exam.id in (
        select distinct exam_id from inserted
        union
        select distinct exam_id from deleted
        
    )
end
