
-- mysql 见表约束

-- 主键约束
它能够唯一确定一张表中的一条记录,也就是我们通过给某个字段添加约束,就可以使得该字段不重复且不为空


create table user(
    id int primary key,
    name varchar(20)
)

insert into user values(1,'张三');

-- 联合主键
-- 只要联合的主键值加起来不重复就可以
create table user2(
    id int ,
    name varchar(20),
    password varchar(20),
    primary key(id,name)
)

-- 自增约束

create table user3(
    id int primary key auto_increment,
    name varchar(20)
);

insert into user3 (name) values('mengya');

select * from user3;
-- 如果说我们创建一个表的时候忘记创建主键约束了,改怎么办?

create table user4(
    id int,
    name varchar(20)
);

-- 修改表结构
alter table user4 add primary key(id);

-- 如何删除
alter table user4 drop primary key;

-- 修改主键约束,使用modify修改字段,添加约束
alter table user4 modify id int primary key;

-- 唯一约束
-- 约束修饰的字段的值不可以重复

create table user5(
    id int,
    name varchar(20)
);

alter table user5 add unique(name);

insert into user5 values(1,'zhanhsan');

-- 或者也可以这样写
create table user6(
    id int,
    name varchar(20),
    unique(name)
);

-- 还可以这样写

create table user7(
    id int,
    name varchar(20) unique
);

-- 还可以这样写

create table user8(
    id int,
    name varchar(20) 
    unique(id,name)
);

-- unique(id,name) 表示两个键在一起不重复就行

-- 如何删除唯一约束?
alter table user7 drop index name;

-- modify添加?
alter table user7 modify name varchar(20) unique;

-- 总结
-- 1. 见表的时候就添加约束
-- 2. 可以使用alter...add...
-- 3. alter... modify...
-- 4. 删除 altrer...drop...


-- 非空约束
-- 修饰的字段不能为空

create table user9(
    id int,
    name varchar(20) not null
);

-- 默认约束
-- 就是当我们插入字段值的时候,如果没有传值,就会使用默认值

create table user10(
    id int,
    name varchar(20),
    age int default 10
);

insert into user10(id,name) values(1,'mengya');

-- 如果传了值就不会使用默认值了

-- 外键约束
-- 涉及到两个表:父表,子表

-- 班级
create table classes(
    id int primary key,
    name varchar(20)
);

-- 学生表
create table students(
    id int primary key,
    name varchar(20),
    class_id int,
    foreign key(class_id) references classes(id)
);

insert into students values(1001,'小明',1);
insert into students values(1002,'小红',2);
insert into students values(1003,'小刚',3);
insert into students values(1004,'小强',4);


insert into students values(1005,'小强',5);

insert into classes values(1,'一班');
insert into classes values(2,'二班');
insert into classes values(3,'三班');
insert into classes values(4,'四班');

-- 1 主表classes中没有的数据值,在副表中,是不可以使用的.
-- 2 主表中的记录被附表引用,是不可以被删除的

delete from classes where id=4;


