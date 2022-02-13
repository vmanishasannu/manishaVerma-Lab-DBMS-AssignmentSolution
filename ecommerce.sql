/*
1)	You are required to create tables for supplier,customer,category,product,productDetails,order,rating to store the data for the E-commerce with the schema definition given below.	
	Supplier(SUPP_ID,SUPP_NAME,SUPP_CITY,SUPP_PHONE)
	Customer(CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER)
	Category(CAT_ID,CAT_NAME)
	Product(PRO_ID,PRO_NAME,PRO_DESC,CAT_ID)
	ProductDetails(PROD_ID,PRO_ID,SUPP_ID,PRICE)
	Order(ORD_ID,ORD_AMOUNT,ORD_DATE,CUS_ID,PROD_ID)
	Rating(RAT_ID,CUS_ID,SUPP_ID,RAT_RATSTARS)
*/
create database eCommerce;
use eCommerce;

create table Supplier(
SUPP_ID int primary key,
SUPP_NAME varchar(20),
SUPP_CITY varchar(20),
SUPP_PHONE varchar(20)
);

create table Customer(
CUS_ID int primary key,
CUS_NAME varchar(20),
CUS_PHONE varchar(20),
CUS_CITY varchar(20),
CUS_GENDER varchar(1)
);

create table Category(
CAT_ID int primary key,
CAT_NAME varchar(20)
);

create table Product(
PRO_ID int primary key,
PRO_NAME varchar(20),
PRO_DESC varchar(30),
CAT_ID int,
FOREIGN KEY (CAT_ID) REFERENCES Category(CAT_ID)
);

create table ProductDetails(
PROD_ID int primary key,
PRO_ID int,
SUPP_ID int,
PRICE int,
FOREIGN KEY (SUPP_ID) REFERENCES Supplier(SUPP_ID),
FOREIGN KEY (PRO_ID) REFERENCES Product(PRO_ID)
);


CREATE TABLE `order`(
ORD_ID int primary key,
ORD_AMOUNT int,
ORD_DATE DATE,
CUS_ID int,
PROD_ID int,
FOREIGN KEY (CUS_ID) REFERENCES Customer(CUS_ID),
FOREIGN KEY (PROD_ID) REFERENCES ProductDetails(PROD_ID)
);

create table Rating(
RAT_ID int primary key,
CUS_ID int,
SUPP_ID int,
RAT_RATSTARS int,
FOREIGN KEY (SUPP_ID) REFERENCES Supplier(SUPP_ID),
FOREIGN KEY (CUS_ID) REFERENCES Customer(CUS_ID)
);

/* 2)	Insert the following data in the table created above */

insert into Supplier values (1,'Rajesh Retails','Delhi','1234567890');
insert into Supplier values (2,'Appario Ltd.', 'Mumbai','2589631470');
insert into Supplier values (3,'Knome products','Banglore','9785462315');
insert into Supplier values (4,'Bansal Retails','Kochi','8975463285');
insert into Supplier values (5,'Mittal Ltd.','Lucknow','7898456532');

insert into Customer (CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values (1	,'AAKASH','9999999999','DELHI','M');
insert into Customer (CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values (2	,'AMAN'	,'9785463215','NOIDA','M');
insert into Customer (CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values (3	,'NEHA','9999999999','MUMBAI','F');
insert into Customer (CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values (4	,'MEGHA','9994562399','KOLKATA'	,'F');
insert into Customer (CUS_ID,CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) values (5	,'PULKIT','7895999999','LUCKNOW','M');


insert into Category values (1,'BOOKS');
insert into Category values (2,'GAMES');
insert into Category values (3,'GROCERIES');
insert into Category values (4,'ELECTRONICS');
insert into Category values (5,'CLOTHES');

insert into Product values (1,'GTA V','DFJDJFDJFDJFDJFJF',2);
insert into Product values (2,'TSHIRT','DFDFJDFJDKFD',5);
insert into Product values (3,'ROG LAPTOP','DFNTTNTNTERND',4);
insert into Product values (4,'OATS','REURENTBTOTH',3);
insert into Product values (5,'HARRY POTTER','NBEMCTHTJTH',1);

insert into ProductDetails values (1	,	1	,		2,	1500);
insert into ProductDetails values (2	,	3	,		5,	30000);
insert into ProductDetails values (3	,	5	,		1,	3000);
insert into ProductDetails values (4	,	2	,		3,	2500);
insert into ProductDetails values (5	,	4	,		1,	1000);

insert into ecommerce.order values (20	,	1500	,	'2021-10-12',	3,	5);
insert into ecommerce.order values (25	,	30500	,	'2021-09-16'	,5,	2);
insert into ecommerce.order values (26	,	2000	,	'2021-10-05',	1,	1);
insert into ecommerce.order values (30	,	3500	,	'2021-08-16',	4	,3);
insert into ecommerce.order values (50	,	2000	,	'2021-10-06'	,2,	1);

insert into  Rating values(1,				2,		2,		4);
insert into  Rating values(2,				3,		4,		3);
insert into  Rating values(3,				5,		1,		5);
insert into  Rating values(4,				1,		3,		2);
insert into  Rating values(5,				4,		5	,	4);




/*3)	Display the number of the customer group by their genders who have placed any order of amount greater than or equal to Rs.3000.*/
		select count(c.cus_name),c.cus_gender from customer c ,ecommerce.order o
		where c.CUS_ID=o.cus_id and o.ord_amount>=3000 group by cus_gender;

/*4)	Display all the order along with the product name ordered by a customer having Customer_Id=2.*/
		select o.ORD_ID,o.ORD_AMOUNT,o.ORD_DATE,p.PRO_NAME,c.CUS_NAME from ecommerce.order o,Product p,customer c
		where o.PROD_ID=p.PRO_ID and c.CUS_ID=o.cus_id and c.CUS_ID=2;

/*5)	Display the Supplier details who can supply more than one product.*/
		select s.SUPP_ID,s.SUPP_NAME,s.SUPP_CITY,s.SUPP_PHONE from supplier s, ProductDetails p where s.SUPP_ID=p.SUPP_ID group by p.SUPP_ID having count(p.SUPP_ID)>1;
		
/*6)	Find the category of the product whose order amount is minimum.*/

		select c.CAT_ID,c.CAT_NAME from category c,product p,productdetails pd 
		where c.CAT_ID=p.CAT_ID and p.PRO_ID=pd.PRO_ID and pd.price=(select MIN(pd.price) from productdetails pd);
		
/*7)	Display the Id and Name of the Product ordered after “2021-10-05”.*/

		select p.PRO_ID,p.PRO_NAME from Product p,ProductDetails pd,ecommerce.order o where
		p.pro_id=pd.pro_id and pd.PROD_ID=o.PROD_ID and ORD_DATE>"2021-10-05";
		
/*8)	Display customer name and gender whose names start or end with character 'A'.*/
		select CUS_NAME,cus_gender from customer where cus_name like 'A%' or cus_name like '%A';
		
/*9)	Create a stored procedure to display the Rating for a Supplier if any along with the Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2
 “Average Supplier” else “Supplier should not be considered”.*/


	drop PROCEDURE if exists supplierRatingProc;
	delimiter $$
	create PROCEDURE supplierRatingProc(SUPP_ID int)
	BEGIN
		SELECT s.SUPP_NAME,r.RAT_RATSTARS,
			CASE 
				 WHEN  r.RAT_RATSTARS > '4' THEN 'Genuine Supplier'
				 WHEN r.RAT_RATSTARS >'2' THEN 'Average Supplier'
				 ELSE 'Supplier should not be considered'
			 END AS Verdit
		FROM Supplier s,Rating r
	 where s.SUPP_ID=r.SUPP_ID and r.SUPP_ID=SUPP_ID;
	end;

	CALL supplierRatingProc(3);
	CALL supplierRatingProc(1);