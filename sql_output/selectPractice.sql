show databases;

use demo1;

show tables;

select *
from student;
select *
from teacher;
select *
from score;
select *
from course;



create table student
(
    sno       varchar(20) primary key,
    sname     varchar(20) not null,
    ssex      varchar(10) not null,
    sbirthday datetime,
    class     varchar(20)
);

create table teacher
(
    tno       varchar(20) primary key,
    tname     varchar(20) not null,
    tsex      varchar(20) not null,
    tbirthday datetime,
    prof      varchar(20) not null,
    depart    varchar(20) not null
);

create table course
(
    cno   varchar(20) primary key,
    cname varchar(20) not null,
    tno   varchar(20) not null,
    foreign key (tno) references teacher (tno)
);

create table score
(
    sno    varchar(20) not null,
    cno    varchar(20) not null,
    degree decimal,
    foreign key (sno) references student (sno),
    foreign key (cno) references course (cno),
    primary key (sno, cno)
);


-- 往表中添加数据
-- 添加学生信息
insert into student
values ('108', '曾华', '男', '1977-09-01', '95033');
insert into student
values ('105', '框明', '男', '1975-10-02', '95031');
insert into student
values ('106', '框大明', '男', '1977-10-02', '95036');
insert into student
values ('107', '王丽', '女', '1976-01-23', '95033');
insert into student
values ('101', '李军', '男', '1976-02-20', '95033');
insert into student
values ('102', '李往军', '男', '1976-02-20', '95033');
insert into student
values ('109', '王芳', '女', '1975-02-10', '95031');
insert into student
values ('103', '陆军', '男', '1974-06-03', '95031');
insert into student
values ('104', '陆小军', '男', '1978-06-03', '95031');

-- 添加教师表
insert into teacher
values ('804', 'alice', '男', '1958-12-02', '副教授', '计算机系');
insert into teacher
values ('856', 'nineberg', '男', '1968-03-12', '讲师', '电子工程系');
insert into teacher
values ('825', 'pign', '女', '1969-03-12', '助教', '计算机系');
insert into teacher
values ('831', 'bingl', '女', '1977-08-14', '助教', '电子工程系');

-- 添加课程表
insert into course
values ('3-105', '计算机导论', '825');
insert into course
values ('3-245', '操作系统', '804');
insert into course
values ('6-166', '数字电路', '856');
insert into course
values ('9-888', '高等数学', '831');

-- 添加成绩表
insert into score
values ('103', '3-245', '86');
insert into score
values ('101', '3-245', '95');
insert into score
values ('104', '3-105', '72');
insert into score
values ('107', '6-166', '86');
insert into score
values ('102', '6-166', '85');
insert into score
values ('109', '6-166', '63');

insert into score
values ('109', '3-105', '78');


-- 查询练习

-- 1. 查询student表的所有记录.
select *
from student;

-- 2. 查询student表中所有记录的sname,ssex和class列

select sname, ssex, class
from student;


-- 3. 查询教师所有的单位即不重复的depart列.

select depart
from teacher;

-- 排除重复--distinct

select distinct depart
from teacher;


-- 4. 查询score表中成绩在60到80之间的所有记录.

-- 查询区间 between... and ...

select *
from score
where degree between 60 and 80;

-- 还有一种方式

select *
from score
where degree > 60
  and degree < 80;

-- 5. 查询Score表中成绩为85,86或88 的记录
-- 表示或者关系查询 in

select *
from score
where degree in (85, 86, 88);

-- 6. 查询student表中"95031"班或性别为女的同学记录.

-- 在不同的字段之间或者
select *
from student
where class = '95031'
   or ssex = "女";

-- 7. 以class降序查询student表的所有记录
-- 升序,降序
-- 降序排列
select *
from student
order by class desc;

-- 如果是生序排序可以省略asc
select *
from student
order by class asc;

-- 8. 以cno为升序,degree降序查询score表的所有记录

select *
from score
order by cno asc, degree desc;

-- 9. 查询"95031"班的学生人数.
-- 统计 count
select count(*)
from student
where class = "95031";

-- 10. 查询score表中的最高分的学生学号的学生学号和课程号.(子查询或者排序)
select sno, cno
from score
where degree = (select max(degree) from score);

-- 1 找到最高分
select max(degree)
from score;
-- 2 找最高分的sno和cno
select sno, cno
from score
where degree = (select max(degree) from score);

-- 排序的做法:
select sno, cno, degree
from score
order by degree;

-- 加上限制
-- limit 第一个数字表示从多少开始
-- 第二个数字表示差多少条
select sno, cno, degree
from score
order by degree
limit 0,1;


-- 11. 查询没门课程的平均成绩
-- avg()
-- 先查有多少门
select *
from course;

-- 差平均成绩
select avg(degree)
from score
where cno = '3-105';

-- 如何验证呢,我们可以将3-105的全部选出来
select degree
from score
where cno = '3-105';

-- 我能不能在一个sql语句中写呢
-- group by 分组
select cno, avg(degree)
from score
group by cno;

-- 12, 查询score表中至少有5名学生选修的并以3开头的课程的平均分数.

select cno
from score
group by cno
having count(cno) >= 2;

-- 然后加上3开头的模糊查询
select cno
from score
group by cno
having count(cno) >= 2
   and cno like "3%";

-- 然后在加上平均分
select cno, avg(degree)
from score
group by cno
having count(cno) >= 2
   and cno like "3%";

-- 究竟有几个人
select cno, avg(degree), count(*)
from score
group by cno
having count(cno) >= 2
   and cno like "3%";

-- 13, 查询分数大于70,小于90的sno列.
select sno, degree
from score
where degree > 70
  and degree < 90;
-- 另一种方式
select sno, degree
from score
where degree between 70 and 90;

-- 14, 查询所有学生的sname, cno和degree列,
-- 先差一下名字
select sname
from student;

-- 在查一下分数
select cno, degree
from score;
-- 带有学号的查询
select sno, sname
from student;

select sno, cno, degree
from score;

-- 多表查询的组合
select sname, cno, degree
from student,
     score
where student.sno = score.sno;

-- 15, 查询所有学生的sno,cname和degree列.
select cno, cname
from course;

select cno, sno, degree
from score;

-- 将cno 相等的位置用cname去表示就OK了
select sno, cname, degree
from course,
     score
where course.cno = score.cno;

-- 16, 查询所有学生的sname, cname和degree列
-- 这个问题的字段分别来自于三个表格,还是多表查询,核心在于course起到的一个桥梁作用
-- sname -> student
-- cname -> course
-- degree -> score
select sname, cname, degree
from student,
     course,
     score
where student.sno = score.sno
  and course.cno = score.cno;

select sname, cname, degree, student.sno, course.cno
from student,
     course,
     score
where student.sno = score.sno
  and course.cno = score.cno;


select sname, cname, degree, student.sno as stu_sno, course.cno as cou_cno
from student,
     course,
     score
where student.sno = score.sno
  and course.cno = score.cno;

select sname, cname, degree, student.sno as stu_sno, score.sno, course.cno as cou_cno, score.cno
from student,
     course,
     score
where student.sno = score.sno
  and course.cno = score.cno;


-- 17, 查询"95033"班学生的平均分
-- 先查一下每一个的
select *
from student
where class = '95031';

select sno
from student
where class = '95031';

-- 先来一个嵌套
select *
from score
where sno in (select sno from student where class = '95031');

-- 在加上平均成绩和排序
select cno, avg(degree)
from score
where sno in (select sno from student where class = '95031')
group by cno;


-- 18, 查询选修"3-245"课程的成绩高于"109"号学生"3-105"的所有同学记录.
select degree
from score
where sno = '109'
  and cno = '3-105';

-- 在查询cno为'3-245'的
select *
from score
where cno = '3-245'
  and degree > (select degree from score where sno = '109' and cno = '3-105');

-- 19查询成绩高于学号为109,课程号为3-105的成绩的所有记录
select *
from score
where degree > (select degree from score where sno = '109' and cno = '3-105');

-- 20,查询和学号为108,101同学同年出生的所有学生的sno,sname和sbirthday列
-- 先找到到底是哪一个学生的生日,具体是多少?
select *
from student
where sno in (108, 101);

-- 只查询年份
select year(sbirthday)
from student
where sno in (108, 101);

-- 嵌套进去
select *
from student
where year(sbirthday) in (select year(sbirthday) from student where sno in (108, 101));

-- 21 查询alice教师任课 的学生成绩
select *
from teacher
where tname = 'alice';

-- 嵌套查询这个老师上的课程
select *
from course
where tno = (select tno from teacher where tname = 'alice');


-- 在一层嵌套 查询
select *
from score
where cno = (select cno from course where tno = (select tno from teacher where tname = 'alice'));
-- 上一次查询出来的结果作为下一次查询的条件

-- 22 查询选修某课程的同学人数多于5人的教师姓名.
select *
from score;


-- 再插入点儿数据

insert into score
values ('101', '3-105', '78');
insert into score
values ('103', '3-105', '77');
insert into score
values ('108', '3-105', '84');
insert into score
values ('107', '3-105', '57');

-- 直接就查询
select cno
from score
group by cno;

select cno
from score
group by cno
having count(*) > 5;

select *
from teacher;

select *
from course
where cno = (select cno from score group by cno having count(*) > 5);

select tname
from teacher
where tno = (select tno from course where cno = (select cno from score group by cno having count(*) > 5));

-- 23, 查询95033班和95031班全体学生的记录.
select *
from student;

select *
from student
where class in ('95031', '95033');

-- 24, 查询存在有85分以上成绩的课程cno

select cno, degree
from score
where degree > 85;

-- 25, 查询出'计算机系'教师所教课程的成绩表.

select *
from teacher
where depart = '计算机系';

select *
from course
where tno in (select tno from teacher where depart = '计算机系');

select *
from score
where cno in (select cno from course where tno in (select tno from teacher where depart = '计算机系'));

-- 26,查询"计算机系" 与电子工程系""不同职称的教师的tname
select prof
from teacher
where depart = '计算机系';
-- 反着排除查
select *
from teacher
where depart = '计算机系'
  and prof not in (select prof from teacher where depart = '电子工程系');

select *
from teacher
where depart = '电子工程系'
  and prof not in (select prof from teacher where depart = '计算机系');

-- 再将他们合并在一起
-- union 求并集

select *
from teacher
where depart = '电子工程系'
  and prof not in (
    select prof
    from teacher
    where depart = '计算机系'
)
union
select *
from teacher
where depart = '计算机系'
  and prof not in (
    select prof
    from teacher
    where depart = '电子工程系'
);

select *
from teacher;

-- 27 查询选修编号为"3-105"课程且成绩至少高于选修编号为"3-245"的同学的Cno,Sno和Degree,

-- 并按Degree从高到低次序排序

select *
from score
where cno = "3-245";

select *
from score
where cno = "3-105";

# 至少? 大于其中至少一个any

select *
from score
where cno = "3-105"
  and degree > any (select degree from score where cno = '3-245')
order by degree desc;

# 28 查询选修编号为"3-105"且成绩高于选修编号为"3-245"课程的同学的Cno,Sno,和Degree

# all 表示所有

select *
from score
where cno = '3-105' and degree > all (select degree
from score
where cno = '3-245') order by degree desc;

# 29 查询所有教师和同学的name,sex和birthday

# 别名? as

select tname as name, tsex as sex, tbirthday as birthday
from teacher
union
select sname as name, ssex as sex, sbirthday as birthday
from student;

# 30 查询所有女教师和女同学的name,sex和birthday
select tname as name, tsex as sex, tbirthday as birthday
from teacher where tsex="女"
union
select sname as name, ssex as sex, sbirthday as birthday
from student where ssex="女";

# 31 查询成绩比该课程平均成绩低的同学的成绩表

select avg(degree) from score group by cno;

select *
from score a where degree < (select avg(degree) from score b where a.cno=b.cno);

# 32 查询所有任课教师的Tname和Depart.ALTER

select *
from course;

select tname, depart
from teacher where tno in (select tno from course);

# 课程表中安排了课程
select *
from course;

# 33,查询至少有2名男生的班号

select *
from student;

select class
from student
where ssex = "男"
group by class
having count(*) > 1;

# 34, 查询student 表中不姓"王"的同学记录
select *
from student;

select *
from student
where sname not like "王%";

# 35, 查询student表中每个同学的姓名和年龄

# 当前年份减去出生年份

select year(sbirthday)
from student;

select sname, year(now()) - year(sbirthday) as "年龄"
from student;

# 36 ,查询student表中最大和最小的sbirthday日期值
select sbirthday
from student order by sbirthday;

-- max min
# select max(sbirthday)

select *
from student;

select sbirthday from student order by sbirthday;

select max(sbirthday) as 'the max' , min(sbirthday) as 'the min'
from student;

# 37 ,以班号和年龄从大到小的顺序查询student表中的全部记录.

select *
from student
order by class desc ,sbirthday;

# 38 查询男教师以及所上的课程
select *
from teacher where tsex="男";


# 39 查询最高分同学的sno,cno和degree列

select max(degree)
from score;

select *
from score where degree=(select max(degree)
from score);

# 40 查寻和"李军"同性别的所有同学的Sname

select ssex
from student where sname="李军";

select class
from student
where sname = "李军";


select sname from student where ssex=(select ssex
from student where sname="李军");

# 41 查询和"李军并且同班的同学的sname

select sname from student where ssex=(select ssex
from student where sname="李军") and class=(select class
from student
where sname = "李军");

# 42 查询所有选修"计算机导论"课程的"男同学的成绩表

select cno
from course where cname="计算机导论";

select sno
from student where ssex="男";

select *
from score
where cno = (select cno
             from course
             where cname = "计算机导论")
  and sno in (select sno
              from student
              where ssex = "男");


# 43 假设使用如下命令创建了一个grade表:
create table grade
(
    low int(3),
    upp int(3),
    grade char(1)
);

insert into grade values(90,100,'A');
insert into grade values(80,89,'B');
insert into grade values(70,79,'C');
insert into grade values(60,69,'D');
insert into grade values(0,59,'E');

select *
from grade;

# 现查询所有学生的sno,cno,和grade列

select sno, cno, grade
from score,
     grade
where degree between low and upp;
C:\Users\yangxin\.DataGrip2019.2\config\consoles\db\561aa01c-dd27-4959-bedf-dccc0fe6221b\selectPractice.sql