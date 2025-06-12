---------------------------------------------------------------
--proc ==> show all exams that the student made it with his result and total degree
CREATE PROCEDURE GetStudentExams @StudentId INT 
AS
BEGIN
    SELECT 
        E.Id AS ExamId,
        E.Year,
        E.Type AS ExamType,
        E.Total_Degree,
        SE.results AS StudentResult
    FROM 
        Student_Exam SE
    INNER JOIN 
        Exam E ON SE.Exam_id = E.Id
    WHERE 
        SE.Std_id = @StudentId;
END;

--excute 
exec GetStudentExams 1

------------------------- Display Students In Exams -----------------
create or alter  view V_selectStudentExam
as
select
    s.id as student_id,s.fname as first_name,s.lname as last_name, s.email as email,
     e.id as exam_id, e.[year] as exam_year,
     e.[type] as exam_type,  e.total_time as total_time,
   e.total_degree as total_degree,se.results as results
     
	from
		student_exam se
	inner join
		std.student s on se.std_id = s.id
	inner join
		exam e on se.exam_id = e.id;



select * from V_selectStudentExam

--------------------------------------------------------------------------------------------------------
--proc ==> display the question and student's answer (wrong) and the correct answer
CREATE PROCEDURE GetStudentIncorrectAnswers
    @StudentId INT, 
    @QId INT
AS
BEGIN
    SELECT 
        Q.Content AS QuestionContent,
        A.Answer_Text AS StudentAnswer,
        Q.Correct_Answer AS CorrectAnswer
    FROM 
        Answers A
    INNER JOIN 
        Question Q ON A.Quest_Id = Q.Id
    WHERE 
        A.Std_id = @StudentId AND 
        A.Quest_Id = @QId AND 
        A.Is_Correct = 0;
END;

exec GetStudentIncorrectAnswers 1 ,1

--------------------------------------------------------------------------
--proc ==> dispaly the average of the student's degree
CREATE or alter PROCEDURE GetStudentAverageGrade
    @StudentId INT 
AS
BEGIN
    SELECT 
        S.Fname AS StudentName,
        AVG(SE.results) AS AverageGrade
    FROM 
        Student_Exam SE
    INNER JOIN 
        std.Student S ON SE.Std_id = S.Id
    WHERE 
        SE.Std_id = @StudentId
    GROUP BY 
       S.Fname
END;

exec GetStudentAverageGrade 1

-------------------------------------------------------------------------------------------
--proc ==> dispaly the questions in the spasific exam with id to the student 
CREATE or alter PROCEDURE GetExamQuestionsForStudent
    @StudentId INT,      
    @ExamId INT          
AS
BEGIN
    SELECT 
        CONCAT(S.Fname,' ' , S.Lname) AS StudentName,          
        Q.Id AS QuestionId,            
        Q.Content AS QuestionContent,   
        Q.Type AS QuestionType         
    FROM 
        Student_Exam SE
    INNER JOIN 
        std.Student S ON SE.Std_id = S.Id   
    INNER JOIN 
        Exam_Questions EQ ON SE.Exam_id = EQ.Exam_id
    INNER JOIN 
        Question Q ON EQ.Quest_Id = Q.Id
    WHERE 
        SE.Std_id = @StudentId AND 
        SE.Exam_id = @ExamId;
END;

exec  GetExamQuestionsForStudent 1,3

-----------------------------------------------
