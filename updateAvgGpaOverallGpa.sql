UPDATE registeredCourses
SET [courseAvg] = (SELECT ROUND(AVG(examGrade),0) AS INT
FROM exams
WHERE registeredCourses.registeredId = exams.registeredId
GROUP BY registeredId);


DECLARE @gpa decimal(3,0), @avg decimal(3,0)

DECLARE gpa_cursor CURSOR FOR
	SELECT courseAvg, courseGpa FROM registeredCourses

	OPEN gpa_cursor

	FETCH NEXT FROM gpa_cursor
	INTO @avg, @gpa

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @avg >= 90.0
			SELECT @gpa = 4.00
		ELSE IF @avg >= 80.0 AND @gpa < 90.0
			SELECT @gpa = 3.00
		ELSE IF @avg >= 70.0 AND @gpa < 80.0
			SELECT @gpa = 2.00
		ELSE IF @avg >= 60.0 AND @gpa < 70.0
			SELECT @gpa = 1.00
		ELSE
			SELECT @gpa = 0.00
		
		UPDATE registeredCourses
		SET courseGpa = @gpa WHERE CURRENT OF gpa_cursor

		FETCH NEXT FROM gpa_cursor
		INTO @avg, @gpa

	END

CLOSE gpa_cursor;
DEALLOCATE gpa_cursor;


DECLARE @overallGpa decimal(3,2), @semester varchar(50), @studentId varchar(50)

DECLARE overallGpa_cursor CURSOR FOR
	SELECT semester, studentId, overallGpa FROM studentGpa

	OPEN overallGpa_cursor

	FETCH NEXT FROM overallGpa_cursor
	INTO @semester, @studentId, @overallGpa

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @overallGpa = (SELECT AVG(courseGpa)
		FROM registeredCourses
		WHERE semester = @semester AND studentId = @studentId)
		--GROUP BY semester, studentId)
		
		UPDATE studentGpa
		SET overallGpa = @overallGpa WHERE CURRENT OF overallGpa_cursor

		FETCH NEXT FROM overallGpa_cursor
		INTO @semester, @studentId, @overallGpa

	END

CLOSE overallGpa_cursor;
DEALLOCATE overallGpa_cursor;

