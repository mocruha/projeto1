--count total of registered players
select count(*) as total_players
from users.user_profile

--count total banned players
select count(distinct user_id) as total_banned
from users.banned_users

--average and max played hours
select avg(time_played_hours) as avg_played_hours, max(time_played_hours) as max_played_hours
from users.user_game_data

--average and max player level
select avg(level) as avg_level, max(level) as max_level
from users.user_game_data

--users gender distribution
select count(user_id), gender
from users.user_profile
group by gender
order by count desc

--users age distribution
select count(user_id) age_count,
extract(year from age(current_date, birth_date)) as age
from users.user_profile
group by age
order by age_count desc

--most frequent character classes rank
select count(user_id) classes_count, character_class
from users.user_game_data
group by character_class
order by classes_count desc

--classes and gender prefference
select gm.character_class, gender, count(gm.character_class) player_count
from users.user_game_data gm
join users.user_profile up on gm.user_id = up.user_id
group by gm.character_class, up.gender
order by player_count desc

--most played chatacter class by time played
select character_class, sum(time_played_hours) hours_per_class
from users.user_game_data ugd
group by character_class
order by hours_per_class desc

