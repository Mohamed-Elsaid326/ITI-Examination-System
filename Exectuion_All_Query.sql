
--create a procedure that enter id from branch and give the detials about branch and manager who manage this branch 

Declare  @BranchName varchar(max) , @branchlocation varchar(50) ,@ManName varchar (max)
EXEC sp_getbranchdetails  4 ,@BranchName  output ,@branchlocation output ,@ManName output       
select @ManName AS 'manager Name' ,@BranchName AS 'Branch Name' ,@branchlocation AS 'Branch Location' 

---------------------------------------------------------------------------
select * from Branch_Track_Intake_V

---------------------------------------------------------------
select * from showAllInstructor_V

---------------------------------------
exec showAllInstructorById 1

--------------------------------------------
--view to show all details  of course
 
 select * from view_all_courses

 ---------------------------------------------
 --Show All Results or student
 
 exec Student_AllCoursesResult 1

 ----------------------------------------------------------
 --VIEW ==> dispaly the students and his courses in the track

 select * from StudentCourseNames

 --------------------------------------------------------------
 --proc ==> show all exams that the student made it with his result and total degree
exec GetStudentExams 1

------------------------------------------------------------
--- Display Students In Exams

select * from V_selectStudentExam

---------------------------------------------------------------
--proc ==> display the question and student's answer (wrong) and the correct answer

exec GetStudentIncorrectAnswers 1 ,3

------------------------------------------------------------
--proc ==> dispaly the average of the student's degree

exec GetStudentAverageGrade 1

------------------------------------------------------
--proc ==> dispaly the questions in the spasific exam with id to the student 
exec  GetExamQuestionsForStudent 1,3

--------------------------------------------------------
---  Display Exams -----------------
exec sp_selectexam @ex_id = 1

exec sp_selectexam @ex_id = 3

--------------------------------------------------------
--- Display Questions In Exam -------
exec sp_selectexamquestion @ex_id = 1

exec sp_selectexamquestion @ex_id = 3

------------------------------------------------------
--- Display Questions -----------------

exec sp_selectquestions @q_id = 2

exec sp_selectquestions @q_id = 9999


-------------------------------------------------------
-- Display  Choices Of Questions  ---------------------
exec sp_selectquestionchoices @q_id = 1

exec sp_selectquestionchoices @q_id = 15

exec sp_selectquestionchoices @q_id = 90

-----------------------------------------------------
---- Display Exams In Courses-----------------

select * from V_selectExamsInCourse

------------------------------------------------------
----procedure that whice a manager leave a branch another manager can take its place by id

EXEC newmanager_proc @oldmananagernum = 3 ,  @newmananagernum= 4 , @branchNum = 4

------------------------------------------------------------------------------

exec RegisterStudentInTrack 1,3

-----------------------------------------------------------

exec AddInstructor 'sarah','ahmed','01234567890','2000-12-12','Minya','Malawi','sarahSalah@iti.org',6000,5

update Instructor
set Class_Id = 5
where Id = 1

----------------------------------------------------------------

exec AddInstructor_Cource 1,3,5,2015

select * from Instructor_Course

-------------------- Insert Exam  -------------------------
insert into exam ([year], [type], allowance_options, start_time, end_time, total_degree, class_id, crs_id)
values ( 2025, 'Corrective ', 'standard', 9, 11, 100, 101, 1)



------------------------------------------------------
-- Insert Question And its Choices ----------------

declare @choices choicetype
insert into @choices (choice_text) 
values ('a. ai'),('b. al'),('c.la')

exec sp_insertQuestion @content = 'what is artificial intelligence?', @type = 'mcq',@correct_answer ='a',
								@ins_id = 1,@crs_id = 1,@choices = @choices


declare @choices choicetype
insert into @choices (choice_text) 
values (' true'),('false')
exec sp_insertQuestion @content = 'Is AI Stan for  artificial intelligence?', @type = 'mcq',@correct_answer ='true',
								@ins_id = 1,@crs_id = 1,@choices = @choices



-----------------------------------------------------------------
-- Insert Questions Into Exam

exec sp_insertExamQuestions @exam_id = 3, @quest_id = 18,  @quest_degree = 2
exec sp_insertExamQuestions @exam_id = 4, @quest_id = 16,  @quest_degree = 2
exec sp_insertExamQuestions @exam_id = 4, @quest_id = 18,  @quest_degree = 2
exec sp_insertExamQuestions @exam_id = 9, @quest_id = 5, @quest_degree = 2

exec sp_insertExamQuestions @exam_id = 3, @quest_id = 40, @quest_degree = 2


---------------------------------------------------
-- Insert Exam To Student -------------------
exec sp_insertStudentExam @std_id = 881, @exam_id = 3

exec sp_insertStudentExam @std_id = 5, @exam_id = 3

--------------------------------------------------------------
--- Insert Answer Of Student To one Question -------

exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 1, @answer_text = 'a'
exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 4, @answer_text = 'b'
exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 6, @answer_text = 'a'
exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 7, @answer_text = 'c'
exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 8, @answer_text = 'b'
exec sp_insertStudentQuestionAnswers @std_id = 1, @exam_id = 3, @quest_id = 9, @answer_text = 'TRUE'

exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 1, @answer_text = 'd'
exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 4, @answer_text = 'b'
exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 6, @answer_text = 'a'
exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 7, @answer_text = 'c'
exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 8, @answer_text = 'b'
exec sp_insertStudentQuestionAnswers @std_id = 2, @exam_id = 3, @quest_id = 9, @answer_text = 'TRUE'

exec sp_insertStudentQuestionAnswers @std_id = 7, @exam_id = 3, @quest_id = 4, @answer_text = 'a'


-------------------------------------------------------------------------
----create trigger  after_insert_delete_update_trg to keep tracke any changed in track-------
insert into Track (Name,Dept_Id)
values('embedded',3)

--------------------------------------------------------------------------
--trigger to keep track in course modification-------

-------------------------------
--teiger to prevent any one from deleting Questions ---

--CREATE TRIGGER trg_instead_of_delete

-----------------------------------------------------------
--Trigger fire when insert data 
INSERT INTO Answers (Std_Id, Quest_Id, Answer_Text)
VALUES (4, 7, 'b');

SELECT * FROM Answers WHERE Std_Id = 4 AND Quest_Id =7;

-----------------------------------------------------------
--Set Degree Of Student ------------------
--create or alter trigger trg_updatestudentresults

-------------------------------------------------------------
---- update total degree of exam after enter Question in exam
--create  or alter trigger trg_updateExamTotaldegree

--------------------------------------------------------
---Delete Exam ----
exec SP_deleteExam @examID=1
exec SP_deleteExam @examID=5

---------------------------------------------------------
--Delete Question  -------------------
exec SP_deleteQuestion @questionID=20

--------------------------------------------------------
---- Delete Question Of Exam  -------------------
 exec SP_deleteExamQuestions @examID=3, @questionID=12
 exec SP_deleteExamQuestions @examID=3, @questionID=4