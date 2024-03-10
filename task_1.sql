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