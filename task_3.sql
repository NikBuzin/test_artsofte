
--Задание 3
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