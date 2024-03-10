
--Задание №4
--
--Необходимо сформировать таблицу в которой будет отражено сколько поступило денег в 
--каждом месяце и как росла общая выручка с учетом предыдущих месяцев.

select
	concat(DATENAME('month',result.1),' ',DATENAME('year',result.1)) as period,
    result.2 AS revenue_by_month,
    result.3 as revenue_by_month_cummulative
from 
(
    select
        groupArray(date) as times,
        groupArray(value) as values,
        arrayCumSum(groupArray(value)) as cum_values,
        arrayZip(times, values, cum_values) as results,
        arrayJoin(results) as result
    from 
    (
        select toStartOfInterval(p.payment_date, interval 1 month) as date, sum(p.value) as value
        from artsofte.payments p 
        group by date
    	order by date asc
    )
)