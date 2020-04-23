create table stars_category (
    name varchar(255),
    sports_category varchar(255),
    PRIMARY KEY (name)
);

create table instagram_users (
    user_id int NOT NULL AUTO_INCREMENT,
    user_name varchar(255),
    registration_date date,
    PRIMARY KEY (user_id)
);

create table followee_follower (
    user_id int,
    user_id_following int,
    follow_date date
);

insert into stars_category(name, sports_category)
values
('Mike', 'NBA'),
('Ben', 'CBA'),
('Jack', 'NFL'),
('Rose', 'NFL'),
('Long', 'NBA');

insert into instagram_users(user_id, user_name, registration_date)
values
(1, 'Mike', '2016-06-01'),
(2, 'Ben', '2016-06-01'),
(3, 'Jack', '2016-06-01'),
(4, 'Rose', '2016-06-01'),
(5, 'Long', '2016-06-01'),
(6, 'Li', '2016-06-01'),
(7, 'Short', '2016-06-01'),
(8, 'Cat', '2016-06-01');

insert into followee_follower(user_id, user_id_following, follow_date)
values
(3, 1, '2016-06-01'),
(4, 5, '2016-06-01'),
(1, 6,'2016-06-01'),
(3, 6, '2016-06-01'),
(4, 6, '2016-06-01'),
(5, 6, '2016-06-01'),
(7, 6, '2016-06-01');


select sc.sports_category as sports_category, count(distinct ff.user_id_following) as follower_counts
from stars_category sc join instagram_users iu
on sc.name = iu.user_name
left join followee_follower ff
on iu.user_id = ff.user_id
group by sports_category



select count(distinct iu2.user_name) as nba_follow_nfl_counts
from stars_category sc1 join instagram_users iu1
on sc1.name = iu1.user_name and sc1.sports_category = 'NFL'
join followee_follower ff
on iu1.user_id = ff.user_id
join instagram_users iu2
on ff.user_id_following = iu2.user_id
join stars_category sc2
on iu2.user_name = sc2.name and sc2.sports_category = 'NBA'

