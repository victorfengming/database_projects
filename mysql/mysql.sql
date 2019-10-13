
-- mysql 学习笔记

-- 关系型数据库

-- 一，如何使用终端操作数据库？

-- 1. 如何登录数据库服务器？

mac：～victor$mysql -u root -p

-- 2. 如何查询数据库服务器中的所有数据？

mysql>show databases;

-- 3. 如何选中某一个数据库进行操作？

mysql>select * from admin;
mysql>use sushe
-- sql语句中的查询
mysql>select * from admin where admin_id=1;

-- 如何退出数据库服务器
mysql>exit;
Bye

-- 如何在数据库服务区中创建我们的数据库?
create databases test;

-- 如何查看某个数据库中所有的数据表?
show tables;

-- 如何创建一个数据表?
create table pet(
    name varchar(20),
    owner varchar(20),
    species varchar(20),
    sex char(1),
    birth date,
    death date
    );

-- 查看数据表的结构
describe pet;

-- 如何查看数据表中的记录?
mysql>select * from pet

-- 如何往数据表中添加数据记录呢?
insert into pet
    value('puffball','diane','hamster')


-- mysql 常用的数据类型

-- 数值类型
-- 日期/时间
-- 字符类型

-- 总结一下:数据记录常见操作?
-- 增加
insert
-- 删除
delete
-- 修改
update
-- 查询
select


-- 二，如何使用可视化工具操作数据库？

-- 三，如何在编程语言中操作数据库？