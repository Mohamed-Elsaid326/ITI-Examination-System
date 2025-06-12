
----------------------  Display Exams -----------------
create or alter  procedure sp_selectexam( @ex_id int) 
as
begin
    begin try
        if exists (select 1 from exam where id = @ex_id)
        begin
            select * 
            from exam 
            where id = @ex_id;
        end
        else
        begin
            print 'this exam does not exist';
        end
    end try
    begin catch
        print 'an error occurred while selecting the exam.';
    end catch
end


exec sp_selectexam @ex_id = 1

exec sp_selectexam @ex_id = 3

-----------------------------------------------------------------------------
----------------------------- Display Questions In Exam ------------------
create or alter procedure sp_selectexamquestion(@ex_id int )
as
begin
    begin try
        if exists (select 1 from exam_questions where exam_id = @ex_id)
        begin
            select 
                eq.exam_id,eq.quest_id,q.content as quest_head, q.correct_answer as model_ans 
            from 
                exam_questions eq
            inner join 
                question q on eq.quest_id = q.id
            where 
                eq.exam_id = @ex_id;
        end
        else
        begin
            print 'no questions found for the given exam id.';
        end
    end try
    begin catch
        print 'error while selecting the exam questions.';
    end catch
end

exec sp_selectexamquestion @ex_id = 1

exec sp_selectexamquestion @ex_id = 3


--------------------------------------------------------------------------------
------------------------- Display Questions -----------------
create or alter procedure sp_selectquestions( @q_id int  )
as
begin
    begin try
        if exists (select 1 from question where id = @q_id)
        begin
            select 
                q.id,  q.content,q.type,  q.correct_answer,q.ins_id,q.crs_id  
            from 
                question q
            where 
                q.id = @q_id;
            select 
                qc.choice_text
            from 
                question_choices qc
            where 
                qc.quest_id = @q_id;
        end
        else
        begin
            print 'this question does not exist.';
        end
    end try
    begin catch
        
        print ' errorwhile selecting the question and choices.';
    end catch
end

exec sp_selectquestions @q_id = 2

exec sp_selectquestions @q_id = 9999

-------------------------------------------------------
-------------------------- Display  Choices Of Questions  -----------------------------
create or alter procedure sp_selectquestionchoices( @q_id int)
as
begin
    begin try
        if exists (select 1 from question where id = @q_id)
        begin
            select 
                qc.choice_text  
            from 
                question_choices qc
            where 
                qc.quest_id = @q_id;
        end
        else
        begin
            print 'this question does not exist.';
        end
    end try
    begin catch
        print 'an error occurred while retrieving the question choices.';
    end catch
end

exec sp_selectquestionchoices @q_id = 1

exec sp_selectquestionchoices @q_id = 15
exec sp_selectquestionchoices @q_id = 90

------------------------------------------------------------------------------------------

------------------------- Display Exams In Courses-----------------
create or alter view V_selectExamsInCourse
as
	select 
		c.id as course_id, c.[name] as course_name,
	   c.max_degree as course_max_degree,c.min_degree as course_min_degree, e.id as exam_id,
		e.[year] as exam_year,e.[type] as exam_type,
		e.start_time as exam_start_time,e.end_time as exam_end_time,
		e.total_degree as exam_total_degree
		from 
			course c
		inner join 
			exam e on c.id = e.crs_id

select * 
from V_selectExamsInCourse
where course_id = 1  

select * 
from V_selectExamsInCourse



	------------------------------------------------