insert into shape values('circle'),('square'),('rectangle'),('triangle')
insert into colors values('red'),('green'),('blue')

select * from shape
select * from colors

select s.name, c.color from shape as s
cross join
colors as c