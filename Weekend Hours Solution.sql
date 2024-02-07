-- Weekend Hours Solution

with Hours_worked as (
SELECT * , DATEPART(hour, timestamp)- DATEPART(hour, #LAG)  as hours
from (
	SELECT * , LAG(timestamp) OVER(ORDER BY emp_id) #LAG,  ROW_NUMBER() OVER(ORDER BY emp_id ASC) AS Row#
	from attendance
	where DATEPART(weekday, timestamp) in (1,7)) sub
where Row# % 2 =0 
)

select emp_id, sum(hours) Sum_hours_worked
from Hours_worked
group by emp_id
order by Sum_hours_worked desc