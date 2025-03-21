insert into skill (id, skill_name) values
(5, 'python')

select skill.skill_name, count(train.trainee_id) as trainee_count
from skill
left join train
on skill.id = train.skill_id
group by skill.skill_name;