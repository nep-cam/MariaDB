USE classicmodels
-- 2.liệt kê offices có country là USA
SELECT * FROM offices
WHERE
    country = "USA";
-- 3.liệt kê tất cả employess, thêm cột alias fullName, bằng firstname + lastname
select e.* ,concat(firstname, ' ', lastname) as fullname
from employees e;
-- 4.liệt kê tất cả employess, thêm cột alias offices.city, office.state
select e.*,
	o.city,
	o.state
from employees e 
left join offices o using (officeCode);
-- 5.liệt kê offices ko chứa employee nào
select o.officeCode
from offices o 
left join employees e using (officeCode)
where e.employeeNumber is null;
-- 6.đến số lương employees 
select count(*)
from employees e ;
-- 7.liệt kê customers có nhiều nhất 3 payments
select c.customerNumber,
	c.customerName 
from customers c 
inner join payments p 
	using (customerNumber)
group by 
	(p.customerNumber)
having 
	count(customerNumber) <=3;
-- 8.liệt kê 10 customer có payments sớm nhất
select c.customerNumber,
	c.customerName,
	p.paymentDate 
from customers c 
inner join payments p 
	using (customerNumber)
order by p.paymentDate 
limit 10;
-- 9.liệt kê các customers có salesRepEmployeeNumber tồn tại
select c.customerNumber,
	c.customerName,
	e.employeeNumber  
from customers c 
inner join employees e 
	on c.salesRepEmployeeNumber = e.employeeNumber 
order by c.customerNumber ;
-- 10.liệt kê 10 customer có nhiều payment nhất, sắp xếp giảm dần số lượng payment
select c.customerNumber,
	c.customerName,
	count(p.customerNumber) as count_payment
from customers c 
inner join payments p 
	using (customerNumber)
group by (p.customerNumber)
order by count(p.customerNumber) desc  
limit 10;
-- 11.tìm tất cả orders trong tháng 11/2003
select*from orders
where 
	orderDate between '2003-11-01'
	and '2003-11-30'
order by orderNumber ;
-- 12.thêm 2 employee
-- 13.thêm 2 office
-- 14.sửa addressLine2 = '31 street Red'  co officeCOde =1
update offices  
set 
	addressLine2 ='31 Street Red'
where officeCode = 1;
-- 15.update tất cả customer có addressLine là Null bằng addressLine1
update customers c
set c.addressLine2 = c.addressLine1 
where addressLine2 is null;

-- 16.update tất cả customer có state là Null bằng 3 kí tự dầu của city, viết hoa chữ cái đầu
update customers c 
set c.state  = concat(upper(substring(c.city,1,1)), substring(c.city,2,2))
where c.state is null;
-- 17.liệt kê 10 customer có nhiều orders nhất
select c.*
from customers c 
inner join orders o  
	using (customerNumber)
group by o.customerNumber
order by count(o.comments) desc 
limit 10;
-- 18.liệt kê tất cả orderdetails của từng orders
select o.*
from orderdetails o 
left join orders o2 
	using (orderNumber);
-- 19.liệt kê tất cả orderdetails, order có productCode bắt đầu là S10
select o.*, o2.*
from orders o 
inner join orderdetails o2 using (orderNumber)
inner join products p using (productCode)
where p.productCode like 'S10%';
-- 20.liệt kê 11 product có ít orderdetails nhâṭ
select p.* 
from products p 
left join orderdetails o using (productCode)
group by productCode 
order by count(productCode) 
limit 11;
-- 21.liệt kê thông tin productlines, products, orderdetails của từng order
select o.*
from orders o 
left join orderdetails o2 using (orderNumber)
left join products p  using (productCode)
left join productlines p2 using (productLine);
-- 22.thêm 3 products

-- 23.xóa customers không có bất kì orders nào
delete c.* from customers c
left  join orders o using (customerNumber)
where o.orderNumber  is null;

-- 24.liệt kê orders, orderdetails theo từng customers
select o.*, o2.*, c.*
from customers c  
inner join orders o using (customerNumber)
inner join orderdetails o2 using (orderNumber);
-- 25.liệt kê customers tại USA có số lượng payment nhiều nhất
select c.*
from customers c 
inner join payments p using (customerNumber)
where c.country like 'USA'
group by customerNumber 
order by count(customerNumber) desc 
limit 1;

-- 26.liệt kê 3 customers có lượng amout it́ nhất
select c.*
from customers c 
inner join payments p using(customerNumber)
group by customerNumber 
order by sum(p.amount)
limit 3;
-- 27.liệt kê 5 products có số lượng payment nhiều nhất
select p.*
from products p 
inner join orderdetails o using (productCode)
inner join orders o2 using (orderNumber)
inner join payments p2 using (customerNumber)
group by (p.productCode)
order by sum(p2.amount)
limit 5;
-- 28.liệt kê orders được thanh toán trong tháng 4-2003 & tháng 12-2003
select o.*
from orders o 
where shippedDate between '2003-04-01' and '2003-04-30'
	or shippedDate between '2003-12-01' and '2003-12-31';