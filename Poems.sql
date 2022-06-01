--1.What grades are stored in the database?
SELECT * FROM Grade;
--2.What emotions may be associated with a poem?
SELECT * FROM Emotion;
--3.How many poems are in the database?
SELECT COUNT(Poem.Id) As 'NumPoems' FROM Poem;
--4.Sort authors alphabetically by name. What are the names of the top 76 authors?
SELECT TOP 76 Name FROM Author ORDER BY Name;
--5.Starting with the above query, add the grade of each of the authors.
SELECT TOP 76 Author.Name , Grade.Name FROM Author LEFT JOIN Grade ON Grade.Id=Author.GradeId ORDER BY Author.Name;
--6.Starting with the above query, add the recorded gender of each of the authors.
SELECT TOP 76 Author.Name, Gender.Name, Grade.Name FROM Author LEFT JOIN Grade ON Grade.Id=Author.GradeId LEFT JOIN Gender ON Gender.Id=Author.GenderId ORDER BY Author.Name;
--7.What is the total number of words in all poems in the database?
SELECT SUM(WordCount) AS 'TotalWords' FROM Poem;
--8.Which poem has the fewest characters?
SELECT TOP 1 Title , CharCount FROM Poem ORDER BY CharCount;
--9.How many authors are in the third grade?
Select COUNT(Author.Id) FROM Author LEFT JOIN Grade ON Author.GradeId = Grade.Id WHERE Grade.Name='3rd Grade';
--10.How many total authors are in the first through third grades?
Select COUNT(Author.Id) FROM Author LEFT JOIN Grade ON Author.GradeId = Grade.Id WHERE Grade.Name='3rd Grade' OR Grade.Name='1st Grade' OR Grade.Name='2nd Grade';
--11.What is the total number of poems written by fourth graders?
SELECT COUNT(p.Id) AS FourthGradePoems FROM Poem AS p LEFT JOIN Author AS a ON a.Id=p.AuthorId LEFT JOIN Grade AS g ON g.Id=a.GradeId WHERE g.Name = '4th Grade';
--12.How many poems are there per grade?
SELECT COUNT(p.Id) AS PoemsByGrade , g.Name AS GradeName FROM Poem AS p LEFT JOIN Author AS a ON a.Id=p.AuthorId LEFT JOIN Grade AS g ON g.Id=a.GradeId GROUP BY g.Id , g.Name ORDER BY g.Name; 
--13.How many authors are in each grade? (Order your results by grade starting with 1st Grade)
SELECT COUNT(a.Id) AS AuthorsByGrade , g.Name AS Grade FROM Author AS a LEFT JOIN Grade AS g ON g.Id=a.GradeId GROUP BY g.Id , g.Name ORDER BY g.Name; 
--14.What is the title of the poem that has the most words?
SELECT TOP 1 Title , WordCount FROM Poem ORDER BY WordCount DESC;
--15.Which author(s) have the most poems? (Remember authors can have the same name.)
SELECT DISTINCT 
	Author.Name,
	COUNT(Poem.AuthorId) AS PoemsPerAuthor
FROM Poem
	LEFT JOIN Author ON Poem.AuthorId=Author.Id
GROUP BY Author.Id , Author.Name
ORDER BY PoemsPerAuthor 
	DESC; 
--16.How many poems have an emotion of sadness?
SELECT Count(Poem.Id) AS 'NumSad :('
FROM Poem
	JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
	JOIN Emotion ON Emotion.Id=PoemEmotion.EmotionId
WHERE Emotion.Name='Sadness';
--17.How many poems are not associated with any emotion?
SELECT Count(Poem.Id) AS 'NullPoems'
FROM Poem
	LEFT JOIN PoemEmotion ON PoemEmotion.PoemId = Poem.Id
	LEFT JOIN Emotion ON Emotion.Id=PoemEmotion.EmotionId
WHERE Emotion.Name IS NULL;
--18.Which emotion is associated with the least number of poems?
SELECT TOP 1 COUNT(Poem.Id) AS 'NumPoems' , Emotion.Name
FROM Poem
	JOIN PoemEmotion ON POemEmotion.PoemId = Poem.Id
	JOIN Emotion ON Emotion.Id=PoemEmotion.EmotionId
GROUP BY Emotion.Id , Emotion.Name
ORDER BY NumPoems;
--19.Which grade has the largest number of poems with an emotion of joy?
SELECT TOP 1 COUNT(Poem.Id) AS 'Poems By Emotion By Grade' , Emotion.Name , Grade.Name
FROM Poem
	LEFT JOIN PoemEmotion ON PoemEmotion.PoemId=Poem.Id
	LEFT JOIN Emotion ON Emotion.Id=PoemEmotion.EmotionId
	LEFT JOIN Author ON Author.Id=Poem.AuthorId
	LEFT JOIN Grade On Grade.Id=Author.GradeId
GROUP BY Grade.Id , Grade.Name, Emotion.Name
HAVING Emotion.Name = 'Joy'
ORDER BY 'Poems By Emotion By Grade' DESC;
--20.Which gender has the least number of poems with an emotion of fear?
SELECT TOP 1 COUNT(Poem.Id) AS 'Poems By Emotion By Gender' , Emotion.Name , Gender.Name
FROM Poem
	LEFT JOIN PoemEmotion ON PoemEmotion.PoemId=Poem.Id
	LEFT JOIN Emotion ON Emotion.Id=PoemEmotion.EmotionId
	LEFT JOIN Author ON Author.Id=Poem.AuthorId
	LEFT JOIN Gender On Gender.Id=Author.GenderId
GROUP BY Gender.Id , Gender.Name, Emotion.Name
HAVING Emotion.Name = 'Fear'
ORDER BY 'Poems By Emotion By Gender';