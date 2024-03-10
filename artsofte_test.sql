-- Задание 1
-- На основе таблицы с поступлениями, необходимо найти платежи с максимальными суммами всех клиентов которые заплатили в январе 2023 года. Результат должен быть представлен в виде таблицы со следующими полями:
---	Название клиента
---	Дата когда пришел максимальный платеж
---	Сумма максимального поступления

with max_value_cl as
    (
        select client_name , max(value) as value  
		from artsofte.payments p 
		where p.payment_date BETWEEN '2023-01-01' and '2023-01-31'
		group by client_name 
    ) 
select p2.client_name , p2.payment_date , p2.value
from artsofte.payments p2 
inner join max_value_cl mvc on mvc.client_name = p2.client_name and mvc.value = p2.value 
where p2.payment_date BETWEEN '2023-01-01' and '2023-01-31'


-- Задание 2
--Необходимо определить сколько принес денег каждый отдел. Таблица с поступлениями хранит информацию с имением и email адресе менеджера. 
--Информация об отделе хранится в отдельной таблице-справочнике manager_departments. 
--Связь этих двух таблиц осуществляется по полю email, но формат почты отличается. В каких-то случаях email менеджера представлен в 
--формате n.ssssssss@domain.ru, где n это первая буква имени, ssssssss фамилия менеджера и между ними “.” (знак точки). 
--В каких-то случаях формат имеет вид nssssssss@domain.ru, без точки между именем и фамилией. 
--Необходимо объединить две таблицы с предварительным приведением почты к единому виду и дальнейшей агрегацией. 
--Если для менеджера не определен отдел (указано значение NULL), то таких менеджеров необходимо отнести в группу “Отдел не определен”


select md.department, sum(p.value) as sum
from artsofte.payments p 
left join (
	select CONCAT(substring(md.email ,1, 1), substring(md.email ,3, LENGTH(md.email))) as email
	, case when md.department is null then 'Отдел не определен' else md.department end as department 
	from artsofte.manager_departments md
	) as md on md.email = p.manager_email 
group by md.department

--Задание №3
--
--Необходимо дополнить таблицу с поступлениями полем “состояние клиента”. 
--Если платеж для клиента является первым, то состояние клиента должно быть “Новый”. 
--Для всех остальных платежей данного клиента, состояние должно быть “Действующий”.

with count_p as (
	select client_id , min(id) as min_id
	from artsofte.payments p 
	group by client_id 
)
select p2.*
	,case when cp.min_id = 0 then 'Действующий' else 'Новый' end as client_state
from artsofte.payments p2 
left join count_p as cp on cp.client_id = p2.client_id and cp.min_id = p2.id 
order by p2.client_id , p2.id asc


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






