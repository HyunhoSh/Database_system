-- drop database hmdb;

create database hmdb;
use hmdb;

create table product(
   product_id int primary key,
   product_name varchar(20),
   price int,
   category varchar(20),
   product_desc varchar(20),
   sku varchar(20)
);

create table discount(
   discount_id int,
   discount_percent int,
   discount_desc varchar(20),
   primary key(discount_id)
);

create table order_items(
   order_items_id int primary key,
   product_id int,
   foreign key(product_id) references product(product_id)
);

create table user(
   user_id int primary key,
   username varchar(20),
   name varchar(20),
   gender varchar(5),
   address varchar(30),
   telephone_number varchar(13)
);


create table item_cart(
   item_cart_id int primary key,
   quantity int,
   product_id int,
   user_id int,
   foreign key(product_id) references product(product_id),
   foreign key(user_id) references user(user_id)
);

create table order_details(
   order_details_id int primary key,
   product_number int,
   total_price int,
   user_id int,
   order_items_id int,
   foreign key(user_id) references user(user_id),
   foreign key(order_items_id) references order_items(order_items_id)
);

create table payment_details(
   payment_id int primary key,
   amount int,
   provider varchar(20),
   status varchar(20),
   receipt varchar(20),
   order_details_id int,
   foreign key(order_details_id) references order_details(order_details_id)
);


-- 2번
-- user, order_details, discount, product

--  create table user(
--    user_id int primary key,
--    username varchar(20),
--    name varchar(20),
--    gender varchar(5),
--    address varchar(30),
--    telephone_number varchar(13)
-- );

insert into user values ('001','hhshin','신현호','M','경기도 수원시 영통구','01000000000');
insert into user values ('010','gunnoo','이건우','M','서울특별시 마포구', '01000000001');
insert into user values ('100','Kindess','박친절','F','대구광역시 달성구','01000000011');
insert into user values ('011','James98','호현호','M','서울특별시 중구','01000000111');
insert into user values ('111','hello02','우건우','M','서울특별시 성북구','01011000000');
select * from user;
 
--  create table product(
--    product_id int primary key,
--    product_name varchar(20),
--    price int,
--    category varchar(20),
--    product_desc varchar(20),
--    sku varchar(20)
-- );
 
insert into product values (45924, 'red_shoes', 30000, "shoes", "for women", "K898290"); 
insert into product values (34892, 'students_bag', 40000, "bags", "for students", "B939309");
insert into product values (88392, 'khaki_shorts', 20000, "shorts", "military style", "S839329");
insert into product values (00372, 'black_wallet', 100000, "wallets", "for business men", "W384248");
insert into product values (74022, 'micky_mouse_hoodie', 60000, "hoodies", "disney merch", "H383024");
select * from product;


-- create table item_cart(
--    item_cart_id int primary key,
--    quantity int,
--    product_id int,
--    foreign key(product_id) references product(product_id)
-- );



-- create table discount(
--    discount_id int,
--    discount_percent int,
--    discount_desc varchar(20),
--    product_id int,
--    foreign key(product_id) references product(product_id),
--    primary key(discount_id)
-- );

insert into discount values (00001, 13, 'shoes');
insert into discount values (00242, 22, 'bags');
insert into discount values (28489, 04, 'shorts');
insert into discount values (33902, 30, 'wallets');
insert into discount values (45354, 63, 'hoodies');
select * from discount;

-- create table item_cart(
--    item_cart_id int primary key,
--    quantity int,
--    product_id int,
--    user_id int,
--    foreign key(product_id) references product(product_id),
--    foreign key(user_id) references user(user_id)
-- );

-- insert into user values ('001','hhshin','신현호','M','경기도 수원시 영통구','01000000000');
-- insert into user values ('010','gunnoo','이건우','M','서울특별시 마포구', '01000000001');
-- insert into user values ('100','Kindess','박친절','F','대구광역시 달성구','01000000011');
-- insert into user values ('011','James98','호현호','M','서울특별시 중구','01000000111');
-- insert into user values ('111','hello02','우건우','M','서울특별시 성북구','01011000000');

insert into item_cart values ('200',1,45924,'001');
insert into item_cart values ('210',2,34892,'010');
insert into item_cart values ('220',3,88392,'001');
insert into item_cart values ('230',2,00372,'011');
insert into item_cart values ('240',7,74022,'111');
select * from item_cart;

drop table item_cart;

-- use where
select D.discount_id
from discount as D
where D.discount_percent = 30;

select I.quantity
from item_cart as I
where I.product_id = 88392;

-- use SET operation
select P.product_id, P.product_name, I.item_cart_id
from product as P
left join item_cart as I on P.product_id = I.product_id;
-- create table item_cart(
--    item_cart_id int primary key,
--    quantity int,
--    product_id int,
--    user_id int,
--    foreign key(product_id) references product(product_id),
--    foreign key(user_id) references user(user_id)
-- );
--  create table user(
--    user_id int primary key,
--    username varchar(20),
--    name varchar(20),
--    gender varchar(5),
--    address varchar(30),
--    telephone_number varchar(13)
-- );
select *
from user as U
join item_cart as I on U.user_id = I.user_id;

-- create table product(
--    product_id int primary key,
--    product_name varchar(20),
--    price int,
--    category varchar(20),
--    product_desc varchar(20),
--    sku varchar(20),
-- );

select * from product;
select * from item_cart;
-- use sunquery
select P.product_id
from product as P 
where P.price>35000 and product_id in (select I.product_id
                                       from item_cart as I
									   where I.quantity>2);
                                       
select * from user;

select U.name 
from user as U
where U.gender = 'M' and U.user_id = (select I.user_id
from item_cart as I where I.product_id = '372');


select * from item_cart;


--  create table user(
--    user_id int primary key,
--    username varchar(20),
--    name varchar(20),
--    gender varchar(5),
--    address varchar(30),
--    telephone_number varchar(13)
-- );


select * from product;
-- c문제
-- 1. 가격 변경
update product set price = price*1.1;
select * from product;

-- 2. 수량 변경
-- select * from item_cart;
update item_cart set quantity = quantity*2 where product_id = '88392';

select * from item_cart;
-- d문제

-- 1. 카테고리
-- 2. 가격별 서칭
-- 3. 할인율
-- 4. 집 주소
-- 5. 휴대폰 번호

-- 2. 가격별 서칭
select * from product;

select product_id, price  
from product
where price<70000;

-- 3. 할인율
select * from discount;

update discount set discount_percent = discount_percent*1.5 where discount_desc = 'shorts';

-- 4. 집 주소 변경
select * from user;

update user set address = '서울특별시 광진구' where name = '우건우';

select * from user where name='우건우';

-- 5. 전화번호 변경
update user set telephone_number = '01048807780' where name = '신현호';

select * from user where name = '신현호';


select category, product_name, product_desc, price
from product
where category = "wallets";



