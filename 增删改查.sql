show databases;  # 看数据库是否存在：show databases;
                 # 创造数据库：create database if not exists world;
use world;       # 打开数据库：use database;
drop table if exists student;# 删除数据库/表格：drop databases if exists world/drop table if exist student;
# select * from student;     
create table if not exists student(   # 创造表格:create table if not exists student; 
    id int primary key,
    name varchar(10),
    age int
);
# show tables;
insert into student(id,name,age) values(1,'小明',13),(2,'小芳',15);  # 插入数据内容进入表格:insert into student(a,b,c) values(1,2,3),(4,5,6);
show tables;   # 看表格是否存在：show tables;
select * from student;      #  查表格表格：select * form student;
delete from student where id=1  # 删除表格内容： delete from student where a=1;
alter table student drop column age;
update student set age=18 where id=3; # 更改表格数据内容：update student set age=新结果 where age=表头
insert into student(id,name,age) value(1,'黄老师',19);
insert into student(id,name) value(3,'刘老师'); 
alter table student add column high int;   # column(列)
delete from student where id=3;

# 总结：增、删、改、查四件套
# 增行1：insert into student() values(),();   注：此增加仅仅增加一行！！！
# 增列2：alter table student add column age int;    
# 删行1：delete from student where id=1;   注：此删除仅仅删除一行！！！
# 删列2：alter table student drop column age;
# 改表名：alter table 就表名 rename to 新表名；
# 改列名：alter table change 旧列名 新列名 新的数据类型+【约束条件】
# 改全部（行/列）：update student age=20
# 改单个：update student set age=19 where id=1;  注：针对行而言set 新内容 + where 行标志   用途：此方法可用于替换单个的单元格！！！
# 查全部：select * from student;                 注：针对student表中所有的行和列“*” 
# 查单个：select age (列)/id=1（行）from student where id=?/age=?


# -------------------------补充知识点：数据库表格的备份--------------------------
show databases;
show tables;
# 原表
select * from order_item;
# （备份表不存在如何备份？）格式：create table 备份表名 select * from 原表名 where~~
create table practice_biao select * from order_item;
# 验证备份表存在
select * from practice_biao;
# 清空备份表
delete from practice_biao;
# 删除备份表
drop table practice_biao;
# （备份表存在如何备份？）格式：insert into 备份表名 select * from 原表名 where~~
insert into practice_biao select * from order_item where item_id<=3;
# 改表名
alter table practice rename to practice_biao;









# -------------------------知识点二-----------------------

# 分组聚合：分组+聚合
# 分组：select a from student group by a
# 聚合函数：包括avg(num),max(num),min(num),sum(num),count(num);
select gender,count(age),max(age),min(age),avg(age),sum(age) from student group by gender;  
# 公式解读：select num,avg(num) from student group by num;	

# -------------------------知识点三-----------------------

select 分组+聚合函数 from student where age>18 group by age ; 
order by age 
limit 10(从第十行开始),5(仅仅查五行)；

执行顺序： select- from- +where- + group by- (聚合函数)+order by +limit 


