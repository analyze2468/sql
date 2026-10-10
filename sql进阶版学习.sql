#------------------------- 知识点一：约束条件（主键约束）---------------------------------------
# 主键特点：主键唯一、主键包含唯一的值、加快数据查找速度；（作用：唯一标识作用）
show databases;
use boss;
show tables;
select * from student;
drop table student;
# 主键约束方式一：
create table student(
id int primary key,
age int,
name varchar(20)
);
# 主键约束方式二：
create table student(
id int ,
age int,
name varchar(20),
primary key(id)
);
# 删除主键：
alter table student drop primary key(id);
# 增加主键：
alter table student add primary key(id);

# 主键配合功能：自增（auto_increment）:作用（在主键列自动+1，insert into插入数据时主键列可以不填写）
create table student(
id int primary key auto_increment,
age int,
name varchar(20)
);
# 插入内容：
insert into student values(1,18,"张三");
insert into student values(2,18,"李四");
insert into student values(null,20,"黄五");# 主键自增发挥了作用！！！

# 删除函数（delete from 表名：删除表中所有数据，主键自增序列不清除————不重置主键ID）（truncate table ：清除数据，主键主键自增序列清除————重置主键ID）
# 案例：
delete from student;
truncate student;

#  ---------非空、唯一、默认约束介绍----------------   

# (1)建学习数据库、表：字段（员工id，员工手机号，员工性别，员工住址）
show databases;
create database mysql_practice;
use mysql_practice;
show tables;
create table employee(
id int primary key auto_increment comment '员工id，主键自增',
name varchar(10) not null comment '员工手机号，非空',
mobile varchar(11) unique not null comment '员工手机号，唯一+非空（伪主键）',
address varchar(10) default '北京' comment '员工住址，默认值北京'
);
select * from employee;
#(2)功能：查看表结构（desc） 
desc employee; 

# (3)往表中添加数据
insert into employee values(null,'张三','111','都昌');  # 主键（唯一+非空），但自增让主键可以空！！！
insert into employee values(null,null,'222','都昌');    # 伪主键同样“唯一+非空”
insert into employee values(null,'张三','222','都昌');  # 注意：主键让其自增即可，无需关心顺序（核心是标识作用！！！）
insert into employee(id,name,mobile) values(null,'李四','555');  # 这种方式利用默认值“北京”

# (4)查看数据
select * from employee;

#------------------------- 知识点二：DQL 数据查询语言（单表查询）---------------------------------------
/*
单表查询介绍：
      概述：
           所谓的单表查询，指的是按照一定的条件，从一张SQL表中查出我们想要的结果数据
      总的格式：
          select
              列名 [as 别名],列名 [as 别名]…………
           from
               数据表明
           where 
               组前筛选
           group by
               分组字段
           having
                组后筛选
            order by
                排序的列1[asc|desc],排序的列2…………
            limit
                起始索引，数据
*/
# （1）简单查询：

#-------------准备动作：准备数据------------

use mysql_practice;
show tables;
# 1.创建商品表
create table product
(
    pid          int primary key auto_increment,
    pname        varchar(20),
    price        double,
    category_id  varchar(32)
);

# 2.插入表数据(单个数据插入“选中执行”，多条插入同时执行“Alt+x”)
insert into product(pid,pname,price,category_id) values(null,'联想',5000,'c001');
insert into product(pid,pname,price,category_id) values(null,'海尔',3000,'c001');
insert into product(pid,pname,price,category_id) values(null,'雷神',5000,'c001');
insert into product(pid,pname,price,category_id) values(null,'杰克琼斯',800,'c002');
insert into product(pid,pname,price,category_id) values(null,'真维斯',200,null);
insert into product(pid,pname,price,category_id) values(null,'花花公子',440,'c002');
insert into product(pid,pname,price,category_id) values(null,'劲霸',2000,'c002');
insert into product(pid,pname,price,category_id) values(null,'面霸',2000,'c002');

# 3.数据查询
select * from product;
# -------------------案例1:简单查询-------------------
# 1.查询指定列数据：
select pname,price from product;
# 2.别名查询(注意：此处as作用仅仅是在查询中有别名，不改变整个字段！！！)：
select pname as 商品名,price 价格 from product as p;
# 3.修改某列值：查询商品名，价格，但是，价格+10
select pname as 商品名,price+10 as 价格 from product;

# （2）条件查询：
/* 作用：筛选出数据表中满足条件的数据
   基本语法：select * from 表名 where 条件；
 */

# -------------------------案例2：条件运算符的介绍--------------------------------
/*
1.比较运算符：=、>、<、<=、>=、！=；
2.逻辑运算符：and(并且)，or(或者)，not(非、取反)
3.like模糊查询：
%：表示任意多个任意字符；
_：表示任意一个字符；
4.范围查询
between……and………：表示在一个连续的范围内查询；（适用于连续值的判断）——————一般是范围
in：表示在一个非连续的范围内查询；（适用于非连续值的判断）——————可以理解为是单个满足
5.空值判断：is null和is not null;
 */

# ------------数据准备：建表----------------
use mysql_practice;

-- 创建商品表
create table goods (
    id int primary key auto_increment,
    name varchar(50),
    price decimal(10,2),
    score decimal(3,2),
    is_self varchar(10),
    category_id int
);

-- 插入数据
insert into goods(id,name,price,score,is_self,category_id) values(null,'华为Mate50',5499.00,9.70,'自营',1);
insert into goods(id,name,price,score,is_self,category_id) values(null,'荣耀80',2399.00,9.50,'自营',1);
insert into goods(id,name,price,score,is_self,category_id) values(null,'荣耀80',2199.00,9.30,'非自营',1);
insert into goods(id,name,price,score,is_self,category_id) values(null,'红米note 11',999.00,9.00,'非自营',1);
insert into goods(id,name,price,score,is_self,category_id) values(null,'联想小新14',4199.00,9.20,'自营',2);
insert into goods(id,name,price,score,is_self,category_id) values(null,'惠普战66',4499.90,9.30,'自营',2);
insert into goods(id,name,price,score,is_self,category_id) values(null,'苹果Air13',6198.00,9.10,'非自营',2);
insert into goods(id,name,price,score,is_self,category_id) values(null,'华为MateBook14',5599.00,9.30,'非自营',2);
insert into goods(id,name,price,score,is_self,category_id) values(null,'兰蔻小黑瓶',1100.00,9.60,'自营',3);
insert into goods(id,name,price,score,is_self,category_id) values(null,'雅诗兰黛粉底液',920.00,9.40,'自营',3);
insert into goods(id,name,price,score,is_self,category_id) values(null,'阿玛尼红管405',350.00,null,'非自营',3);
insert into goods(id,name,price,score,is_self,category_id) values(null,'迪奥996',330.00,9.70,'非自营',3);
-- 查询数据
select * from goods;
select * from product;  
desc goods;


# 1.比较运算符演示：需求（查找价格500以上的商品）
select * from goods where price>500;
# 需求1：查找不是自营的商品；
select * from goods where is_self!='自营';# 或者：select * from goods where is_self<>'自营'
# 需求2：查找单价在800~3000元的商品信息，只要商品名和价格
select name '商品名',price as '价格' from goods where price between 800 and 3000; # 方法一：范围查询
select name '商品名',price as '价格' from goods where price>=800 and price<=3000;# 方法二：逻辑查询
# 需求3：查找第二个字是 霸的 商品信息 ，商品共计两个字；
select * from product where pname like '_霸';
# 需求4：查找含有斯的 商品信息 ；
select * from product where pname like '%斯%';
# 需求5：查询单价是200，800或5000的商品信息
select * from product where price in(200,800,500); # 或者：select * from product where price=200 or price=800 or price=5000; 
# 需求6：查询单价不是200，800或5000的商品信息
select * from product where price not in(200,800,500);# 或者：select * from product where price!=200 and price!=800 and price!=5000;
# 需求7：查询没有分类ID(null)的商品信息；
select * from product where category_id is null; 
# （3）排序查询：
# -------------------------案例3：排序查询--------------------------------
/* 
格式：
     select * from 数据表名 order by 排序的列[asc/desc],排序的列2[asc/desc];
细节：
     1.如果不写asc|desc，默认是asc(升序)，它可以省略不写。
     2.无论SQL简单还是复杂，order by 都需要写到语句的最后，严格意义上讲，它应该写到limit的前边。
 */

# 1. 查看表格
use mysql_practice;       
select * from product;
# 2.按照价格进行升序排列
select * from product order by price;
select * from product order by price asc;  # 默认是升序，asc可以不写！！！
# 3.按照价格进行降序排列
select * from product order by price desc;   # desc 降序必须写！！！
# 4.按照价格降序排列，如果价格一致则按照jd;
select * from product order by price desc, pid desc; 
# -----------------------------------------------------    快捷键  ------------------------------------------------------------
/*
（2）alt+x：表示多选执行；
（3）ctrl+/：表示选中后注释；
（4）ctrl+shif+f:快捷键切换繁体字；
（5）ctrl+shif+x：选中大写，ctrl+shif+y:选中小写
（6）ctrl+shif+I：表示语法格式化（一句变多句）
（7）ctrl+shif+J：表示语法格式化（多句变一句）
*/
# （4）聚合函数：
# -------------------------案例4：聚合查询--------------------------------
/*
概述：
    以列为单位进行操作，例如：计算某列值的个数，最大最小值和平均值等
 
   常用的聚合函数：
   1.count(col);
   max(col);
   min(col);
   sum(col);
   avg(col);
   
 面试题：
       count(*),count(1),count(列)的区别是什么？
       注意：*表示表中所有字段（列）      
 答案：
     1.是否统计null值，
           count(列)不统计，count(*)统计，count(1)统计，
     2.效率问题，效率从高到低分别是：
           count（主键列）>count(1)>count(列)>count(*)
 */

# 1. 查看表格
select * from product;
# 2.查看商品价格的求和，最大值，最小值，平均数据
select
    count(price) as num_price,
    sum(price) as sum_price,
    max(price) as max_price,
    min(price) as min_price,
    round(avg(price),2) as avg_price  # 注意：round用于对小数位次进行限制（round(x,n)）
from
    product;


# （5）分组查询函数：
# -------------------------案例5：分组查询--------------------------------
/*
 格式：
 select 
     *
 from
     数据表名
 where
     组前筛选
 group up
     分组列1，分组列2…………
 having
     组后筛选；
 
 语法架构：
 select 
     分组字段，
     聚合函数
 from 表名
 group by 分组字段，
 
 */
# 需求1：统计每个类别的商品数量，根据category_id分组，count()计数即可。
use mysql_practice;
select * from product;
select
	category_id,  # 分组字段
	count(pid) as total_num  # 聚合函数
from
	product
group by
	category_id;  # 分组字段
# 注意：分组+聚合，先分组后聚合!!!

# 需求2：统计每个类别的商品数量,只显示商品数量在1以上的分类
select
	pname,
    count(pid) as goods_num
from
	product
group by
	pname
having       # 组后筛选，用having 不用 where!!!
	goods_num>1;
-- 注意：having和where 的区别：（1）作用不用一个组前，一个组后；（2）having可以跟聚合函数，where不可以！！！


# （6）分组查询函数：
# -------------------------案例6：去重查询--------------------------------
/*
去重概述：
        把相同的数据移除掉，只保留部分；
方式：
        思路1：distinct关键字实现；
        思路2：分组实现；
 
  */
# 1.查看表数据
use mysql_practice;
select * from product;
# 2.查看（去重后）所有的分类id
select distinct category_id from product;
# 3.按照分类id，价格进行去重，把category_id和price当作整体去去重的；
select distinct category_id,price from product;
# 4.去重思路2：分组去重；
select distinct category_id from product group by category_id;   # 单条件分组
# 按照整行行去重，注意：多数据不推荐！！！
select distinct * from product;
# 多数据常用去重方法：分组去重
select distinct category_id,price from product group by category_id,price;  # 多条件分组
/*
 场景：查询结果中重复的行需要去重时
 注意：distinct是针对查询结果中的整行内容进行的去重，不是单个字段；
 eg：select distinct name from student; 查询姓名列，顺便去重
 */

# （7）分组查询函数：
# -------------------------案例7：分页查询-------------------------------
/*
 分页查询的好处：
      1. 提高用户的体验
      2.降低服务器的压力
      3.降低浏览压力
 语法：
      select * from 数据表名 limit 起始索引，数据条数；（注意：起始索引方式与python一致！！！）
 细节：
      1.在SQL中，每条数据都有索引，且索引从0开始。
      2.关于分页有四个参数的计算规则：
           总页数：（数据总条数+每页的数据条数-1）//每页的数据条数  或者：数据总条数/每页数据条数+1/0
           每页的数据条数：产品经理
           每页的起始索引：（当前的页数-1）*每页的数据条数
           数据总条数：count(主键列)
 （1）limit在什么场景下使用？
         场景：获取查询结果中指定范围内的行；
 （2）limit查询的语法是什么？
         语法：select……from 表名 limit m,n;
         注意：当limit查询的数据不存在时，不报错，只是没结果！！！           
 */
# 1.查看数据
select * from product;
# 2.场景1：3条/页；
select * from product limit 0,3; # 第一页
select * from product limit 3,3; # 第二页
select * from product limit 6,3; # 第三页
select * from product limit 9,3; # 第四页
select * from product limit 12,3;# 第五页
# 3.场景2：5条/页
select * from product limit 0,5; # 第一页
select * from product limit 10,5; # 第二页
select * from product limit 15,5; # 第三页
# 4.练习1：获取所有商品中，价格次高的商品信息；
select * from product order by price desc limit 1,1;
# 5.练习2：获取所有自营商品中，评分最高的商品信息；
select * from product where category_id='c002' order by price desc limit 0,1;



# ---------------------------------------一、多表关系介绍----------------------------------------------------
/*
学习目标：表之间的三种关系（一对一、一对多、多对多）
（1）一对多如何建表？
答：在多的一方新建一列，充当外键列，去关联的乙方的主键列；注意：外表的外键列不能出现主表的主键列没有的数据；
（2）多对多建表原则？
答：新建中间表，该表至少有3列，第一列为自身表的主键列，其他2列充当外键列，分别去关联多的两方的主键列；
（3）一对一？
答：两表直接连接对应；
*/
/*
外键介绍：
        概念：假设有两张表A和B，B表的某列的值引用了A表的主键列的值，则B表的这一列称为B表的外键列（foreign key）,A：主表，B：从表
需求：新建部门表（dept,department）和员工表（emp），他们之间是一对多的关系，请用外键约束完成限定；
细节：实际开发种，外键约束相对少，而是通过代码层面，对表数据进行限定；
回顾：一对多建表原则，在多的一方新建1列，充当外键列，去关联的一方的主键列；
*/
# 1.切库，查表
use mysql_practice;
show tables;
# 2.创建主表——部门表.
create table dept(
id int primary key auto_increment,  # 部门id
name varchar(10)                # 部门名
);
# 3.创建外表——员工表.
create table emp(
id int primary key auto_increment,      # 员工id
name varchar(10),                   # 员工姓名
salary double,                      # 员工工资
dept_id int ,                       # 员工所属的部门id 
#constraint fk_dept_emp 
foreign key(dept_id) references dept(id)  
 # 格式：[constraint 外键约束名] foreign key(外键列) references 主表名（主键列名）
);
# 4.插入数据
insert into dept values(null,'人事部'),(null,'研发部'),(null,'行政部');

insert into emp values(null, '胡歌', 333333, 1);
insert into emp values(null, '刘亦菲', 222222, 2);
insert into emp values(null, '迪丽热巴', 111111, 2);
insert into emp values(null, '水冷哥', 11.1, 3);
# 5.查看表数据
select * from dept;
select * from emp;

# 6. 删除外键约束.
# 格式: alter table 外表名 drop foreign key 外键约束名;
alter table emp drop foreign key fk_dept_emp;

# 7. 建表后, 添加外键约束, 前提: 表数据之间必须是合法的.
# 格式: alter table 外表名 add [constraint 外键约束名] foreign key(外键列名) references 主表名(主键列名);

# ---------------------------------------二、多表查询------------------------------------------------
/*（1）交叉连接查询（得出笛卡尔积）：

格式1：select * from 表1，表2；
格式2：select * from 表1 jion 表2；
*/
# 1. 创建hero表
create table hero (
    hid int primary key auto_increment,   # 英雄id
    hname varchar(255),                   # 英雄名
    kongfu_id int                         # 功夫id
);

# 2. 创建kongfu表
create table kongfu (
    kid int primary key auto_increment,   # 功夫id
    kname varchar(255)                    # 功夫名
);

# 3. 添加表数据.
# 插入hero数据
insert into hero values(1, '鸠摩智', 9),(3, '乔峰', 1),(4, '虚竹', 4),(5, '段誉', 12);
# 插入kongfu数据
insert into kongfu values(1, '降龙十八掌'),(2, '乾坤大挪移'),(3, '猴子偷桃'),(4, '天山折梅手');

# 4. 查看表数据.
select * from hero;
select * from kongfu;

# 5.交叉连接结果：  (注意：查询结果=两张表的笛卡尔积，即：表A的总条数*表B的总条数，会产生大量的脏数据，实际开发一般不用！！！)

select * from hero,kongfu;
select * from hero jion kongfu;

/*
 （2）内连接查询：
内连接：inner(交集)
   */
# 查询结果：表的交集
# 隐式内连接：
# 格式1：select * from 表1，表2 where 关联条件；
select * from hero as h,kongfu as kf where h.kongfu_id=kf.kid; # 标准写法
select * from hero,kongfu where kongfu_id=kid;           # as 可以省略不写，因为没有重名字段


# 显式内连接（推荐使用，效率高）
# 格式2：select * from 表1 inner jion 表2 on 关联条件；# 注意：inner可以省略不写；
select * from hero inner join kongfu on kongfu_id=kid;

# 显式内连接相比隐式内连接的优势：显式先做关联条件判断，后进行select。而隐式先进行select变成交叉查询后进行where 关联条件！！！

/*
 （3）外连接查询：
 左外连接：left（交集+左表内容）
 右外连接：right（交集+右表内容）
   */

# 场景1: 左外连接, 查询结果 = 左表的全集 + 交集.
# 格式: select * from 表1 left outer join 表2 on 关联条件;      # outer可以省略不写.
select * from hero h left outer join kongfu kf on h.kongfu_id = kf.kid;
select * from hero h left join kongfu kf on h.kongfu_id = kf.kid;         # 效果同上, outer可以省略不写.


# 场景2: 右外连接, 查询结果 = 右表的全集 + 交集.
# 格式: select * from 表1 right outer join 表2 on 关联条件;     # outer可以省略不写.
select * from hero h right outer join kongfu kf on h.kongfu_id = kf.kid;
select * from hero h right join kongfu kf on h.kongfu_id = kf.kid;       # 效果同上, outer可以省略不写.

# 我们可以用 union 关键字 把 左外连接 和 右外连接的结果 合并到一起, 形成 满外连接的效果.
select * from hero h left join kongfu kf on h.kongfu_id = kf.kid    # 左外连接
union   # 自带去重distinct的操作了！！！
select * from hero h right join kongfu kf on h.kongfu_id = kf.kid;   # 右外连接

/*
 （4）子查询：
 */
# 合并版：子查询。
#        主查询(父查询)                  子查询
select * from product where price = (select max(price) from product);

# 实际开发写法，连接查询。
select
    *
from
    product p
join
    (select max(price) price from product) t1
on
    p.price = t1.price;


