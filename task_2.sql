-- Задание 2
--
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