#!/usr/bin/env python
# coding: utf-8



# calling module for using mysql with Python
import pymysql

# calling db
hm_db = pymysql.connect(
   user = 'root',  #user name
   passwd = '1234', #password
   host = '127.0.0.1', #host address
   db = 'hmdb', #name of db
   charset = 'utf8' #using utf8 since we use Korean
)




# creating cursor for interacting with connected DB
cursor = hm_db.cursor()

sql_01 = "select P.product_id from product as P where P.price > 35000 and product_id in (select I.product_id from item_cart as I where I.quantity > 2);"
cursor.execute(sql_01)
result_01 = cursor.fetchall()
print(result_01)




cursor = hm_db.cursor()
sql_02 = "select U.name  from user as U where U.gender = 'M' and U.user_id = (select I.user_id from item_cart as I where I.product_id = '372');"
cursor.execute(sql_02)
result_02 = cursor.fetchall()
print(result_02)




cursor = hm_db.cursor()
sql_03 = "select * from product where not exists (select product_id from product where price > 1000000000);"
cursor.execute(sql_03)
result_03 = cursor.fetchall()
print(result_03)




cursor = hm_db.cursor()
sql_04 = "select * from product where exists (select * from discount where discount_percent > 50);"
cursor.execute(sql_04)
result_04 = cursor.fetchall()
print(result_04)




# executing procedure
cursor = hm_db.cursor()
cursor.callproc('sum_of_user')
result_05 = cursor.fetchall()
print(result_05)




# executing function
cursor = hm_db.cursor()
func = "select insert_user(%s,%s,%s,%s,%s)"
result_06 = cursor.execute(func, ('hihi','Lisa','F','서울시 성북구','821048807780'))
result_06 = cursor.fetchall()
sql_07 = cursor.execute("select * from User;")
result_07 = cursor.fetchall()
print(result_07)




# 신상품 추가
cursor = hm_db.cursor()
sql = "insert into product values(%s,%s,%s,%s,%s,%s)"
values = (382,'blue_jacket',49000,'jackets','for men','JK102476')
cursor.execute(sql,values)
hm_db.commit()
cursor.fetchall()

#상품 열람
cursor = hm_db.cursor()
sql = "select * from product;"
cursor.execute(sql)
cursor.fetchall()




# 장바구니 담기
cursor = hm_db.cursor()
sql = "insert into item_cart values(%s, %s, %s,%s)"
values = (255,1,382,1)
cursor.execute(sql,values)
hm_db.commit()
cursor.fetchall()

# 장바구니 열람
cursor = hm_db.cursor()
sql = "select * from item_cart"
cursor.execute(sql)
cursor.fetchall()




# 상품 제거
cursor = hm_db.cursor()
sql = "delete from item_cart where product_id = %s" % (34892)
cursor.execute(sql)
cursor.fetchall

# 장바구니 열람
cursor = hm_db.cursor()
sql = "select * from item_cart"
cursor.execute(sql)
cursor.fetchall()




# 수량 변경
cursor = hm_db.cursor()
sql = "update item_cart set quantity= %s where product_id = %s;" % (3, 382)
cursor.execute(sql)
cursor.fetchall()

# 장바구니 열람
cursor = hm_db.cursor()
sql = "select * from item_cart"
cursor.execute(sql)
cursor.fetchall()




# order_items
cursor = hm_db.cursor()
sql = "insert into order_items values(%s,%s);" % (7676,382)
cursor.execute(sql)
hm_db.commit()
cursor.fetchall()

# order_details 작성
cursor = hm_db.cursor()
sql = "insert into order_details values(%s,%s,%s,%s,%s)" % (8787, 382, 49000*3, 1, 7676)
cursor.execute(sql)
hm_db.commit()
cursor.fetchall()

# order detail 열람
cursor = hm_db.cursor()
sql = "select * from order_details"
cursor.execute(sql)
cursor.fetchall()




# payment_details 작성
cursor = hm_db.cursor()
sql = "Insert into payment_details values(3535,3,'HM','paid','KR00',8787)"
cursor.execute(sql)
hm_db.commit()
cursor.fetchall()

# payment_details 열람
cursor = hm_db.cursor()
sql = "select * from payment_details"
cursor.execute(sql)
hm_db.commit()
cursor.fetchall()


