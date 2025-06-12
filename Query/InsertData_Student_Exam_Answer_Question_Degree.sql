

-------------------- Insert Exam  -------------------------
insert into exam ([year], [type], allowance_options, start_time, end_time, total_degree, class_id, crs_id)
values ( 2025, 'Corrective ', 'standard', 9, 11, 100, 101, 1);

-----------------------------------------------------
-------------------- Insert Question And its Choices ----------------
create type choicetype as table
(
    choice_text varchar(300)
)

create or alter procedure sp_insertQuestion (@content varchar(300),@type varchar(40),
			@correct_answer varchar(50),
			@ins_id int,@crs_id int,@choices  dbo.choicetype readonly ) 
as
begin
	
    declare @quest_id int;
    insert into question (content, [type], correct_answer, ins_id, crs_id)
    values (@content, @type, @correct_answer, @ins_id, @crs_id);

    set @quest_id = scope_identity();
	if @quest_id is null
    begin
        print('failed to insert question because of id of question');
        return;
    end

    insert into question_choices (quest_id, choice_text)
    select @quest_id, choice_text
    from @choices;
end

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

------------------------------------------------------------------------------
------------------- Insert Questions Into Exam
create or alter procedure sp_insertExamQuestions(@exam_id int,@quest_id int,@quest_degree int)       
as
begin
	
    if exists (select 1 from exam_questions where exam_id = @exam_id and quest_id = @quest_id)
    begin
        print 'the question already exists in this exam.';
        return
    end
	if not exists (select 1 from exam where id = @exam_id)
    begin
        print 'invalid exam_id.';
        return
    end

    if not exists (select 1 from question where id = @quest_id)
    begin
        print 'invalid quest_id.';
        return
    end
    insert into exam_questions (exam_id, quest_id, quest_degree)
    values (@exam_id, @quest_id, @quest_degree);

    print 'question inserted successfully in the exam.';
end

exec sp_insertExamQuestions @exam_id = 3, @quest_id = 4,  @quest_degree = 2

exec sp_insertExamQuestions @exam_id = 9, @quest_id = 5, @quest_degree = 2

exec sp_insertExamQuestions @exam_id = 3, @quest_id = 40, @quest_degree = 2
exec sp_insertExamQuestions @exam_id = 4, @quest_id = 4,  @quest_degree = 2

------------------------------------------------------------------------------------
-------------------- Insert Exam To Student ----------------------------
create  or alter procedure sp_insertStudentExam(@std_id int,@exam_id int)
as
begin
     if  not exists (select 1 from std.Student where Id = @std_id)
    begin
        print 'Invalid Std_id';
        return
    end
	if  not exists (select 1 from Exam where Id = @exam_id)
    begin
        print 'Invalid exam_id';
        return
    end
    if exists (select 1 from student_exam where std_id = @std_id and exam_id = @exam_id)
    begin
        update student_exam
        set results = 0
        where std_id = @std_id and exam_id = @exam_id;
    end
    else
    begin
        insert into student_exam (std_id, exam_id, results)
        values (@std_id, @exam_id, 0);
    end
end

exec sp_insertStudentExam @std_id = 881, @exam_id = 3

exec sp_insertStudentExam @std_id = 5, @exam_id = 3


--------------------------------------------------------------------------------
------------------------------ Insert Answer Of Student To one Question -----------------------
create  or alter procedure sp_insertStudentQuestionAnswers( @std_id int,@exam_id int,@quest_id int,      
				@answer_text varchar(300) )
as
begin
    declare @correct_answer varchar(50);
    declare @is_correct bit

    select @correct_answer = correct_answer 
    from question 
    where id = @quest_id

	if not exists (select 1 from Student_Exam where Std_Id = @std_id and Exam_Id= @exam_id  )
    begin
        print 'invalid std_id or exam_id'
        return
    end
    if not exists (select 1 from Exam_Questions where Quest_Id = @quest_id)
    begin
        print 'invalid quest_id'
        return
    end

    set @is_correct = case 
                        when @answer_text = @correct_answer then 1
						else 0
						end

    if exists (select 1 from answers where std_id = @std_id and quest_id = @quest_id)
    begin
       
        update answers
        set answer_text = @answer_text, is_correct = @is_correct
        where std_id = @std_id and quest_id = @quest_id;
    end
    else
    begin
        insert into answers (std_id, quest_id, answer_text, is_correct)
        values (@std_id, @quest_id, @answer_text, @is_correct);
    end
end

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



----------------------------------------------------------------------------------






