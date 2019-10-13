-- 数据库的是三大设计范式

-- 1.第一范式

-- 1NF

-- 数据表中的所有字段都是不可分割的原子值?

create table student2(
    id int primary key,
    name varchar(20),
    address varchar(30)
);

insert into student2 values(1,'张三','中国四川省成都市武侯区武侯大道100号');
insert into student2 values(2,'李四','中国四川省成都市武侯区京城大道200号');
insert into student2 values(3,'王五','中国四川省成都市高新区天府大道300号');

select * from student2;

字段值还可以继续拆分的,就不满足第一范式
+----+--------+-----------------------------------------------------+
| id | name   | address                                             |
+----+--------+-----------------------------------------------------+
|  1 | 张三   | 中国四川省成都市武侯区武侯大道100号                 |
|  2 | 李四   | 中国四川省成都市武侯区京城大道200号                 |
|  3 | 王五   | 中国四川省成都市高新区天府大道300号                 |
+----+--------+-----------------------------------------------------+
3 rows in set (0.00 sec)


create table student3(
    id int primary key,
    name varchar(20),
    country varchar(30),
    privence varchar(30),
    city varchar(30),
    details varchar(30)
);


insert into student3 values(1,'张三','中国','四川省','成都市','武侯区武侯大道100号');
insert into student3 values(2,'张三','中国','四川省','成都市','武侯区京城大道200号');
insert into student3 values(3,'张三','中国','四川省','成都市','高新区天府大道300号');

select * from student3;

+----+--------+---------+-----------+-----------+-----------------------------+
| id | name   | country | privence  | city      | details                     |
+----+--------+---------+-----------+-----------+-----------------------------+
|  1 | 张三   | 中国    | 四川省    | 成都市    | 武侯区武侯大道100号         |
|  2 | 张三   | 中国    | 四川省    | 成都市    | 武侯区京城大道200号         |
|  3 | 张三   | 中国    | 四川省    | 成都市    | 高新区天府大道300号         |
+----+--------+---------+-----------+-----------+-----------------------------+

-- 范式 ,设计的越详细,对于某些实际操作可能更好,但是不一定都是好处.

-- 如果这个字段还可以继续被拆分,那么他就不满足第一范式

-- 第二范式
-- 必须是满足第一范式的前提下.第二范式要求,除主键外的每一列,都必须完全依赖于主键
-- 如果要出现不完全依赖,只可能发生在联合主键的情况下.

-- 订单表

create table myorder(
    product_id int,
    customer_id int,
    product_name varchar(20),
    customer_name varchar(20),
    primary key(product_id, customer_id)
    -- 这两个id共同组成了我们的主键
);

-- 问题?
-- 除主键以外的其他列,只依赖于主键的部分字段
-- 拆表

create table myorder(
    order_id int primary key,
    product_id int,
    customer_id int
);

create table product(
    id int primary key,
    name varchar(20)
);

create table customer(
    id int primary key,
    name varchar(20)
);

-- 分成三个表之后,就满足了第二范式的设计 

-- 第三范式
-- 3NF
-- 必须先满足第二范式,除开主键列的其他列之间不能有传递依赖关系.



create table myorder(
    order_id int primary key,
    product_id int,
    customer_id int,
    customer_phone varchar(15)

);
-- 在第三范式中
-- 不能有传递依赖