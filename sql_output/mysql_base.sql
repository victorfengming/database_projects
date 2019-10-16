-- 数据库系统：
--     1.DB -> 存储数据的
--     2.DBMS -> 用来管理数据的

-- DBMS：
--     1.DCL 用来创建和维护用户账户的。root
--     2.DDL 数据定义语言。
--     3.DML 用来操纵数据 -> 重点
    
DDL：
    1. 操纵数据库(创建和删除)
        create database 数据库名;
        drop database 数据库名;
    2. 创建表
        create table 表的名字(
            字段, 表头, column ,列
            字段名 类型(长度)约束
        );

        约束:
            1. 主键约束. 唯一的表示一条数据.该字段的数据不允许重复.主键不可以为空.
                primary key auto_increment

            2. 非空约束.这一列数据不允许为空
                NOT NULL

            3. 默认值约束.设置默认值
                default 值

            4. 唯一性约束,数据不允许重复
                unique

            数据类型

            1. int
            2. varchar(255)
            3. date
            4. time
            5. Datetime
            6. Text
            7. double(6,2)
            8. decimal(6,2)
