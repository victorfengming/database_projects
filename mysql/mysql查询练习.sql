-- mysql 查询练习


-- mysql最重要的就是查询,也是面试中比较重要的

-- 学生表
    -- Student
    -- 学号
    -- 姓名
    -- 性别
    -- 出生年月日
    -- 所在班级

create table student(
    sno varchar(20) primary key,
    sname varchar(20) not null,
    ssex varchar(10) not null,
    sbirthday datetime,
    class varchar(20)
);

-- 教师表
    -- Teacher
    -- 教师编号
    -- 教师名字
    -- 教师性别
    -- 出生年月日
    -- 职称
    -- 所在部门
create table teacher(
    tno varchar(20) primary key,
    tname varchar(20) not null,
    tsex varchar(20) not null,
    tbirthday datetime,
    prof varchar(20) not null,
    depart varchar(20) not null
);

-- 课程表
    -- Course
    -- 课程号
    -- 课程名称
    -- 教师编号

create table course(
    cno varchar(20) primary key,
    cname varchar(20) not null,
    tno varchar(20) not null,
    foreign key(tno) references teacher(tno)
); 

-- 成绩表
    -- Score
    -- 学号
    -- 课程号
    -- 成绩

create table score(
    sno varchar(20) not null,
    cno varchar(20) not null,
    degree decimal,
    foreign key(sno) references student(sno),
    foreign key(cno) references course(cno),
    primary key(sno, cno)
);    

select * from student;
select * from teacher;
select * from score;
select * from course;

MariaDB [selectTest]> 
MariaDB [selectTest]> select * from student;
Empty set (0.00 sec)

MariaDB [selectTest]> select * from teacher;
Empty set (0.00 sec)

MariaDB [selectTest]> select * from score;
Empty set (0.00 sec)

MariaDB [selectTest]> select * from course;
Empty set (0.00 sec)

-- 查看表中的数据
-- 数据均为空


-- 往表中添加数据
-- 添加学生信息
insert into student values('108','曾华','男','1977-09-01','95033');
insert into student values('105','框明','男','1975-10-02','95031');
insert into student values('106','框大明','男','1977-10-02','95036');
insert into student values('107','王丽','女','1976-01-23','95033');
insert into student values('101','李军','男','1976-02-20','95033');
insert into student values('102','李往军','男','1976-02-20','95033');
insert into student values('109','王芳','女','1975-02-10','95031');
insert into student values('103','陆军','男','1974-06-03','95031');
insert into student values('104','陆小军','男','1978-06-03','95031');

-- 添加教师表
insert into teacher values('804','alice','男','1958-12-02','副教授','计算机系');
insert into teacher values('856','nineberg','男','1968-03-12','讲师','电子工程系');
insert into teacher values('825','pign','女','1969-03-12','助教','计算机系');
insert into teacher values('831','bingl','女','1977-08-14','助教','电子工程系');

-- 添加课程表
insert into course values('3-105','计算机导论','825');
insert into course values('3-245','操作系统','804');
insert into course values('6-166','数字电路','856');
insert into course values('9-888','高等数学','831');

-- 添加成绩表
insert into score values('103','3-245','86');
insert into score values('105','3-245','75');
insert into score values('104','3-105','72');
insert into score values('107','6-166','86');
insert into score values('102','6-166','85');
insert into score values('109','6-166','63');

insert into score values('109','3-105','78');




-- 查询练习

-- 1. 查询student表的所有记录.

MariaDB [selectTest]> select * from student;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 106 | 框大明    | 男   | 1977-10-02 00:00:00 | 95036 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

-- 2. 查询student表中所有记录的sname,ssex和class列

MariaDB [selectTest]> select sname, ssex, class from student;
+-----------+------+-------+
| sname     | ssex | class |
+-----------+------+-------+
| 李军      | 男   | 95033 |
| 李往军    | 男   | 95033 |
| 陆军      | 男   | 95031 |
| 陆小军    | 男   | 95031 |
| 框明      | 男   | 95031 |
| 框大明    | 男   | 95036 |
| 王丽      | 女   | 95033 |
| 曾华      | 男   | 95033 |
| 王芳      | 女   | 95031 |
+-----------+------+-------+
9 rows in set (0.00 sec)

-- 3. 查询教师所有的单位即不重复的depart列.

MariaDB [selectTest]> select depart from teacher;
+-----------------+
| depart          |
+-----------------+
| 计算机系        |
| 计算机系        |
| 电子工程系      |
| 电子工程系      |
+-----------------+
4 rows in set (0.00 sec)

-- 排除重复--distinct

MariaDB [selectTest]> select distinct depart from teacher;
+-----------------+
| depart          |
+-----------------+
| 计算机系        |
| 电子工程系      |
+-----------------+
2 rows in set (0.00 sec)

-- 4. 查询score表中成绩在60到80之间的所有记录.

-- 查询区间 between... and ...

MariaDB [selectTest]> select * from score where degree between 60 and 80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
3 rows in set (0.01 sec)

-- 还有一种方式

MariaDB [selectTest]> select * from score where degree > 60 and degree < 80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
3 rows in set (0.00 sec)

-- 5. 查询Score表中成绩为85,86或88 的记录
-- 表示或者关系查询 in

MariaDB [selectTest]> select * from score where degree in(85,86,88);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 107 | 6-166 |     86 |
+-----+-------+--------+
3 rows in set (0.00 sec)

-- 6. 查询student表中"95031"班或性别为女的同学记录.

-- 在不同的字段之间或者
MariaDB [selectTest]> select * from student where class='95031' or ssex="女";
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
5 rows in set (0.00 sec)

-- 7. 以class降序查询student表的所有记录
-- 升序,降序
-- 降序排列
MariaDB [selectTest]> select * from student order by class desc;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 106 | 框大明    | 男   | 1977-10-02 00:00:00 | 95036 |
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

-- 如果是生序排序可以省略asc
MariaDB [selectTest]> select * from student order by class asc;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 106 | 框大明    | 男   | 1977-10-02 00:00:00 | 95036 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

-- 8. 以cno为升序,degree降序查询score表的所有记录

MariaDB [selectTest]> select * from score order by cno asc,degree desc;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 104 | 3-105 |     72 |
| 103 | 3-245 |     86 |
| 105 | 3-245 |     75 |
| 107 | 6-166 |     86 |
| 102 | 6-166 |     85 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
6 rows in set (0.00 sec)

-- 9. 查询"95031"班的学生人数.
-- 统计 count
MariaDB [selectTest]> select count(*) from student where class="95031";
+----------+
| count(*) |
+----------+
|        4 |
+----------+
1 row in set (0.00 sec)

-- 10. 查询score表中的最高分的学生学号的学生学号和课程号.(子查询或者排序)
select sno, cno from score where degree=(select max(degree) from score);

MariaDB [selectTest]> select sno, cno from score where degree=(select max(degree) from score);
+-----+-------+
| sno | cno   |
+-----+-------+
| 103 | 3-245 |
| 107 | 6-166 |
+-----+-------+
2 rows in set (0.01 sec)

-- 1 找到最高分
select max(degree) from score;
-- 2 找最高分的sno和cno
select sno,cno from score where degree=(select max(degree) from score);

-- 排序的做法:
MariaDB [selectTest]> select sno, cno, degree from score order by degree;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 109 | 6-166 |     63 |
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 107 | 6-166 |     86 |
+-----+-------+--------+
6 rows in set (0.00 sec)

-- 加上限制
-- limit 第一个数字表示从多少开始
-- 第二个数字表示差多少条
MariaDB [selectTest]> select sno, cno, degree from score order by degree limit 0,1;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 109 | 6-166 |     63 |
+-----+-------+--------+
1 row in set (0.00 sec)


-- 11. 查询没门课程的平均成绩
-- avg()
-- 先查有多少门
MariaDB [selectTest]> select * from course;
+-------+-----------------+-----+
| cno   | cname           | tno |
+-------+-----------------+-----+
| 3-105 | 计算机导论      | 825 |
| 3-245 | 操作系统        | 804 |
| 6-166 | 数字电路        | 856 |
| 9-888 | 高等数学        | 831 |
+-------+-----------------+-----+
4 rows in set (0.01 sec)
-- 差平均成绩
MariaDB [selectTest]> select avg(degree) from score where cno='3-105';
+-------------+
| avg(degree) |
+-------------+
|     72.0000 |
+-------------+
1 row in set (0.00 sec)
-- 如何验证呢,我们可以将3-105的全部选出来
MariaDB [selectTest]> select degree from score where cno='3-105';
+--------+
| degree |
+--------+
|     72 |
+--------+
1 row in set (0.00 sec)
-- 我能不能在一个sql语句中写呢
-- group by 分组
MariaDB [selectTest]> select cno,avg(degree) from score group by cno;
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     72.0000 |
| 3-245 |     80.5000 |
| 6-166 |     78.0000 |
+-------+-------------+
3 rows in set (0.00 sec)

-- 12, 查询score表中至少有5名学生选修的并以3开头的课程的平均分数.

MariaDB [selectTest]> select cno from score group by cno having count(cno)>=2;
+-------+
| cno   |
+-------+
| 3-245 |
| 6-166 |
+-------+
2 rows in set (0.00 sec)
-- 然后加上3开头的模糊查询
MariaDB [selectTest]> select cno from score group by cno having count(cno)>=2 and cno like "3%";
+-------+
| cno   |
+-------+
| 3-245 |
+-------+
1 row in set (0.00 sec)
--然后在加上平均分
MariaDB [selectTest]> select cno, avg(degree) from score group by cno having count(cno)>=2 and cno like "3%";
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-245 |     80.5000 |
+-------+-------------+
1 row in set (0.00 sec)
-- 究竟有几个人
MariaDB [selectTest]> select cno, avg(degree), count(*) from score group by cno having count(cno)>=2 and cno like "3%";
+-------+-------------+----------+
| cno   | avg(degree) | count(*) |
+-------+-------------+----------+
| 3-245 |     80.5000 |        2 |
+-------+-------------+----------+
1 row in set (0.00 sec)

-- 13, 查询分数大于70,小于90的sno列.

MariaDB [selectTest]> select sno, degree from score where degree>70 and degree<90;
+-----+--------+
| sno | degree |
+-----+--------+
| 102 |     85 |
| 103 |     86 |
| 104 |     72 |
| 105 |     75 |
| 107 |     86 |
+-----+--------+
5 rows in set (0.00 sec)
-- 另一种方式
MariaDB [selectTest]> select sno, degree from score where degree between 70 and 90;
+-----+--------+
| sno | degree |
+-----+--------+
| 102 |     85 |
| 103 |     86 |
| 104 |     72 |
| 105 |     75 |
| 107 |     86 |
+-----+--------+
5 rows in set (0.00 sec)

-- 14, 查询所有学生的sname, cno和degree列,
-- 先差一下名字
MariaDB [selectTest]> select sname from student;
+-----------+
| sname     |
+-----------+
| 李军      |
| 李往军    |
| 陆军      |
| 陆小军    |
| 框明      |
| 框大明    |
| 王丽      |
| 曾华      |
| 王芳      |
+-----------+
9 rows in set (0.00 sec)

-- 在查一下分数
MariaDB [selectTest]> select cno, degree from score;
+-------+--------+
| cno   | degree |
+-------+--------+
| 6-166 |     85 |
| 3-245 |     86 |
| 3-105 |     72 |
| 3-245 |     75 |
| 6-166 |     86 |
| 6-166 |     63 |
+-------+--------+
6 rows in set (0.00 sec)


-- 带有学号的查询
MariaDB [selectTest]> select sno,sname from student;
+-----+-----------+
| sno | sname     |
+-----+-----------+
| 101 | 李军      |
| 102 | 李往军    |
| 103 | 陆军      |
| 104 | 陆小军    |
| 105 | 框明      |
| 106 | 框大明    |
| 107 | 王丽      |
| 108 | 曾华      |
| 109 | 王芳      |
+-----+-----------+
9 rows in set (0.00 sec)

MariaDB [selectTest]> select sno,cno, degree from score;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 107 | 6-166 |     86 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
6 rows in set (0.00 sec)
-- 多表查询的组合
MariaDB [selectTest]> select sname,cno,degree from student,score where student.sno=score.sno;
+-----------+-------+--------+
| sname     | cno   | degree |
+-----------+-------+--------+
| 李往军    | 6-166 |     85 |
| 陆军      | 3-245 |     86 |
| 陆小军    | 3-105 |     72 |
| 框明      | 3-245 |     75 |
| 王丽      | 6-166 |     86 |
| 王芳      | 6-166 |     63 |
+-----------+-------+--------+
6 rows in set (0.00 sec)


-- 15, 查询所有学生的sno,cname和degree列.
MariaDB [selectTest]> select cno, cname from course;
+-------+-----------------+
| cno   | cname           |
+-------+-----------------+
| 3-105 | 计算机导论      |
| 3-245 | 操作系统        |
| 6-166 | 数字电路        |
| 9-888 | 高等数学        |
+-------+-----------------+
4 rows in set (0.00 sec)


MariaDB [selectTest]> select cno, sno, degree from score;
+-------+-----+--------+
| cno   | sno | degree |
+-------+-----+--------+
| 6-166 | 102 |     85 |
| 3-245 | 103 |     86 |
| 3-105 | 104 |     72 |
| 3-245 | 105 |     75 |
| 6-166 | 107 |     86 |
| 6-166 | 109 |     63 |
+-------+-----+--------+
6 rows in set (0.00 sec)

-- 将cno 相等的位置用cname去表示就OK了
MariaDB [selectTest]> select sno,cname,degree from course,score where course.cno = score.cno;
+-----+-----------------+--------+
| sno | cname           | degree |
+-----+-----------------+--------+
| 102 | 数字电路        |     85 |
| 103 | 操作系统        |     86 |
| 104 | 计算机导论      |     72 |
| 105 | 操作系统        |     75 |
| 107 | 数字电路        |     86 |
| 109 | 数字电路        |     63 |
+-----+-----------------+--------+
6 rows in set (0.00 sec)

-- 16, 查询所有学生的sname, cname和degree列
-- 这个问题的字段分别来自于三个表格,还是多表查询,核心在于course起到的一个桥梁作用
-- sname -> student
-- cname -> course
-- degree -> score
MariaDB [selectTest]> select sname, cname, degree from student, course, score where student.sno = score.sno and course.cno = score.cno;
+-----------+-----------------+--------+
| sname     | cname           | degree |
+-----------+-----------------+--------+
| 陆小军    | 计算机导论      |     72 |
| 陆军      | 操作系统        |     86 |
| 框明      | 操作系统        |     75 |
| 李往军    | 数字电路        |     85 |
| 王丽      | 数字电路        |     86 |
| 王芳      | 数字电路        |     63 |
+-----------+-----------------+--------+
6 rows in set (0.00 sec)


MariaDB [selectTest]> select sname, cname, degree, student.sno, course.cno from student, course, score where student.sno = score.sno and course.cno = score.cno;
+-----------+-----------------+--------+-----+-------+
| sname     | cname           | degree | sno | cno   |
+-----------+-----------------+--------+-----+-------+
| 陆小军    | 计算机导论      |     72 | 104 | 3-105 |
| 陆军      | 操作系统        |     86 | 103 | 3-245 |
| 框明      | 操作系统        |     75 | 105 | 3-245 |
| 李往军    | 数字电路        |     85 | 102 | 6-166 |
| 王丽      | 数字电路        |     86 | 107 | 6-166 |
| 王芳      | 数字电路        |     63 | 109 | 6-166 |
+-----------+-----------------+--------+-----+-------+
6 rows in set (0.00 sec)

MariaDB [selectTest]> select sname, cname, degree, student.sno as stu_sno, course.cno as cou_cno from student, course, score where student.sno = score.sno and course.cno = score.cno;
+-----------+-----------------+--------+---------+---------+
| sname     | cname           | degree | stu_sno | cou_cno |
+-----------+-----------------+--------+---------+---------+
| 陆小军    | 计算机导论      |     72 | 104     | 3-105   |
| 陆军      | 操作系统        |     86 | 103     | 3-245   |
| 框明      | 操作系统        |     75 | 105     | 3-245   |
| 李往军    | 数字电路        |     85 | 102     | 6-166   |
| 王丽      | 数字电路        |     86 | 107     | 6-166   |
| 王芳      | 数字电路        |     63 | 109     | 6-166   |
+-----------+-----------------+--------+---------+---------+
6 rows in set (0.00 sec)

MariaDB [selectTest]> select sname, cname, degree, student.sno as stu_sno, score.sno, course.cno as cou_cno, score.cno from student, course, score where student.sno = score.sno and course.cno = score.cno
    -> ;
+-----------+-----------------+--------+---------+-----+---------+-------+
| sname     | cname           | degree | stu_sno | sno | cou_cno | cno   |
+-----------+-----------------+--------+---------+-----+---------+-------+
| 陆小军    | 计算机导论      |     72 | 104     | 104 | 3-105   | 3-105 |
| 陆军      | 操作系统        |     86 | 103     | 103 | 3-245   | 3-245 |
| 框明      | 操作系统        |     75 | 105     | 105 | 3-245   | 3-245 |
| 李往军    | 数字电路        |     85 | 102     | 102 | 6-166   | 6-166 |
| 王丽      | 数字电路        |     86 | 107     | 107 | 6-166   | 6-166 |
| 王芳      | 数字电路        |     63 | 109     | 109 | 6-166   | 6-166 |
+-----------+-----------------+--------+---------+-----+---------+-------+
6 rows in set (0.00 sec)


-- 17, 查询"95033"班学生的平均分
-- 先查一下每一个的
MariaDB [selectTest]> select * from student where class='95031';
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
4 rows in set (0.00 sec)

MariaDB [selectTest]> select sno from student where class='95031';
+-----+
| sno |
+-----+
| 103 |
| 104 |
| 105 |
| 109 |
+-----+
4 rows in set (0.01 sec)
-- 先来一个嵌套
MariaDB [selectTest]> select * from score where sno in (select sno from student where class='95031');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-245 |     86 |
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
4 rows in set (0.00 sec)

-- 在加上平均成绩和排序
MariaDB [selectTest]> select cno,avg(degree) 
    -> from score 
    -> where sno in (select sno from student where class='95031')
    -> group by cno;
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     72.0000 |
| 3-245 |     80.5000 |
| 6-166 |     63.0000 |
+-------+-------------+
3 rows in set (0.00 sec)


-- 18, 查询选修"3-245"课程的成绩高于"109"号学生"3-105"的所有同学记录.
select degree from score where sno='109' and cno='3-105';
-- 先查到成绩高于109同学的所有
MariaDB [selectTest]> select * from score where degree>(select degree from score where sno='109' and cno='3-105');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 107 | 6-166 |     86 |
+-----+-------+--------+
3 rows in set (0.00 sec)
-- 在查询cno为'3-245'的
MariaDB [selectTest]> select * from score where cno='3-245' and degree>(select degree from score where sno='109' and cno='3-105');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-245 |     86 |
+-----+-------+--------+
1 row in set (0.00 sec)



-- 19查询成绩高于学号为109,课程号为3-105的成绩的所有记录
MariaDB [selectTest]> select * from score where degree > (select degree from score where sno='109' and cno='3-105');
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 107 | 6-166 |     86 |
+-----+-------+--------+
3 rows in set (0.00 sec)

-- 20,查询和学号为108,101同学同年出生的所有学生的sno,sname和sbirthday列
-- 先找到到底是哪一个学生的生日,具体是多少?
MariaDB [selectTest]> select * from student where sno in (108,101);
+-----+--------+------+---------------------+-------+
| sno | sname  | ssex | sbirthday           | class |
+-----+--------+------+---------------------+-------+
| 101 | 李军   | 男   | 1976-02-20 00:00:00 | 95033 |
| 108 | 曾华   | 男   | 1977-09-01 00:00:00 | 95033 |
+-----+--------+------+---------------------+-------+
2 rows in set (0.00 sec)
-- 只查询年份
MariaDB [selectTest]> select year(sbirthday) from student where sno in (108,101);
+-----------------+
| year(sbirthday) |
+-----------------+
|            1976 |
|            1977 |
+-----------------+
2 rows in set (0.00 sec)
-- 嵌套进去
MariaDB [selectTest]> select * from student where year(sbirthday) in (select year(sbirthday) from student where sno in (108,101));
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 106 | 框大明    | 男   | 1977-10-02 00:00:00 | 95036 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
+-----+-----------+------+---------------------+-------+
5 rows in set (0.00 sec)

-- 21 查询alice教师任课 的学生成绩
MariaDB [selectTest]> select * from teacher where tname = 'alice';
+-----+-------+------+---------------------+-----------+--------------+
| tno | tname | tsex | tbirthday           | prof      | depart       |
+-----+-------+------+---------------------+-----------+--------------+
| 804 | alice | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系     |
+-----+-------+------+---------------------+-----------+--------------+
1 row in set (0.00 sec)

-- 嵌套查询这个老师上的课程
MariaDB [selectTest]> select * from course where tno=(select tno from teacher where tname = 'alice');
+-------+--------------+-----+
| cno   | cname        | tno |
+-------+--------------+-----+
| 3-245 | 操作系统     | 804 |
+-------+--------------+-----+
1 row in set (0.00 sec)

-- 在一层嵌套 查询
MariaDB [selectTest]> select * from score where cno=(select cno from course where tno=(select tno from teacher where tname = 'alice'));
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 103 | 3-245 |     86 |
| 105 | 3-245 |     75 |
+-----+-------+--------+
2 rows in set (0.00 sec)
-- 上一次查询出来的结果作为下一次查询的条件

-- 22 查询选修某课程的同学人数多于5人的教师姓名.
MariaDB [selectTest]> select * from score;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 102 | 6-166 |     85 |
| 103 | 3-245 |     86 |
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 107 | 6-166 |     86 |
| 109 | 3-105 |     78 |
| 109 | 6-166 |     63 |
+-----+-------+--------+
7 rows in set (0.00 sec)

-- 再插入点儿数据

insert into score values('109','3-105','78');
insert into score values('101','3-105','78');
insert into score values('103','3-105','77');
insert into score values('108','3-105','84');
insert into score values('107','3-105','57');

-- 直接就查询
MariaDB [selectTest]> select cno from score group by cno;
+-------+
| cno   |
+-------+
| 3-105 |
| 3-245 |
| 6-166 |
+-------+
3 rows in set (0.00 sec)

select cno from score group by cno having count(*) > 5;

select * from teacher;

select * from course where cno = (select cno from score group by cno having count(*) > 5);

select tname from teacher where tno = (select tno from course where cno = (select cno from score group by cno having count(*) > 5));

MariaDB [selectTest]> select * from course where cno = (select cno from score group by cno having count(*) > 5);
+-------+-----------------+-----+
| cno   | cname           | tno |
+-------+-----------------+-----+
| 3-105 | 计算机导论      | 825 |
+-------+-----------------+-----+
1 row in set (0.00 sec)

MariaDB [selectTest]> select tname from teacher where tno = (select tno from course where cno = (select cno from score group by cno having count(*) > 5));
+-------+
| tname |
+-------+
| pign  |
+-------+
1 row in set (0.00 sec)

-- 23, 查询95033班和95031班全体学生的记录.
MariaDB [selectTest]> select * from student;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 106 | 框大明    | 男   | 1977-10-02 00:00:00 | 95036 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 110 | 张飞      | 男   | 1974-05-07 00:00:00 | 95031 |
| 112 | 曹阳      | 男   | 1974-05-07 00:00:00 | 95032 |
| 113 | 杨鑫      | 男   | 1974-05-07 00:00:00 | 95032 |
| 114 | 萌芽      | 男   | 1978-05-29 00:00:00 | 95032 |
+-----+-----------+------+---------------------+-------+
13 rows in set (0.01 sec)


MariaDB [selectTest]> select * from student where class in ('95031','95033');
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1976-02-20 00:00:00 | 95033 |
| 102 | 李往军    | 男   | 1976-02-20 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-03 00:00:00 | 95031 |
| 104 | 陆小军    | 男   | 1978-06-03 00:00:00 | 95031 |
| 105 | 框明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1977-09-01 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1975-02-10 00:00:00 | 95031 |
| 110 | 张飞      | 男   | 1974-05-07 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+
9 rows in set (0.00 sec)

-- 24, 查询存在有85分以上成绩的课程cno

MariaDB [selectTest]> select cno,degree from score where degree > 85;
+-------+--------+
| cno   | degree |
+-------+--------+
| 3-245 |     86 |
| 6-166 |     86 |  
+-------+--------+
2 rows in set (0.00 sec)

-- 25, 查询出'计算机系'教师所教课程的成绩表.

MariaDB [selectTest]> select * from teacher where depart='计算机系';
+-----+-------+------+---------------------+-----------+--------------+
| tno | tname | tsex | tbirthday           | prof      | depart       |
+-----+-------+------+---------------------+-----------+--------------+
| 804 | alice | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系     |
| 825 | pign  | 女   | 1969-03-12 00:00:00 | 助教      | 计算机系     |
+-----+-------+------+---------------------+-----------+--------------+
2 rows in set (0.00 sec)


MariaDB [selectTest]> select * from course where tno in (select tno from teacher where depart='计算机系');
+-------+-----------------+-----+
| cno   | cname           | tno |
+-------+-----------------+-----+
| 3-245 | 操作系统        | 804 |
| 3-105 | 计算机导论      | 825 |
+-------+-----------------+-----+
2 rows in set (0.00 sec)

MariaDB [selectTest]> select * from score where cno in (select cno from course where tno in (select tno from teacher where depart='计算机系'));
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     78 |
| 103 | 3-105 |     77 |
| 103 | 3-245 |     86 |
| 104 | 3-105 |     72 |
| 105 | 3-245 |     75 |
| 107 | 3-105 |     57 |
| 108 | 3-105 |     84 |
| 109 | 3-105 |     78 |
+-----+-------+--------+
8 rows in set (0.00 sec)

-- 26,查询"计算机系" 与电子工程系""不同职称的教师的tname

MariaDB [selectTest]> select prof from teacher where depart='计算机系';
+-----------+
| prof      |
+-----------+
| 副教授    |
| 助教      |
+-----------+
2 rows in set (0.00 sec)

-- 反着排除查
MariaDB [selectTest]> select * from teacher where depart='计算机系' and prof not in(select prof from teacher where depart='电子工程系');
+-----+-------+------+---------------------+-----------+--------------+
| tno | tname | tsex | tbirthday           | prof      | depart       |
+-----+-------+------+---------------------+-----------+--------------+
| 804 | alice | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系     |
+-----+-------+------+---------------------+-----------+--------------+
1 row in set (0.00 sec)

MariaDB [selectTest]> 
MariaDB [selectTest]> select * from teacher where depart='电子工程系' and prof not in(select prof from teacher where depart='计算机系');
+-----+----------+------+---------------------+--------+-----------------+
| tno | tname    | tsex | tbirthday           | prof   | depart          |
+-----+----------+------+---------------------+--------+-----------------+
| 856 | nineberg | 男   | 1968-03-12 00:00:00 | 讲师   | 电子工程系      |
+-----+----------+------+---------------------+--------+-----------------+
1 row in set (0.00 sec)

-- 再将他们合并在一起
-- union 求并集

MariaDB [selectTest]> select * from teacher 
    -> where depart='电子工程系' 
    -> and prof not in(
    ->     select prof from teacher where depart='计算机系'
    ->     )
    -> union 
    -> select * from teacher 
    -> where depart='计算机系' 
    -> and prof not in(
    ->     select prof from teacher where depart='电子工程系'
    ->     );
+-----+----------+------+---------------------+-----------+-----------------+
| tno | tname    | tsex | tbirthday           | prof      | depart          |
+-----+----------+------+---------------------+-----------+-----------------+
| 856 | nineberg | 男   | 1968-03-12 00:00:00 | 讲师      | 电子工程系      |
| 804 | alice    | 男   | 1958-12-02 00:00:00 | 副教授    | 计算机系        |
+-----+----------+------+---------------------+-----------+-----------------+
2 rows in set (0.00 sec)
