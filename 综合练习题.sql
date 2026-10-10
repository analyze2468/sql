# select VERSION();
# DDL（数据定义语言）：show,creat,drop,alter
# DML（数据操作语言）：insert,delete,update
# DQL（数据查询语言）：select,from,where
# sql语句用“；”结尾
# 注释：/*，#，-- 
#------------------------------------------------
#DDL定义语言
show databases;
use database;
create database if not exits test;
drop database if exits test;
show tables;
create table if not exits student(
a int,
b varchar(10),
c int
);
drop database if exits student;
select * from student;
#-------------------------------------------
# 数据类型
# 整数：int
# 字符串：varchar()"不定长，输入几位就是几位"，char()“定长，确定就只能是几位”
# 小数：decimal（位数，小数）#注意： 常常表示需要精确的小数如钱！ 优势：精确；不足：效率低，但用空间大，范围小
# 小数：double(位数，小数)   #注意：可以允许略微的不精确！ 注意:decimal和double两者都可不带括号    优势：占存储空间小，范围大；不足：不精确
# 日期时间：date,datetime
# comment+‘内容’（内容写进数据库）
# 主键（primary key）：一列的身份证，主键一列不能是空，值不能重复
# 外键(foreign key)：将表格中的列进行关联（内容规则关联），有关的可以写，否则不能写！！！
# ------------------------------例题练习---------------------------
# 一：DDL
# 开关
show databases;
create database if not exists boss;
use boss;
show tables;
select * from order_item;
select * from user_info;
select * from order_main;
# drop table if exists use_info;
#-----------------------------------------------------------------------------
create table if not exists user_info(
user_id int primary key auto_increment comment '主键，自增，用户ID',
user_name varchar(30) not null comment '非空，用户名',
phone varchar(11) comment '唯一，手机号',
register_time datetime comment '注册时间',
user_level tinyint default 1 comment '用户等级，默认1'
);
create table if not exists order_main(
order_id bigint primary key auto_increment comment '主键自增，订单号',
user_id int comment '关联user_info.user_id',
order_time datetime not null comment '下单时间，非空',
total_amount decimal(10,2) comment '订单总金额',
order_status tinyint default 0 comment '订单状态：0待付款，1已付款，2已取消，3已完成，默认0',
foreign key(user_id) references user_info(user_id)
);
create table if not exists order_item(
item_id int primary key auto_increment comment '主键自增，明细id',
order_id bigint comment '关联order_main.order_id',
goods_name varchar(100) not null comment '商品名称，非空',
goods_price decimal(10,2) comment '商品单价',
buy_num int comment '购买数量，大于0',
foreign key(order_id) references order_main(order_id)
);

# 二：DML 
insert into user_info(user_id,user_name,phone,register_time,user_level) 
values
(1,"王大锤",'13800138001','2025-01-10 08:20:00',2),
(2,"李小花",'13800138002','2025-02-15 14:10:00',1),
(3,"赵铁柱",'13800138003','2025-03-01 09:30:00',3);

insert into order_main(order_id,user_id,order_time,total_amount,order_status)
values
(1001,1,'2025-04-01 10:00:00',239.80,1),
(1002,1,'2025-04-05 16:20:00',89.00,2),
(1003,2,'2025-04-06 11:15:00',567.50,1),
(1004,3,'2025-04-10 09:05:00',null,0);

insert into order_item(item_id,order_id,goods_name,goods_price,buy_num)
values
(1,1001,'无线鼠标',79.90,2),
(2,1001,'键盘',80.00,1),
(3,1002,'手机壳',89.00,1),
(4,1003,'蓝牙耳机',567.50,1);

# 更新
update order_item set goods_price=85 where goods_name='无线鼠标'; # update操作不用写table!!!

# 删除李小花全部订单明细
delete from order_item 
where order_id in (
select order_id from order_main 
where user_id=(select user_id from user_info 
where user_name='李小花'
	)
);
# 注意：in后面可以接多个值，=后面只能接一个值

# 查询已付款订单



# 


