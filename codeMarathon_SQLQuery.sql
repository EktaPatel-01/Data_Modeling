create database codemarathon;
use codemarathon;



create table Doctor(
   doctor_id varchar(6) primary key,
   dr_first_name varchar(15),
   dr_middle_name varchar(15),
   dr_last_name varchar(15)
);

create table Patient(
   patient_id varchar(6) Primary key,
   p_first_name varchar(15),
   p_middle_name varchar(15),
   p_last_name varchar(15),
   address varchar(30),
   city varchar(15),
   contact_number varchar(10),
   p_age int
  
);

create table Appointment(
   app_number varchar(6) primary key,
   app_date date,
   app_time varchar(8),
   app_reason varchar(30),
   doctor_id varchar(6) references Doctor(doctor_id),
   patient_id varchar(6) references Patient(patient_id)
);

create table Bill(
   bill_number varchar(6) primary key,
   bill_date date,
   bill_status varchar(8),
   bill_amount decimal(7,2),
   app_number varchar(6) references Appointment(app_number)
);


create table Payment(
   payment_id varchar(6) Primary key,
   pay_date date,
   pay_mode varchar(10),
   pay_amount decimal(7,2),
   bill_number varchar(6) references Bill(bill_number)
);


insert into Patient values('P001','Sweta','singh','Thakur','DeenDayalNagar','sagar','2345678654',23);
insert into Patient values('P002','Salani','shah','Verma','Fords_Street','Mumbai','2386578654',21);
insert into Patient values('P003','Ravi','singh','Sharma','Lal Bhag','Indore','2345632454',28);
insert into Patient values('P004','Rajesh',Null,'Thakur','Gandhi chauk','Bhopal','2348978654',32);
insert into Patient values('P005','Riya','Kumar','Shah','Hinjwadi','Pune','2345673454',30);
insert into Patient values('P006','Ruchi','Kirar','Trivadi','Shivaji chauk','Pune','2342378654',55);
insert into Patient values('P007','Avani','singh','Patel','DeenDayalNagar','Banglore','2367678654',45);
insert into Patient values('P008','Sweta','Kumar','Thakur','Shivaji chauk','Hyderabad','2345672354',40);
select * from Patient;

create table Doctor(
   doctor_id varchar(6) primary key,
   dr_first_name varchar(15),
   dr_middle_name varchar(15),
   dr_last_name varchar(15)
);

insert into Doctor values ('D11','Stanes',null,'William');
insert into Doctor values ('D12','Steives','jhon','William');
insert into Doctor values ('D13','Jennifer',null,'jhon');
insert into Doctor values ('D14','Raam','singh','Verma');
insert into Doctor values ('D15','Kishor','kumar','Sharma');

select * from Doctor;

create table Appointment(
   app_number varchar(6) primary key,
   app_date date,
   app_time varchar(8),
   app_reason varchar(30),
   doctor_id varchar(6) references Doctor(doctor_id),
   patient_id varchar(6) references Patient(patient_id)
);

insert into Appointment values('A01','2023-06-12','22:12:45','Fever','D13','P005');
insert into Appointment values('A05','2023-06-26','23:22:26','Maleria','D12','P006');
insert into Appointment values('A02','2023-08-12','22:06:46','Flu','D11','P003');
insert into Appointment values('A03','2023-10-25','21:23:23','Cold','D13','P005');
insert into Appointment values('A04','2023-11-16','20:30:17','Fever','D14','P002');

create table Bill(
   bill_number varchar(6) primary key,
   bill_date date,
   bill_status varchar(8),
   bill_amount decimal(7,2),
   app_number varchar(6) references Appointment(app_number)
);

insert into Bill values('B01','2023-10-22','Pending',4600,'A04');
insert into Bill values('B02','2023-11-23','Filled',2300,'A05');
insert into Bill values('B03','2023-09-12','Filled',1380,'A05');
insert into Bill values('B04','2023-10-22','Pending',7300,'A03');
insert into Bill values('B05','2023-10-12','Pending',5600,'A02');

create table Payment(
   payment_id varchar(6) Primary key,
   pay_date date,
   pay_mode varchar(10),
   pay_amount decimal(7,2),
   bill_number varchar(6) references Bill(bill_number)
);

insert into Payment values('Py55','2023-11-23','Cash',3480,'B04');
insert into Payment values('Py66','2023-10-24','Online',4780,'B05');
insert into Payment values('Py77','2023-11-23','Check',4580,'B04');
insert into Payment values('Py88','2023-10-13','Cash',6590,'B03');
insert into Payment values('Py99','2023-11-23','Check',4580,'B02');

select * from Payment;
select * from Bill;
select * from Doctor;
select * from Patient;
select * from Appointment;


------------------------------------------------------------------------

--2 Question


--2A
select count(a.app_number) as 'Count_of_Appointments' ,d.dr_first_name +' '+d.dr_last_name as 'Doctor Name'
from  Patient p join Appointment a on p.patient_id=a.patient_id join Doctor d on d.doctor_id=a.doctor_id 
group by dr_first_name ,dr_last_name;


--2B
select avg(p.p_age) as 'Average age' from Patient p join Appointment a on p.patient_id =a.patient_id
where datepart(month,app_date)=06 and datepart(year,app_date)=2023;

--2C
select sum(b.bill_amount) as' Total_bill',p.p_first_name+' '+p.p_middle_name+' '+p.p_last_name  as 'Patient Full Name' 
from  Patient p join Appointment a on p.patient_id=a.patient_id
join Bill b on a.app_number=b.app_number group by p_first_name,p_middle_name,p_last_name;

--2D
select p.p_first_name,p.city,a.app_date,py.pay_mode,py.pay_date from Patient p join Appointment a on p.patient_id=a.patient_id 
join Bill b on a.app_number=b.app_number
join Payment py on b.bill_number=py.bill_number where py.pay_mode='Cash' ;

---2E
 select d.dr_first_name+' '+d.dr_last_name as 'Doctor Full Name', 
 count(a.app_number) as 'Number_of_appointments' from Doctor d join Appointment a on d.doctor_id=a.doctor_id
 group by dr_first_name,dr_last_name
 order by Number_of_appointments desc;

 ----------------------------------------------

select * from Payment;
select * from Bill;
select * from Doctor;
select * from Patient;
select * from Appointment;
 select count(app_number) from Appointment where app_date=''

 ------------------------------------------------------
 --3Questions

 ---3A
 go
 create function total_appointment(@date date)
 returns int
 begin
 declare @count int
  select @count=count(app_number) from Appointment where app_date=@date;
  return @count;
  end;
  go
  select dbo.total_appointment('2023-06-12');

  --3B

  --select count(a.app_number)as 'CountOfAppointment',a.app_date,a.app_reason,p.p_first_name from Doctor d join Appointment a on d.doctor_id=a.doctor_id join Patient p
  --on a.patient_id=p.patient_id group by app_date,app_reason,p.p_first_name;

  go 
  create function tot_App1(@doctorId varchar(6))
  returns @Tot_app_Table table(CountOfAppointment int ,app_date date,app_reason varchar(30),p_first_name varchar(10))
  begin
  insert into @Tot_app_Table select count(a.app_number)as 'CountOfAppointment',
  a.app_date,a.app_reason,p.p_first_name from Doctor d join Appointment a on d.doctor_id=a.doctor_id 
  join Patient p on a.patient_id=p.patient_id where d.doctor_id=@doctorId group by app_date,app_reason,p.p_first_name ;
  return
  end;
  go
  select * from dbo.tot_App1('D12');

  ------------------------------------------------------------------
  --3C

 -- select  top 1 d.dr_first_name,a.app_date from doctor d join Appointment a 
 -- on d.doctor_id=a.doctor_id order by a.app_date desc;

  go 
  create function App_date(@doctorId varchar(6))
  returns @AppInfo table(drFirstname varchar(10),App_date date)
  begin
  insert into @AppInfo select  top 1 d.dr_first_name,a.app_date from doctor d join Appointment a 
  on d.doctor_id=a.doctor_id order by a.app_date desc;

  return
  end;
  go
  select * from dbo.App_date('D12');


  ----------------------------------------------------------

 --3D

 go 
 create function Count_Appointment(@drFirstName varchar (10))
 returns int
 begin
 declare @count int
  select @count=count(app_number) from Appointment a join Doctor d on a.doctor_id=d.doctor_id
  where dr_first_name=@drFirstName;
  return @count;
  end;
  go
  select dbo.Count_Appointment('Jennifer');
  ---------------------------------------------------------------------------
  --3E

  --select p.p_first_name,d.dr_first_name,a.app_date from  Doctor d join Appointment a on d.doctor_id=a.doctor_id join patient p on a.patient_id=p.patient_id 
  --where a.app_reason='fever'

 go 
  create function Patient_detail(@AppReason varchar(6))
  returns @AppRea table(Patient_Firstname varchar(10),dr_firstname varchar(10),App_date date)
  begin
  insert into @AppRea select p.p_first_name,d.dr_first_name,a.app_date from  Doctor d join Appointment a on d.doctor_id=a.doctor_id join patient p on a.patient_id=p.patient_id 
  where a.app_reason=@AppReason
  return
  end;
  go
  select * from dbo.Patient_detail('Fever');

 -------------------------------------------------------------
 select * from Payment;
select * from Bill;
select * from Doctor;
select * from Patient;
select * from Appointment;


 --4A
 go
 create procedure update_phoneNo3(@patient_id varchar(6),@new_phone varchar(10))
 as

 if(@patient_id in (select patient_id from patient ))
 update Patient set contact_number=@new_phone where patient_id=@patient_id;
 else print 'ID NOT Found'
 --end;
 go
 exec update_phoneNo3 'P010','4569873370'
 select * from Patient;
 ----------------------------------------

 --4B
 go
 create procedure display_info1
 as
 select p.patient_id,p.p_first_name,p.address,a.app_number,b.bill_amount
 from patient p join Appointment a on p.patient_id=a.patient_id join bill b on a.app_number=b.app_number
 where b.bill_status='pending' order by a.app_number desc;
 go
 exec display_info1
 -----------------------------------------
 --4C
 select * from Appointment;
 select * from Doctor;

 go
 create procedure display_doctor_inf
 as
 select doctor_id,dr_first_name+' '+dr_last_name as 'Doctor Full name' from Doctor where doctor_id not in
 (select doctor_id from Appointment) order by doctor_id desc;
 go
 exec display_doctor_inf
 ----------------------------------------------
 --4D
 go
 create procedure patient_app(@city varchar(10))
 as
 select a.app_number,p.p_first_name+' '+p.p_last_name as 'Patient Full Name' ,a.app_date,
 d.dr_first_name+' '+d.dr_last_name from  Patient p join Appointment a on p.patient_id=a.patient_id 
 join Doctor d on a.doctor_id=d.doctor_id where p.city=@city;
 go
 exec patient_app 'pune'
  --------------------------------------------
  --4E
  --select * from Bill

  go 
  create procedure total_bill_amount1(@patient_id varchar(6))
  as
  select sum(b.bill_amount) as 'Total Bill',p.p_first_name from Bill b join Appointment a on b.app_number=a.app_number
  join Patient p on a.patient_id=p.patient_id where p.patient_id=@patient_id group by p_first_name;
  go
  exec dbo.total_bill_amount1 'P002'
  ---------------------------------------------
select * from Payment;
select * from Bill;
select * from Doctor;
select * from Patient;
select * from Appointment;

  --5Question
  --5A
  create view View1 as
  select p.p_first_name,p.p_last_name ,p.p_age,d.dr_first_name,a.app_date,a.app_time
  from Doctor d,Patient p,Appointment a where d.doctor_id=a.doctor_id and a.patient_id=p.patient_id;
  select * from View1;

  --5B
  create view View2 as
  select p.p_first_name,p.address,p.p_age,b.bill_amount,b.bill_date,
  b.bill_status,py.pay_amount,py.pay_mode,py.pay_date
  from patient p ,Bill b,Payment py;
  select * from View2;

  --5C
  create view View3 as
  select d.doctor_id,d.dr_first_name,d.dr_last_name,a.app_date,a.app_reason,a.app_time
  from Doctor d,Appointment a ;
   select * from View3;

   --5D
   create view View4a as
   --select d.dr_first_name,p.p_first_name,a.app_date,a.app_time,a.app_reason
   --from Doctor d,Patient p,Appointment a 
   --where d.doctor_id=a.doctor_id and p.patient_id=a.patient_id;

   select d.dr_first_name,p.p_first_name,a.app_date,a.app_time,a.app_reason
   from Doctor d join Appointment a on d.doctor_id=a.doctor_id join Patient p on  a.patient_id=p.patient_id;

   select * from View4a;

   --5E
   create view View5 as
   select p.p_first_name,p.city,p.contact_number,py.pay_amount,b.bill_amount from Patient p join Appointment a on p.patient_id=a.patient_id
   join Bill b on a.app_number=b.app_number join Payment py on b.bill_number=py.bill_number;
   select * from View5;
