USE toys_and_models;

 ------- Ventes
 
 SELECT concat(Year,' ',CASE WHEN  Month <10 THEN CONCAT(0,Month)
							ELSE Month END ) AS Date,productline, Total 
 FROM (
		SELECT YEAR(orderDate) AS Year,MONTH(orderDate) AS Month,productLine, SUM(quantityOrdered) AS Total
		FROM products
		JOIN orderdetails
		ON products.productCode = orderdetails.productCode 
		JOIN orders
		ON orderdetails.orderNumber = orders.orderNumber 
		GROUP BY productLine,Year,Month
		ORDER BY Year, Month
        ) AS Try
;

 
 
 SELECT productLine, 
  ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=1 then quantityOrdered END) - SUM(CASE when year(orderDate)=2022 and month(orderDate)=1 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=1 then quantityOrdered END)) as JAN_22_23,
   ((SUM(CASE when year(orderDate)=2023 and month(orderDate)=2 then quantityOrdered END) - SUM(CASE when year(orderDate)=2022 and month(orderDate)=2 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=2 then quantityOrdered END)) as FEV_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=3 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=3 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=3 then quantityOrdered END)) as MAR_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=4 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=4 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=4 then quantityOrdered END)) as AVR_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=5 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=5 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=5 then quantityOrdered END)) as MAI_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=6 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=6 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=6 then quantityOrdered END)) as JUIN_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=7 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=7 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=7 then quantityOrdered END)) as JUIL_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=8 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=8 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=8 then quantityOrdered END)) as AOU_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=9 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=9 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=9 then quantityOrdered END)) as SEPT_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=10 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=10 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=10 then quantityOrdered END)) as OCT_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=11 then quantityOrdered END)- SUM(CASE when year(orderDate)=2022 and month(orderDate)=11 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=11 then quantityOrdered END)) as NOV_22_23,
   ( (SUM(CASE when year(orderDate)=2023 and month(orderDate)=12 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2022 and month(orderDate)=12 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2022 and month(orderDate)=12 then quantityOrdered END)) as DEC_22_23,
   ( (SUM(CASE when year(orderDate)=2024 and month(orderDate)=1 then quantityOrdered END)  - SUM(CASE when year(orderDate)=2023 and month(orderDate)=1 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2023 and month(orderDate)=1 then quantityOrdered END)) as JAN_23_24,
  ( (SUM(CASE when year(orderDate)=2024 and month(orderDate)=2 then quantityOrdered END) 
 - SUM(CASE when year(orderDate)=2023 and month(orderDate)=2 then quantityOrdered END) )
 / SUM(CASE when year(orderDate)=2023 and month(orderDate)=2 then quantityOrdered END)) as FEV_23_24
 FROM products
 JOIN orderdetails
 ON products.productCode = orderdetails.productCode 
 JOIN orders
 ON orderdetails.orderNumber = orders.orderNumber 
 GROUP BY productLine 
 ;
 
 
 -------------Logistique
 
 
 SELECT  p.productName, SUM(od.quantityOrdered) AS totalOrdered, p.quantityInStock,
 SUM(CASE WHEN YEAR(orderDate)=2022 THEN quantityOrdered*priceEach END) AS CA_2022,
 SUM(CASE WHEN YEAR(orderDate)=2023 THEN quantityOrdered*priceEach END) AS CA_2023,
 SUM(CASE WHEN YEAR(orderDate)=2024 THEN quantityOrdered*priceEach END) AS CA_2024
 FROM products p 
 JOIN orderdetails od 
 ON p.productCode = od.productCode 
 JOIN orders o
 ON od.orderNumber=o.orderNumber
 GROUP BY  p.productName, p.quantityInStock 
 ORDER BY totalOrdered 
 DESC LIMIT 5;
 


 --------------Finances
-------1 
 
SELECT country, 
SUM(CASE WHEN YEAR(orderDate)=2024 AND MONTH(orderDate)=1 THEN quantityOrdered*priceEach END) AS Janvier_2024, 
SUM(CASE WHEN YEAR(orderDate)=2024 AND MONTH(orderDate)=2 THEN quantityOrdered*priceEach END) AS Fevrier_2024
FROM orderdetails 
JOIN orders o
ON orderdetails.orderNumber=o.orderNumber
JOIN customers c
ON c.customerNumber=o.customerNumber
GROUP BY country
;






select productName,country,sum(o.quantityOrdered) as nombre_produit,sum(o.quantityOrdered*priceEach) as Chiffre_A_P,Month(orderDate) as Mois,  YEAR(orderDate) as Année  
from orderdetails o
join  products on o.productCode=products.productCode
join orders on o.orderNumber=orders.orderNumber
join customers on orders.customerNumber=customers.customerNumber
WHERE orderDate BETWEEN '2024-01-01' AND '2024-02-20'  
GROUP BY productName,Month(orderDate),  YEAR(orderDate),country,priceEach   
ORDER BY sum(o.quantityOrdered*priceEach) desc
 ;




 -----------2
 
 

 SELECT o.orderNumber
 FROM  orderdetails o
 LEFT JOIN orders
 ON o.orderNumber=orders.orderNumber
 LEFT JOIN customers c
 ON orders.customerNumber=c.customerNumber
 LEFT JOIN payments p
 ON c.customerNumber=p.customerNumber
 WHERE paymentDate IS NULL
 ;
 
 SELECT o.orderNumber,productName,status,comments,amount,paymentDate
 FROM  products
 LEFT JOIN orderdetails o
 ON products.productCode=o.productCode
 LEFT JOIN orders
 ON o.orderNumber=orders.orderNumber
 LEFT JOIN customers c
 ON orders.customerNumber=c.customerNumber
 LEFT JOIN payments p
 ON c.customerNumber=p.customerNumber
 WHERE status='On Hold'
 ;
 

 
 
 
 
------Ressources humaines


SELECT Date,Name_employee,CA,Ranking FROM (
									SELECT Date, 
                                    Name_employee,
									RANK()OVER(PARTITION BY Date ORDER BY CA DESC) AS Ranking,CA
                                    FROM(
											SELECT CONCAT(YEAR(orderDate),' ',CASE WHEN MONTH(orderDate) <10 THEN CONCAT(0,MONTH(orderDate))
																		ELSE MONTH(orderDate) END 
														) AS Date,
													CONCAT(lastName,' ',firstname) AS Name_employee,
                                                    SUM(quantityOrdered*priceEach) AS CA
											FROM employees e
											JOIN customers c
											ON e.employeeNumber=c.salesRepEmployeeNumber
											JOIN orders o
											ON c.customerNumber=o.customerNumber
                                            JOIN orderdetails
                                            ON orderdetails.orderNumber=o.orderNumber
                                            GROUP BY Date,Name_employee
                                            ORDER BY Date,CA DESC
                                            ) AS x
									)AS y
WHERE Ranking <3
;




SELECT Year, Month,Name_employee, CA 
FROM (
		SELECT YEAR(orderDate) AS Year,
        MONTH(orderDate) AS Month,
        CONCAT(lastName,' ',firstname) AS Name_employee,
        RANK()OVER(PARTITION BY YEAR(orderDate),MONTH(orderDate) ORDER BY SUM(quantityOrdered*priceEach) DESC) AS Ranking,
        SUM(quantityOrdered*priceEach) AS CA
        FROM employees e
        JOIN customers c
        ON e.employeeNumber=c.salesRepEmployeeNumber
        JOIN orders o
        ON c.customerNumber=o.customerNumber
        JOIN orderdetails
        ON orderdetails.orderNumber=o.orderNumber
        GROUP BY Year,Month, Name_employee
        ORDER BY Year,Month,CA DESC
        ) as x
WHERE Ranking <3;














