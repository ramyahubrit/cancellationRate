create table trips
(
id int,
client_id int,
driver_id int,
city_id int,
status enum('completed','cancelled_by_driver','cancelled_by_client'),
request_at date,
primary key(id),
foreign key(client_id) references user_s(users_id),
foreign key(driver_id) references user_s(users_id),
unique(id)
);



INSERT INTO trips values(1,1,10,1,'completed', '2013-10-01'),
(2,2,11,1,'cancelled_by_driver','2013-10-01'),
(3,3,12,6,'completed','2013-10-01'),
(4,4,13,6,'cancelled_by_client','2013-10-01'),
(5,1,10,1,'completed','2013-10-02'),
(6,2,11,6,'completed','2013-10-02'),
(7,3,12,6,'completed','2013-10-02'),
(8,2,12,12,'completed','2013-10-03'),
(9,3,10,12,'completed','2013-10-03'),
(10,4,13,12,'cancelled_by_driver','2013-10-03');

select * from trips;

Drop table user_s;
create table user_s
(
	users_id int,
    banned enum('Yes','No'),
    role enum('client','driver','partner'),
    primary key (users_id)
);

insert into user_s values
(1,'No','client'),
(2,'Yes','client'),(3,'No','client'),
(4,'No','client'),(10,'No','driver'),
(11,'No','driver'),(12,'No','driver'),
(13,'No','driver');

select b.request_at as day,
case
  when a.status/b.status != 'Null' then round(a.status/b.status,2)
  else 0
  end as cancellation_rate
  from
  (
  select request_at,count(status) as status
  from trips
  where (status = 'cancelled_by_driver' or status = 'cancelled_by_client') and client_id!=2
  group by request_at
  ) a
right join
  (
  select request_at,count(status) as status
  from trips
  where  client_id!=2
  group by request_at
  ) b
  on a.request_at=b.request_at;
  
  
