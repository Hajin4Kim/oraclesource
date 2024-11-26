-- review 에서만 부를 때
--ORA-00979: GROUP BY 표현식이 아닙니다.
SELECT
	m.MNO, AVG(r.GRADE), COUNT(r.RNO) 
FROM
	MOVIE m 
	LEFT JOIN REVIEW r ON m.MNO  = r.MOVIE_MNO 
GROUP BY m.MNO; 

-- movie, review 조인
-- mno, title, regdate(movie)
-- review 수, 평균(review)
SELECT
	m.MNO,
	m.TITLE,
	m.REGDATE,
	review.MOVIE_MNO ,
	review.avg,
	review.count,
	m.REGDATE 
FROM
	MOVIE m
LEFT JOIN (
SELECT
	r.MOVIE_MNO AS movie_mno,
	AVG(r.GRADE) AS avg,
	COUNT(r.grade) AS count
FROM
	REVIEW r
GROUP BY
	r.MOVIE_MNO) review ON
m.MNO = review.MOVIE_MNO; 


-- @Query 가 만들어준
 select
        m1_0.mno,
        m1_0.regdate,
        m1_0.title,
        m1_0.updatedate,
        avg(r1_0.grade),
        count(distinct r1_0.rno) 
    from
        movie m1_0 
    left join
        review r1_0 
            on r1_0.movie_mno=m1_0.mno 
    group by
        m1_0.mno,
        m1_0.regdate,
        m1_0.title,
        m1_0.updatedate 
    order by
        m1_0.mno DESC;

-- movie, review, movie_image 조인 or 서브쿼리
-- mno, title, regdate(movie)
-- review 수, 평균(review)
-- inum, path, uuid, img_name    max(inum) 기준  movie_mno

-- (movie 와 member) 서브쿼리 방법
SELECT
	m.MNO,
	m.TITLE,
	m.REGDATE,
	(SELECT AVG(r.grade) FROM REVIEW r WHERE r.MOVIE_MNO = m.MNO ) avg,
	(SELECT COUNT(r.rno) FROM REVIEW r WHERE r.MOVIE_MNO = m.MNO) cnt, mi2.IMG_NAME, mi2.INUM, mi2."PATH", mi2.UUID 
FROM
	MOVIE m LEFT JOIN MOVIE_IMAGE mi2 ON m.MNO = mi2.MOVIE_MNO 
WHERE mi2.inum IN (SELECT MAX(mi.inum) FROM MOVIE_IMAGE mi GROUP BY mi.movie_mno);































































































