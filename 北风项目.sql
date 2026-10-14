use north_wind;
-- 关闭外键检查，方便删旧表
set foreign_key_checks = 0;

-- 删除全部旧表
drop table if exists order_details;
drop table if exists orders;
drop table if exists products;
drop table if exists customers;
drop table if exists employees;
drop table if exists suppliers;
drop table if exists categories;

-- 1. categories 分类表
create table categories (
  category_id int primary key auto_increment,
  category_name varchar(15) not null,
  description text
);

-- 2. suppliers 供应商表
create table suppliers (
  supplier_id int primary key auto_increment,
  company_name varchar(40) not null,
  contact_name varchar(30),
  contact_title varchar(30),
  address varchar(60),
  city varchar(15),
  region varchar(15),
  postal_code varchar(10),
  country varchar(15),
  phone varchar(24),
  fax varchar(24),
  homepage text
);

-- 3. employees 员工表
create table employees (
  employee_id int primary key auto_increment,
  last_name varchar(20) not null,
  first_name varchar(10) not null,
  title varchar(30),
  title_of_courtesy varchar(25),
  birth_date date,
  hire_date date,
  address varchar(60),
  city varchar(15),
  region varchar(15),
  postal_code varchar(10),
  country varchar(15),
  home_phone varchar(24),
  extension varchar(4),
  photo blob,
  notes text,
  reports_to int,
  photo_path varchar(255)
);

-- 4. customers 客户表
drop table if exists customers;
create table customers (
  customer_id varchar(10) primary key,
  company_name varchar(40) not null,
  contact_name varchar(30),
  contact_title varchar(30),
  address varchar(60),
  city varchar(15),
  region varchar(15),
  postal_code varchar(10),
  country varchar(15),
  phone varchar(24),
  fax varchar(24)
);

-- 5. products 产品表
create table products (
  product_id int primary key auto_increment,
  product_name varchar(40) not null,
  supplier_id int,
  category_id int,
  quantity_per_unit varchar(20),
  unit_price decimal(10,2) default 0,
  units_in_stock int default 0,
  units_on_order int default 0,
  reorder_level int default 0,
  discontinued tinyint not null default 0
);

-- 6. orders 订单表
drop table if exists orders;
create table orders (
  order_id int primary key auto_increment,
  customer_id varchar(10),
  employee_id int,
  order_date date,
  required_date date,
  shipped_date date,
  ship_via int,
  freight decimal(10,2) default 0,
  ship_name varchar(40),
  ship_address varchar(60),
  ship_city varchar(15),
  ship_region varchar(15),
  ship_postal_code varchar(10),
  ship_country varchar(15)
);

-- 7. order_details 订单明细表
create table order_details (
  order_id int,
  product_id int,
  unit_price decimal(10,2) not null,
  quantity int not null,
  discount decimal(4,2) not null,
  primary key(order_id, product_id)
);

-- 恢复外键检查
set foreign_key_checks = 1;


-- 1. categories 分类表
insert into categories(category_name,description) values
('饮料','软饮料、咖啡、茶、啤酒'),
('调味品','甜酱、调料、酱汁'),
('点心','甜点、面包'),
('乳制品','奶酪、牛奶制品'),
('谷物/麦片','谷物、面包'),
('肉/家禽','鲜肉、肉制品'),
('海鲜','海产、鱼');

-- 2. suppliers 供应商
insert into suppliers(company_name,contact_name,contact_title,address,city,region,postal_code,country,phone,fax,homepage) values
('exotic liquids ltd','niels pedersen','sales manager','kugelstr. 28','berlin',null,'1010','germany','030-0074321','030-0076543',null),
('new orleans caajuns','cheryl carson','marketing rep','49 rue des boulangers','annecy',null,'74000','france','(503) 555-9876',null,null),
('grandma kellys homestead','regina murphy','sales rep','707 oxford st','cork',null,null,'ireland','(1) 555-0739',null,null),
('tokyo traders','yoshi nagase','sales manager','9-8 sekiguchi','tokyo',null,'100','japan','(03) 3555-5011',null,null),
('mayumis','mayumi ohno','marketing rep','calle del rosario 23','mexico d.f.',null,'100','mexico','(5) 555-2922',null,null),
('pavlova, ltd.','ivan pavlov','sales manager','ul. mira 14','moscow',null,'100000','russia','(095) 555-2222',null,null),
('specialty biscuits, ltd.','devon peters','sales rep','29 king george way','london',null,'sw1 4rh','uk','(171) 555-2222',null,null),
('maison de decembre','pierre raoul','sales rep','67, rue des cerisiers','montreal','quebec','h1j 1c5','canada','(514) 555-9999',null,null),
('gai bouchers','fumiya tanaka','owner','12 sao paulo','sao paulo',null,'05432-043','brazil','(11) 555-2346',null,null);

-- 3. employees 员工
insert into employees(last_name,first_name,title,title_of_courtesy,birth_date,hire_date,address,city,region,postal_code,country,home_phone,extension,reports_to,notes,photo_path) values
('davolio','nancy','sales representative','ms.','1948-12-08','1992-05-01','507 - 20th ave. e.','seattle','wa','98122','usa','(206) 555-9857','5467',2,'education includes a bachelor''s degree in psychology from colorado state university.','nancy.bmp'),
('fuller','andrew','vice president, sales','dr.','1952-02-19','1992-08-14','908 w. capital way','tacoma','wa','98401','usa','(206) 555-9482','3457',null,'received a ph.d. in international marketing from the university of washington.','andrew.bmp'),
('leverling','janet','sales representative','ms.','1963-08-30','1992-04-01','722 moss bay','kirkland','wa','98033','usa','(206) 555-3412','3355',2,'janet has a bs degree in chemistry.','janet.bmp'),
('peacock','margaret','sales representative','ms.','1937-09-19','1993-05-03','4110 old redmond rd.','redmond','wa','98052','usa','(206) 555-8122','5176',2,'margaret holds a bachelor''s degree in english literature.','margaret.bmp'),
('buchanan','steven','sales manager','mr.','1955-03-04','1993-10-17','14 northfield ave.','london',null,'sw1 8jr','uk','(71) 555-4848','3453',2,'steven graduated from oxford with a degree in english.','steven.bmp'),
('suyama','michael','sales representative','mr.','1963-07-02','1993-10-17','7 houndstooth rd.','london',null,'wg2 7lt','uk','(71) 555-7773','4280',5,'michael is a graduate of cambridge university.','michael.bmp'),
('king','robert','sales representative','mr.','1960-05-29','1994-01-02','edgeham hollow','london',null,'rg2 9hp','uk','(71) 555-5598','4659',5,'robert has a degree in business administration.','robert.bmp'),
('callahan','laura','inside sales coordinator','ms.','1958-01-09','1994-03-05','4726 - 11th ave. s.','seattle','wa','98105','usa','(206) 555-1189','2344',2,'laura received a ba in journalism from the university of montana.','laura.bmp');

-- 4. customers 客户
insert into customers(customer_id,company_name,contact_name,contact_title,address,city,region,postal_code,country,phone,fax) values
('alfki','alfreds futterkiste','maria anders','sales representative','obere str. 57','berlin',null,'1010','germany','030-0074321','030-0076543'),
('anatr','ana trujillo emparedados y helados','ana trujillo','owner','avda. de la constitución 222','mexico d.f.',null,'05021','mexico','(5) 555-4729','(5) 555-3745'),
('anton','antonio moreno taquería','antonio moreno','owner','mataderos 2312','mexico d.f.',null,'05023','mexico','(5) 555-3932',null),
('arout','around the horn','thomas hardy','sales representative','120 hanover sq.','london',null,'wa1 1dp','uk','(171) 555-7788','(171) 555-6750'),
('bergbs','berglunds snabbköp','christina berglund','marketing manager','berggsvägen 9','luleå',null,'s-958 22','sweden','0921-12 34 65','0921-12 34 67'),
('blonp','blondesddsl père et fils','frédérique citeaux','marketing manager','24, place kléber','strasbourg',null,'67000','france','88.60.15.31','88.60.15.32'),
('bolid','bolido comidas preparadas','marcos romero','owner','calle mercedes, 23','madrid',null,'28001','spain','(91) 745 6200','(91) 745 6210'),
('bonap','bon app''','laurence lebel','owner','12, rue des boulangers','marseille',null,'13008','france','91.24.45.40','91.24.45.41'),
('botto','bottom-dollar markets','elizabeth lincoln','sales representative','23 main st.','barquisimeto','lara','3100','venezuela','(58) 2 555-4722','(58) 2 555-4723');

-- 5. products 商品
insert into products(product_name,supplier_id,category_id,quantity_per_unit,unit_price,units_in_stock,units_on_order,reorder_level,discontinued) values
('chai',1,1,'10 boxes x 20 bags',18.00,39,0,10,0),
('chang',1,1,'24 - 12 oz bottles',19.00,17,40,25,0),
('aniseed syrup',1,2,'12 - 550 ml bottles',10.00,13,70,25,0),
('chef anton''s cajun seasoning',2,2,'48 - 6 oz jars',22.00,53,0,0,0),
('grandma''s boysenberry spread',2,2,'36 jars',25.00,0,0,0,1),
('northwoods cranberry sauce',2,2,'12 - 12 oz jars',21.00,10,0,0,0),
('uncle bob''s organic dried pears',3,7,'12 - 1 lb pkgs.',30.00,15,0,10,0),
('ikura',4,7,'12 - 200 ml jars',31.00,10,0,0,0),
('queso cabrales',5,4,'1 kg pkg.',21.00,22,30,0,0),
('queso manchego la pastora',5,4,'10 - 500 g pkgs.',38.00,8,0,0,0);

-- 6. orders 订单
insert into orders(customer_id,employee_id,order_date,required_date,shipped_date,ship_via,freight,ship_name,ship_address,ship_city,ship_region,ship_postal_code,ship_country) values
('alfki',5,'1996-07-04','1996-08-01','1996-07-16',3,32.38,'alfreds futterkiste','obere str. 57','berlin',null,'1010','germany'),
('anatr',6,'1996-07-05','1996-08-16','1996-07-10',1,11.61,'ana trujillo emparedados y helados','avda. de la constitución 222','mexico d.f.',null,'05021','mexico'),
('anton',4,'1996-07-08','1996-08-05','1996-07-12',2,65.83,'antonio moreno taquería','mataderos 2312','mexico d.f.',null,'05023','mexico'),
('arout',3,'1996-07-08','1996-08-05','1996-07-15',1,41.34,'around the horn','120 hanover sq.','london',null,'wa1 1dp','uk'),
('bergbs',4,'1996-07-09','1996-08-06','1996-07-11',2,51.30,'berglunds snabbköp','berggsvägen 9','luleå',null,'s-958 22','sweden'),
('blonp',1,'1996-07-10','1996-08-07','1996-07-16',3,3.05,'blondesddsl père et fils','24, place kléber','strasbourg',null,'67000','france'),
('bolid',2,'1996-07-11','1996-08-08','1996-07-23',1,55.28,'bolido comidas preparadas','calle mercedes, 23','madrid',null,'28001','spain'),
('bonap',3,'1996-07-12','1996-08-09','1996-07-15',2,81.91,'bon app''','12, rue des boulangers','marseille',null,'13008','france');

-- 7. order_details 订单明细（最后插！外键依赖order和product）
insert into order_details(order_id,product_id,unit_price,quantity,discount) values
(1,1,18.00,12,0),
(1,2,19.00,10,0),
(2,3,10.00,5,0),
(2,4,22.00,6,0),
(3,5,25.00,2,0),
(3,6,21.00,9,0),
(4,7,30.00,4,0),
(4,8,31.00,8,0),
(5,9,21.00,2,0),
(5,10,38.00,3,0);

use north_wind;
-- 依次查看7张表，确认数据是否插入成功
select * from categories;
select * from suppliers;
select * from employees;
select * from customers;
select * from products;
select * from orders;
select * from order_details;


-- 需求1：查询employees表全部数据
select * from employees;
-- 需求2：查询客户的 customer_id, company_name, contact_name, contact_title, city, country，按国家排序
select * from customers;
select
	customer_id,
	company_name,
	contact_name,
	contact_title,
	city,
	country
from
	customers
order by
	country asc;
-- 需求3：查询product_name, category_name, quantity_per_unit, unit_price, units_in_stock，按unit_price排序
select product_name, category_name, quantity_per_unit, unit_price, units_in_stock 
from categories as c
join products as p 
on c.category_id=p.category_id
order by unit_price desc;
-- 需求4：找出提供4种以上不同商品的供应商，输出supplier_id, company_name
 select * from products;
 select * from suppliers;
#------------------------------------------
select s.company_name,s.supplier_id,count(p.product_id) as goods_num
from products as p
join suppliers as s
on p.supplier_id=s.supplier_id
group by s.company_name,s.supplier_id
having goods_num >4;
-- 需求5：查询所有产品的product_name、unit_price，单价大于20，按价格降序
select product_name,unit_price
from products 
where unit_price>20
order by unit_price desc;
-- 需求6：查询每个分类下商品数量，输出category_id,category_name,商品数量
select * from categories;
select * from products;
select c.category_id,c.category_name,count(p.product_id) as goods_num
from categories as c
join products as p
on c.category_id=p.category_id
group by c.category_id,c.category_name
-- 需求7：查询订单总金额大于300的订单，输出order_id,总金额
# select order_id,(unit_price*quantity) as sum
# from order_details;
select order_id,sum(unit_price*quantity) as sum
from order_details
group by order_id
having sum>300;
-- 需求8：查询员工姓名，以及该员工负责了多少订单
# select * from employees;
select concat(e.first_name , ' ' , e.last_name) as name,count(o.order_id) as num   # 字符串拼接方式：concat(a , ' ' , b)___5个空格！！！
from employees as e
left join orders as o
on e.employee_id=o.employee_id
group by e.employee_id,e.last_name,e.first_name;
 #  解题思路：（1）实体关系————一（员工）对多（订单表）；（2）左表（所有的订单数据），右表（所有的员工id数据），组合后（有员工的订单表）；（3）代码操作和验证

-- 需求9：查询1996年下单的所有订单信息
select * 
from orders as o
join order_details as d
on o.order_id=d.order_id
where year(o.order_date)=1996;   # 查年份：year函数！！！
-- 需求10：查询客户来自哪些国家，去重
select distinct country as country_categories 
from customers;
-- 需求11：查询单价最高的5个商品
select product_name,unit_price  
from products
order by unit_price desc
limit 0,5;
-- 需求12：查询每个国家客户数量，按数量降序
select country,count(customer_id) as country_num
from customers
group by country
order by country_num desc;
-- 需求13：查询订单详情，附带商品名称、分类名称
select o.order_id,o.product_id,o.unit_price,o.quantity,o.discount,customer_id, employee_id, order_date, required_date, shipped_date, ship_via, freight, ship_name, ship_address, ship_city, ship_region, ship_postal_code, ship_country,p.product_name,c.category_name
from products as p
join categories as c on p.category_id=c.category_id
join order_details as o  on p.product_id=o.product_id
join orders as d  on o.order_id=d.order_id;
-- 需求14：查询每个员工的订单总销售额
# 方案一（不加入没订单的员工）：
select concat(e.first_name , ' ' , e.last_name) as name,sum(unit_price*quantity) as sum_money
from employees as e
join orders as d on e.employee_id=d.employee_id
join order_details as o on d.order_id=o.order_id
group by e.employee_id,e.last_name,e.first_name;
# 方案二（加入没订单的员工）：
select concat(e.first_name, ' ', e.last_name) as name, ifnull(sum(o.unit_price * o.quantity),0) as total_sales
from employees as e
left join orders as d on e.employee_id=d.employee_id
left join order_details as o on d.order_id=o.order_id 
group by e.employee_id,e.last_name,e.first_name;
# 知识点补充：sum(null)=null，而不是0!!!,if语句：ifnull(值，否则替代值)；if(条件，true输出，false输出)，eg:if（sum(a*b) is null,c,d）

-- 需求15：查询销售额最高的前3名员工

select concat(e.first_name, ' ', e.last_name) as name, ifnull(sum(o.unit_price * o.quantity),0) as total_money
from employees as e
left join orders as d on e.employee_id=d.employee_id
left join order_details as o on d.order_id=o.order_id 
group by e.employee_id,e.last_name,e.first_name
order by total_money desc
limit 0,3;
-- 需求16：查询哪些客户没有下过任何订单

select concat(e.first_name, ' ', e.last_name) as name, ifnull(sum(o.unit_price * o.quantity),0) as total_sales
from employees as e
left join orders as d on e.employee_id=d.employee_id
left join order_details as o on d.order_id=o.order_id 
group by e.employee_id,e.last_name,e.first_name
having total_sales=0;

-- 需求17：查询哪些商品从来没有被下单

select p.product_id,p.product_name as goods_name
from products as p
left join order_details as o on p.product_id=o.product_id
where o.product_id is null
group by p.product_id,p.product_name;
# 验证：select * from order_details;

-- 需求18：查询每个月份的订单数量

select * from categories;

select month(o.order_date) as time,count(distinct o.order_id) as order_num
from order_details as d
join orders as o on d.order_id=o.order_id
group by month(o.order_date);
-- 需求19：查询每个分类的平均商品单价
# 方案一(加入没涉及到的商品分类)：
select category_name as name,if (avg(p.unit_price) is null,0,avg(p.unit_price)) as avg_price
from products as p
right join categories as c on p.category_id=c.category_id
group by c.category_name;
# 方案二（只算products的商品分类）：
select category_name as name,avg(p.unit_price) as avg_price
from products as p
join categories as c on p.category_id=c.category_id
group by c.category_name;

-- 需求20：查询订单运费(freight)大于所有订单运费平均值的订单
select * 
from orders
where freight>(select avg(freight) from orders);
# 注意：聚合函数只能在分组之后，（select/having/子查询中出现！！！）

-- 需求21：查询每个客户的累计消费总额，按总额降序
use north_wind;
select *from customers;

select c.customer_id,if(sum(d.unit_price*d.quantity) is null,0,sum(d.unit_price*d.quantity)) as sum_price
from customers as c
left join orders o on c.customer_id=o.customer_id
left join order_details as d on o.order_id=d.order_id
group by c.customer_id
order by sum_price desc;
-- 需求22：找出消费总额最高的客户
select c.customer_id,if(sum(d.unit_price*d.quantity) is null,0,sum(d.unit_price*d.quantity)) as sum_price
from customers as c
left join orders o on c.customer_id=o.customer_id
left join order_details as d on o.order_id=d.order_id
group by c.customer_id
order by sum_price desc
limit 0,1;
-- 需求23：查询员工的直属上级姓名（自连接）
select * from employees;

select 
    concat(e.first_name,' ',e.last_name) as emp_name,
    concat(m.first_name,' ',m.last_name) as manager_name
from employees e
left join employees m  on e.reports_to = m.employee_id;

# 总结：自查询（把两张相同的表进行join拼接，字段会重复！！！）；注意：实体关系（例如一对多），不直接影响（left/right）join左右的顺序，而是根据题目决定！！！
-- 需求24：查询订单发货城市ship_city 和客户所在城市不一致的订单
select * from orders;
select * from customers;

select o.*
from orders as o 
join customers as c on o.customer_id=c.customer_id
where o.ship_city!=c.city;

-- 需求25：统计每个供应商提供商品的平均价格
select s.supplier_id,s.company_name,avg(p.unit_price) as avg_price
from suppliers as s
join products as p on s.supplier_id=p.supplier_id
group by s.supplier_id,s.company_name;

-- 需求26：查询商品名称包含'ch'的商品
select * from products where product_name like '%ch%';
-- 需求27：查询订单数量大于10的客户
select c.customer_id,count(order_id) as order_quantity
from customers as c 
join orders as o on c.customer_id=o.customer_id
group by c.customer_id
having order_quantity >10;
-- 需求28：查询每一笔订单的商品种类数量
# （1）中文理解一：
select order_id,count(distinct product_id) as goods_quantity
from order_details
group by order_id;
# （2）中文理解二：
select d.order_id,count(distinct c.category_id) as goods_category_quantity
from order_details as d
join products as p on  d.product_id=p.product_id
join categories as c on p.category_id=c.category_id
group by d.order_id;
-- 需求29：查询员工入职时间，按入职时间升序
select hire_date,concat(first_name, ' ',last_name) from employees order by hire_date asc;

-- 需求30：统计每个国家的订单总运费
select * from orders;
select * from customers;

select  c.customer_id,c.country,if(sum(o.freight) is null,0,sum(o.freight)) as tran_price
from customers as c
left join orders as o on c.customer_id=o.customer_id
group by  c.customer_id,c.country;
-- 需求31：查询1997年，每个月的销售总额
-- 需求32：使用窗口函数，给每个分类内商品按单价排名 row_number
-- 需求33：查询每个客户最近一次下单时间
-- 需求34：统计每个员工，每个月的订单销售额，窗口函数累加
















