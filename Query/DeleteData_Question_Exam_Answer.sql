
---------------------- Delete Exam -------------------
create or alter  proc sp_deleteexam (@examid int)
 as
	 begin
	 if exists(select 1 from exam where id=@examid)
		 begin
		 delete from exam_questions where exam_id=@examid
		 delete from exam where id=@examid
		 end
	 else
		 begin
			 print'this exam doesnot exist'
		 end
end

exec SP_deleteExam @examID=1
exec SP_deleteExam @examID=5

-----------------------------------------------------------
---------------------- Delete Question  -------------------
 create or alter  proc SP_deleteQuestion(@questionID int)
 as
 begin
	 IF Exists(select 1 from Question where id=@questionId)
		 begin
		 delete from Exam_questions where Quest_Id=@questionID
		 delete from Question_Choices  where Quest_Id=@questionId
		 delete from Question where id=@questionID
		 end
	 else
	 begin
		 select'This Question doesnot in Data'
	 end
 end

 exec SP_deleteQuestion @questionID=20

 ---------------------------------------------
 ---------------------- Delete Question Of Exam  -------------------
create or alter proc sp_deleteexamquestions(@examid int,@questionid int)
 as
 begin
	 if exists(select 1 from exam_questions where exam_id=@examid and quest_id=@questionid)
	 begin
		 delete from exam_questions where exam_id=@examid and quest_id=@questionid
	 end
	 else
		 begin
		 print 'this question of this exam doesnot exist'
		 end
 end

  exec SP_deleteExamQuestions @examID=3, @questionID=12
   exec SP_deleteExamQuestions @examID=3, @questionID=4


