-- Risk
SELECT * 
FROM (SELECT rownum cnt, rsk.*
	  FROM (
			SELECT p.prjname, e.ename, r.*
			FROM risk r, fb_emp e, projectbasic p
			WHERE 1=1
			AND r.riskname like '%'||''||'%'
			AND e.ename like '%'||''||'%'
			AND r.empno = e.empno
			AND p.prjName like '%'||''||'%'
			AND r.prjNo = p.prjNo) rsk
			order by cnt DESC
)
where cnt BETWEEN 1 AND 3;

SELECT *
FROM ( SELECT rownum cnt, pb.*
		FROM (
			  SELECT *
			  FROM PROJECTBASIC
			  WHERE prjname LIKE '%'||''||'%'
			  ORDER BY prjno) pb
		)
WHERE cnt BETWEEN 1 AND 3;
	
SELECT * 
FROM (
	SELECT rownum cnt, r.*
	FROM risk r, fb_emp e, projectbasic p
	WHERE 1=1
	AND r.riskname like '%'||''||'%'
	AND e.ename like '%'||''||'%'
	AND r.empno = e.empno
	AND p.prjName like '%'||''||'%'
	AND r.prjNo = p.prjNo
	order by cnt DESC 
)
where cnt BETWEEN 1 AND 2

SELECT * FROM RISK;
SELECT * FROM PROJECTBASIC;
SELECT * FROM PROJECTTEAM;
SELECT * FROM TEAMMATE;
SELECT * FROM FB_EMP;
INSERT INTO RISK VALUES(RISK_SEQ.NEXTVAL, 2, 10035, '송금 시스템 오류', '은행 계좌 검색 시, 은행 정보가 나오지 않음', '매우 위험', 
						SYSDATE, TO_DATE('2024-06-06', 'YYYY-MM-DD'), '진행중');
INSERT INTO RISK VALUES(RISK_SEQ.NEXTVAL, 5, 10035, '스마트팜 기계 오류', '스마트팜 센서 오류로 인해 기계가 작동하지 않음', NULL, 
						SYSDATE, NULL, '진행중');
					
SELECT * FROM NOTICEFILE;			
CREATE TABLE riskfile(
	fileno NUMBER PRIMARY KEY NOT NULL,
	riskno NUMBER REFERENCES RISK(riskno) NOT NULL,
	fname VARCHAR2(100) NOT NULL,
	path VARCHAR2(500) NOT NULL,
	regdte DATE NOT NULL,
	uptdte DATE NOT NULL,
	etc VARCHAR2(1000) NOT NULL
);
DROP TABLE RISKFILE;
SELECT * FROM RISKFILE;
DELETE FROM RISKFILE WHERE riskno=41;
CREATE SEQUENCE team2.riskfile_seq
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	MAXVALUE 99999;

SELECT risk_seq.currval FROM dual;
SELECT DISTINCT pb.*
FROM PROJECTBASIC pb, PROJECTTEAM pt, TEAMMATE tm
WHERE 1=1
AND pb.PRJNO = pt.PRJNO
AND pt.TEAMNO = tm.TEAMNO
AND tm.EMPNO = 10001;

ALTER TABLE team2.RISK 
ADD CONSTRAINT risk_fb_emp
FOREIGN KEY (EMPNO)
REFERENCES team2.FB_EMP(EMPNO);


-- Calendar
CREATE TABLE calendar(
	calid NUMBER PRIMARY KEY NOT NULL,
	prjno NUMBER REFERENCES PROJECTBASIC(prjno) NOT NULL,
	empno NUMBER REFERENCES FB_EMP(empno) NOT NULL,
	title VARCHAR2(100) NOT NULL,
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	content VARCHAR2(2000) NOT NULL,
	backgroundColor VARCHAR2(7) NOT NULL,
	textColor VARCHAR2(7) NOT NULL,
	allDay NUMBER(1,0) NOT NULL,
	url VARCHAR2(500)
);

SELECT * FROM CALENDAR;
DELETE FROM CALENDAR WHERE calid = 1;

SELECT calid, prjno, empno, title,
	to_char(startDate, 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"') startDate, 
	to_char(endDate, 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"') endDate,
	content, backgroundcolor, textcolor, allday, url 
FROM calendar;

CREATE SEQUENCE team2.calendar_seq
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	MAXVALUE 99999;

INSERT INTO CALENDAR VALUES(calendar_seq.nextval, 1, 10001, '요구사항 정의서 작성', 
							TO_DATE('2024-01-01', 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"'),
							TO_DATE('2024-02-29', 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"'),
							'캘린더 요구사항 정의서 작성 완료 하기', '#FFFFFF', '#3C5A93', '1', '');
);

SELECT DISTINCT pb.*
FROM PROJECTBASIC pb, PROJECTTEAM pt, TEAMMATE tm
WHERE 1=1
AND pb.PRJNO = pt.PRJNO 
AND pt.TEAMNO = tm.TEAMNO 
AND tm.EMPNO = 10001;

SELECT calid, prjno, empno, title,
	to_char(startDate, 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"') startDate, 
	to_char(endDate, 'YYYY-MM-DD"T"HH24:MI:SS"+09:00"') endDate,
	content, backgroundcolor, textcolor, allday, url 
FROM calendar
WHERE empno=10001;

SELECT * FROM PROJECTBASIC;
SELECT * FROM TEAMMATE;
SELECT * FROM PROJECTTEAM;
INSERT INTO TEAMMATE VALUES(teammem_seq.nextval, 4, 10035, '개발자');
ALTER TABLE TEAMMATE ADD taskno NUMBER;

SELECT * FROM TASK;

SELECT *
FROM ( SELECT rownum cnt, pb.*
		FROM (
			  SELECT *
			  FROM TASK t
			  JOIN PROJECTBASIC p ON p.PRJNO = t.TASKPARENT
			  JOIN PROJECTTEAM pt ON t.TASKPARENT = pt.PRJNO
			  JOIN TEAMMATE tm ON pt.TEAMNO = tm.TEAMNO
			  WHERE TASKNAME LIKE '%' || '' || '%'
			  AND tm.EMPNO = ''
			  ORDER BY t.TASKNO) pb
		)
WHERE cnt BETWEEN 1 AND 3;

CREATE SEQUENCE team2.task_seq
	INCREMENT BY 1
	START WITH 1
	MINVALUE 1
	MAXVALUE 9999999999;
DROP SEQUENCE team2.task_seq;
