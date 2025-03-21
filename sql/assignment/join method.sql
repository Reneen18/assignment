use marchdb

--fetch records from skill
select * from skill
--fetch records from trainee
select * from trainee

--inner join query to fetch records from skill and trainee
select * from skill
inner join
trainee
on skill.Id= trainee.skill

--fetch records from skill
select * from skill
--fetch records from trainee
select * from trainee

--right records from skill
select * from skill
--fetch records from skill
select * from skill
