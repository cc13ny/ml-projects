create table message (
    sender_id int,
    receiver_id int,
    date date
);

insert into message(sender_id, receiver_id, date)
values
(3, 1, '2016-06-01'),
(4, 5, '2016-06-01'),
(1, 6, '2017-06-01'),
(6, 1, '2017-06-01'),
(1, 2, '2017-06-01'),
(3, 4, '2017-06-01'),
(5, 6, '2017-06-01');


select num_of_daily_contact, count(user_id1) as num_of_user from
(select user_id1, count(user_id2) as num_of_daily_contact from
(select sender_id as user_id1, receiver_id as user_id2 from message where date = '2017-06-01'
union
select receiver_id as user_id1, sender_id as user_id2 from message where date = '2017-06-01'
) as daily_contact
group by user_id1) as daily_contact_count
group by num_of_daily_contact