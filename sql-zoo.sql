/*
Joseph P. Pasaoa
SQL Zoo Lab
*/


-- -- -- 0 SELECT basics
-- 

-- 1
SELECT population
FROM world
WHERE name = 'Germany';

-- 2
SELECT name
   , population
FROM world
WHERE name IN (
   'Sweden'
   , 'Norway'
   , 'Denmark'
   );

-- 3
SELECT name
   , area
FROM world
WHERE area BETWEEN 200000
   AND 250000;


-- -- -- 1 SELECT name
-- 

-- 1
SELECT name
FROM world
WHERE name LIKE 'Y%';

-- 2
SELECT name
FROM world
WHERE name LIKE '%y';

-- 3
SELECT name
FROM world
WHERE name LIKE '%x%';

-- 4
SELECT name
FROM world
WHERE name LIKE '%land';

-- 5
SELECT name
FROM world
WHERE name LIKE 'C%ia';

-- 6
SELECT name
FROM world
WHERE name LIKE '%oo%';

-- 7
SELECT name
FROM world
WHERE name LIKE '%a%a%a%';

-- 8
SELECT name
FROM world
WHERE name LIKE '_t%';

-- 9
SELECT name
FROM world
WHERE name LIKE '%o__o%';

-- 10
SELECT name
FROM world
WHERE name LIKE '____';

-- HARD 11
SELECT name
FROM world
WHERE name = capital;

-- HARD 12
SELECT name
FROM world
WHERE capital LIKE CONCAT (
   name
   , '%City'
   );

-- HARD 13
SELECT capital 
   , name
FROM world
WHERE capital LIKE CONCAT (
   '%'
   , name
   , '%'
   );

-- HARD 14
SELECT capital
   , name
FROM world
WHERE capital LIKE CONCAT (
   name
   , '_%'
   );

-- HARD 15
SELECT name
   , REPLACE(capital, name, '')
FROM world
WHERE capital LIKE CONCAT (
      name
      , '_%'
      );


-- -- -- 2 SELECT from World
--

-- 1
SELECT name
   , continent
   , population
FROM world;

-- 2
SELECT name
FROM world
WHERE population > 200000000;

-- 3
SELECT name
   , GDP / population
FROM world
WHERE population > 200000000;

-- 4
SELECT name
   , population / 1000000
FROM world
WHERE continent = 'South America';

-- 5
SELECT name
   , population
FROM world
WHERE name IN (
   'France'
   , 'Germany'
   , 'Italy'
   );

-- 6
SELECT name
FROM world
WHERE name LIKE '%United%';

-- 7
SELECT name
   , population
   , area
FROM world
WHERE area > 3000000
   OR population > 250000000;

-- 8
SELECT name
   , population
   , area
FROM world
WHERE area > 3000000
   XOR population > 250000000;

-- 9
SELECT name
   , ROUND(population / 1000000, 2)
   , ROUND(GDP / 1000000000, 2)
FROM world
WHERE continent = 'South America';

-- 10
SELECT name
   , ROUND(GDP / population, -3)
FROM world
WHERE GDP > 1000000000000;

-- 11
SELECT name
   , capital
FROM world
WHERE LENGTH(name) = LENGTH(capital);

-- 12
SELECT name
   , capital
FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1)
   AND name <> capital;

-- 13
SELECT name
FROM world
WHERE name NOT LIKE '% %'
   AND name LIKE '%a%'
   AND name LIKE '%e%'
   AND name LIKE '%i%'
   AND name LIKE '%o%'
   AND name LIKE '%u%';


-- -- -- 3 SELECT from Nobel
--

-- 1
SELECT yr
   , subject
   , winner
FROM nobel
WHERE yr = 1950;

-- 2
SELECT winner
FROM nobel
WHERE yr = 1962
   AND subject = 'Literature';

-- 3
SELECT yr
   , subject
FROM nobel
WHERE winner = 'Albert Einstein';

-- 4
SELECT winner
FROM nobel
WHERE yr >= 2000
   AND subject = 'Peace';

-- 5
SELECT *
FROM nobel
WHERE subject = 'Literature'
   AND yr >= 1980
   AND yr <= 1989;

-- 6
SELECT *
FROM nobel
WHERE winner IN (
   'Theodore Roosevelt'
   , 'Woodrow Wilson'
   , 'Jimmy Carter'
   , 'Barack Obama'
   );

-- 7
SELECT winner
FROM nobel
WHERE winner LIKE 'John_%';

-- 8
SELECT yr
   , subject
   , winner
FROM nobel
WHERE yr = 1980
   AND subject = 'Physics'
   XOR subject = 'Chemistry'
   AND yr = 1984;

-- 9
SELECT yr
   , subject
   , winner
FROM nobel
WHERE yr = 1980
   AND subject <> 'Chemistry'
   AND subject <> 'Medicine';

-- 10
SELECT yr
   , subject
   , winner
FROM nobel
WHERE subject = 'Medicine'
   AND yr < 1910
   OR subject = 'Literature'
   AND yr >= 2004;

-- HARD 11
SELECT *
FROM nobel
WHERE winner = 'Peter Grünberg';

-- HARD 12
SELECT *
FROM nobel
WHERE winner = 'Eugene O''Neill';

-- HARD 13
SELECT winner
   , yr
   , subject
FROM nobel
WHERE winner LIKE 'Sir_%'
ORDER BY yr DESC;

-- HARD 14
SELECT winner
   , subject
FROM nobel
WHERE yr = 1984
ORDER BY subject IN (
      'Chemistry'
      , 'Physics'
      ) ASC
   , subject ASC
   , winner ASC;


-- -- -- 4 SELECT within SELECT
--

-- 1
SELECT name
FROM world
WHERE population > (
      SELECT population
      FROM world
      WHERE name = 'Russia'
      );

-- 2
SELECT name
FROM world
WHERE continent = 'Europe'
   AND gdp / population > (
      SELECT gdp / population
      FROM world
      WHERE name = 'United Kingdom'
      );

-- 3
SELECT name
   , continent
FROM world
WHERE continent IN (
      SELECT continent
      FROM world
      WHERE name IN (
            'Argentina'
            , 'Australia'
            )
      )
ORDER BY name ASC;

-- 4
SELECT name
   , population
FROM world
WHERE population > (
      SELECT population
      FROM world
      WHERE name = 'Canada'
      )
   AND population < (
      SELECT population
      FROM world
      WHERE name = 'Poland'
      );

-- 5
SELECT name
   , CONCAT (
      ROUND((
            population / (
               SELECT population
               FROM world
               WHERE name = 'Germany'
               ) * 100
            ), 0)
      , '%'
      )
FROM world
WHERE continent = 'Europe';
   
-- 6
SELECT name
FROM world
WHERE gdp > ALL (
      SELECT gdp
      FROM world
      WHERE gdp > 0
         AND continent = 'Europe'
      );

-- 7
SELECT continent
   , name
   , area
FROM world x
WHERE area >= ALL (
      SELECT area
      FROM world y
      WHERE y.continent = x.continent
         AND area > .0
      );

-- 8
SELECT continent
   , name
FROM world x
WHERE name <= ALL (
      SELECT name
      FROM world y
      WHERE y.continent = x.continent
      );

-- DIFFICULT 9
SELECT name
   , continent
   , population
FROM world x
WHERE 25000000 >= ALL (
      SELECT population
      FROM world y
      WHERE y.continent = x.continent
      );

-- DIFFICULT 10
SELECT name
   , continent
FROM world x
WHERE population / 3 >= ALL (
      SELECT population
      FROM world y
      WHERE y.continent = x.continent
         AND y.name <> x.name
      );


-- -- -- 5 SUM and COUNT
--

-- 1
SELECT SUM(population)
FROM world;

-- 2
SELECT DISTINCT continent
FROM world;

-- 3
SELECT SUM(gdp)
FROM world
WHERE continent = 'Africa';

-- 4
SELECT COUNT(name)
FROM world
WHERE area > 1000000;

-- 5
SELECT SUM(population)
FROM world
WHERE name IN (
      'Estonia'
      , 'Latvia'
      , 'Lithuania'
      );

-- 6
SELECT continent
   , COUNT(*)
FROM world
GROUP BY continent;

-- 7
SELECT continent
   , COUNT(*)
FROM world
WHERE population > 10000000
GROUP BY continent;

-- 8
SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000;


-- -- -- 6 JOIN
--

-- 1
SELECT matchid
   , player
FROM goal 
WHERE teamid = 'GER';

-- 2
SELECT id
   , stadium
   , team1
   , team2
FROM game
WHERE id = 1012;

-- 3
SELECT player
   , teamid
   , stadium
   , mdate
FROM game
JOIN goal ON (id = matchid)
WHERE teamid = 'GER';

-- 4
SELECT team1
   , team2
   , player
FROM game
JOIN goal ON (id = matchid)
WHERE player LIKE 'Mario%';


-- 5
SELECT player
   , teamid
   , coach
   , gtime
FROM goal
JOIN eteam ON (teamid = id)
WHERE gtime <= 10;

-- 6
SELECT mdate
   , teamname
FROM game
JOIN eteam ON (team1 = eteam.id)
WHERE coach = 'Fernando Santos';

-- 7
SELECT player
FROM game
JOIN goal ON (matchid = id)
WHERE stadium = 'National Stadium, Warsaw';

-- HARD 8
SELECT DISTINCT player
FROM game
JOIN goal ON (matchid = id)
WHERE (
      team1 = 'GER'
      OR team2 = 'GER'
      )
   AND teamid <> 'GER';

-- HARD 9
SELECT teamname
   , COUNT(*)
FROM eteam
JOIN goal ON (id = teamid)
GROUP BY teamname;

-- HARD 10
SELECT stadium
   , COUNT(*)
FROM game
JOIN goal ON (matchid = id)
GROUP BY stadium;

-- HARD 11
SELECT matchid
   , mdate
   , COUNT(*)
FROM game
JOIN goal ON (matchid = id)
WHERE team1 = 'POL'
   OR team2 = 'POL'
GROUP BY matchid
   , mdate;

-- HARD 12
SELECT matchid
   , mdate
   , COUNT(*)
FROM game
JOIN goal ON (matchid = id)
WHERE teamid = 'GER'
GROUP BY matchid
   , mdate;

-- HARD 13
SELECT mdate
   , team1
   , SUM(CASE 
         WHEN team1 = teamid
            THEN 1
         ELSE 0
         END) AS score1
   , team2
   , SUM(CASE 
         WHEN team2 = teamid
            THEN 1
         ELSE 0
         END) AS score2
FROM game
LEFT OUTER JOIN goal ON (matchid = id)
GROUP BY mdate
   , team1
   , team2
ORDER BY mdate ASC
   , matchid ASC
   , team1 ASC
   , team2 ASC;


-- -- -- 7 More JOIN operations
--

-- 1
SELECT id
   , title
FROM movie
WHERE yr = 1962;

-- 2
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

-- 3
SELECT id
   , title
   , yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr ASC;

-- 4
SELECT id
FROM actor
WHERE name = 'Glenn Close';

-- 5
SELECT id
FROM movie
WHERE title = 'Casablanca';

-- 6
SELECT name
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE title = 'Casablanca';

-- 7
SELECT name
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE title = 'Alien';

-- 8
SELECT title
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE name = 'Harrison Ford'; 

-- 9
SELECT title
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE name = 'Harrison Ford'
   AND ord <> 1;

-- 10
SELECT title
   , name
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE yr = 1962
   AND ord = 1;

-- HARDER 11
SELECT yr
   , COUNT(title)
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- HARDER 12
SELECT title
   , name
FROM movie
JOIN casting ON (movie.id = movieid)
JOIN actor ON (casting.actorid = actor.id)
WHERE movieid IN (
      SELECT movieid
      FROM actor
      JOIN casting ON (id = actorid)
      WHERE name = 'Julie Andrews'
      )
   AND ord = 1;

-- HARDER 13
SELECT DISTINCT name
FROM actor
JOIN casting ON (id = actorid)
WHERE id IN (
      SELECT actorid
      FROM casting
      WHERE ord = 1
      GROUP BY actorid ASC
      HAVING COUNT(*) >= 30
      )
ORDER BY name ASC;

-- HARDER 14
SELECT title
   , COUNT(actorid)
FROM movie
JOIN casting ON (id = movieid)
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(*) DESC
   , title ASC;

-- HARDER 15
SELECT DISTINCT name
FROM casting
JOIN actor ON (actorid = id)
WHERE movieid IN (
      SELECT movieid
      FROM casting
      JOIN actor ON (actorid = id)
      WHERE name = 'Art Garfunkel'
      )
   AND name <> 'Art Garfunkel';


-- -- -- 8 Using Null
--

-- 1
SELECT name
FROM teacher
WHERE dept IS NULL;

-- 2
SELECT teacher.name
   , dept.name
FROM teacher
INNER JOIN dept ON (teacher.dept = dept.id);

-- 3
SELECT teacher.name
   , dept.name
FROM teacher
LEFT OUTER JOIN dept ON (teacher.dept = dept.id);

-- 4
SELECT teacher.name
   , dept.name
FROM dept
LEFT OUTER JOIN teacher ON (teacher.dept = dept.id);

-- 5
SELECT name
   , COALESCE(mobile, '07986 444 2266')
FROM teacher;

-- 6
SELECT teacher.name
   , COALESCE(dept.name, 'None')
FROM teacher
LEFT JOIN dept ON (teacher.dept = dept.id);

-- 7
SELECT COUNT(DISTINCT teacher.name)
   , COUNT(DISTINCT mobile)
FROM teacher;

-- 8
SELECT dept.name
   , COUNT(teacher.name)
FROM teacher
RIGHT JOIN dept ON (teacher.dept = dept.id)
GROUP BY dept.name;

-- 9
SELECT teacher.name
   , CASE 
      WHEN teacher.dept IN (
            1
            , 2
            )
         THEN 'Sci'
      ELSE 'Art'
      END
FROM teacher;

-- 10
SELECT teacher.name
   , CASE 
      WHEN teacher.dept IN (
            1
            , 2
            )
         THEN 'Sci'
      WHEN teacher.dept = 3
         THEN 'Art'
      ELSE 'None'
      END
FROM teacher;


-- -- -- 8+ Numeric Examples
--

-- 1
SELECT A_STRONGLY_AGREE
FROM nss
WHERE question = 'Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science';

-- 2
SELECT institution
   , subject
FROM nss
WHERE question = 'Q15'
   AND score >= 100;

-- 3
SELECT institution
   , score
FROM nss
WHERE question = 'Q15'
   AND subject = '(8) Computer Science'
   AND score < 50


-- 4
SELECT subject
   , SUM(response)
FROM nss
WHERE question = 'Q22'
   AND subject IN (
      '(8) Computer Science'
      , '(H) Creative Arts and Design'
      )
GROUP BY subject;

-- 5
SELECT subject
   , SUM(response * A_STRONGLY_AGREE / 100)
FROM nss
WHERE question='Q22'
   AND subject IN (
      '(8) Computer Science'
      , '(H) Creative Arts and Design'
      );

-- 6
SELECT subject
   , ROUND(SUM(response * A_STRONGLY_AGREE / 100) / SUM(response) * 100, 0)
FROM nss
WHERE question = 'Q22'
   AND subject IN (
      '(8) Computer Science'
      , '(H) Creative Arts and Design'
      )
GROUP BY subject;

-- 7
SELECT institution
   , ROUND(AVG(score), 0)
FROM nss
WHERE question = 'Q22'
   AND institution LIKE '%Manchester%'
GROUP BY institution;

-- 8
SELECT institution
   , SUM(sample)
   , (
      SELECT sample
      FROM nss y
      WHERE subject = '(8) Computer Science'
         AND x.institution = y.institution
         AND question = 'Q01'
      ) AS comp
FROM nss x
WHERE question = 'Q01'
   AND (institution LIKE '%Manchester%')
GROUP BY institution;


-- -- -- 9 Self join
--

-- 1
SELECT COUNT(*)
FROM stops;

-- 2
SELECT id
FROM stops
WHERE name = 'Craiglockhart';

-- 3
SELECT id
   , name
FROM route
JOIN stops ON (id = stop)
WHERE num = '4'
   AND company = 'LRT';

-- 4
SELECT company
   , num
   , COUNT(*)
FROM route
WHERE stop IN (
   149
   , 53
   )
GROUP BY company
   , num
HAVING COUNT(*) = 2;

-- 5
SELECT a.company
   , a.num
   , a.stop
   , b.stop
FROM route a
JOIN route b ON (
      a.company = b.company
      AND a.num = b.num
      )
WHERE a.stop = 53
   AND b.stop = 149;

-- 6
-- 7
-- 8
-- 9
-- 10

