
--1. Добавить новый учебный курс в таблице Course.

select* 
from Course c

insert into Course ( CourseId, Code, Title, [Description], Amount, [Status], CreateDate)
values ( 500, 'WT500', 'Домашнее задание', 'Выполнение домашнего задания после лекции 3', 5000.50, 'A', CURRENT_TIMESTAMP)

/*2. Добавить описание новосозданного курса (п.1.) в таблице CourseContent (минимум 3 записи).*/

select* 
from CourseContent cc

insert into CourseContent (CourseId,ContentType,Title, [Description])
values ( 200,'HW','Выполнение анализа исходных даных', ' '),
        ( 200,'HW','Формирование плана выполнения задачи', ' '),
		( 200,'HW','Проверка успешного выполнения задачи', ' ')


 /*3. Добавить новую учебную группу в таблице UserGroup*/

 select * 
 from UserGroup ug

 insert into UserGroup (CourseId, [Name], CreateDate, UpdateDate, [Status])
  values (500,'Группа №5. Домашняя работа', CURRENT_TIMESTAMP, 2021-05-02, 'D') 

--4. Добавить 2 новых пользователя в таблицу UserData со статусом 'D' и параметром 0 и 1.

select * 
from UserData ud

insert into UserData
values( 'test1','456lnhjp','Тест1', 'Тест', 'Тест',CURRENT_TIMESTAMP,2021-05-05,'D',0),
      ( 'test2','456ln456','Тест2', 'Тест', 'Тест',CURRENT_TIMESTAMP,2021-05-05,'D',1)


-- 5. Добавить еще 2 пользователя в таблицу UserData с другим допустимым статусом и параметром 0 и 1.
insert into UserData
values( 'test3','456lnh522p','Тест3', 'Тест', 'Тест',CURRENT_TIMESTAMP,2021-05-05,'A',0),
      ( 'test4','456ln422256','Тест4', 'Тест', 'Тест',CURRENT_TIMESTAMP,2021-05-05,'A',1)

/*.6 Изменить статус  на 'активный' для своих новосозданных пользователей у которых статус 'D'. 
Изменить параметр на 1 для своих новосозданных пользователей у которых параметр 0.
Также изменить дату с поле  UpdateDate через 
функцию CURRENT_TIMESTAMP только для своих пользователей у которых производились изменения статуса и параметра.*/

update UserData set [Status] = 'A' , UpdateDate = CURRENT_TIMESTAMP, Parameter= '1'
where Login = 'test1'
 or Login = 'test2' 
 or Login = 'test3' 

 /*7. Связать своих 4-х новых пользователей с группой (связь данных с таблиц UserGroup и UserData через таблицу UserGroupLink). 
 Для определения идентификатора пользователя, постарайтесь научиться использовать функцию getUserId.
Пример ее использования есть в скрипте 3 - Insert_Tables.sql при вставке в таблицу "[UserRoleLink] inserts".
Функция, это универсальный механизм, вам не придется вручную прописывать идентификатор пользователя, который у вас и у меня может отличаться.*/

select *
from UserGroupLink ugl

insert into UserGroupLink 

select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = 'Группа №5. Домашняя работа'), (select* from getUserId( 'test1'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = 'Группа №5. Домашняя работа'), (select* from getUserId( 'test2'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = 'Группа №5. Домашняя работа'), (select* from getUserId( 'test3'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = 'Группа №5. Домашняя работа'), (select* from getUserId( 'test4'))

/*8. Выбрать всех пользователей из СВОЕЙ ГРУППЫ и своего КУРСА, отсортировав по имени пользователя (FirstName). Вывести только эти колонки: 
Login, FirstName, MiddleName, LastName, [Name] as GroupName (колонка с таблицы UserGroup), Title (таблица Course).
Ожидаю получить SELECT в секции FROM которого будет написано 4 таблицы (UserData, UserGroupLink, UserGroup, Course),
далее в условии WHERE и AND необходимо связать эти таблицы по корректным идентификаторам таблиц.
Так же написать дополнительное условие фильтрации (AND) по названию новой группы, что бы вывести только своих 4-х студентов со своей группы.
Сортировка, это дополнительное условие в самом конце выборки: ORDER BY FirstName.*/

select ud.Login, ud.FirstName,ud.MiddleName, ud.LastName, ug.Name, c.Title
from UserData ud, UserGroupLink ugl, UserGroup ug, Course c
where ud.UserDataId = ugl.UserDataId
and ug.UserGroupId= ugl.UserGroupId
and ug.CourseId = c.CourseId
 and ug.Name = 'Группа №5. Домашняя работа'
 order by FirstName

 /*9. Удалить своих пользователей с БД, созданную группу и описатели курса и курс. Нужно будет проделать работу в  обратном порядке.
 Просто так пользователя удалить не получится, потому что он будет связан с новосозданной группой.
Выполняйте удаление по Login с таблицы UserData. Это поле уникально и удалится только тот пользователь, 
которого вы напишете в условии WHERE Login  = 'логин пользователя' или через IN ('','','') 
указав перечень логинов пользователей. Так же можно использовать функцию, на ваше усмотрение.*/

select *
from UserGroupLink

delete from UserGroupLink
where UserGroupId in ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name in ( 'Группа №5. Домашняя работа'))

delete 
from UserData 
where Login in( 'test1','test2','test3','test4')

delete 
from UserGroup
where Name = 'Группа №5. Домашняя работа'

delete 
from CourseContent
where  ContentType = 'HW'

delete 
from Course
where  Title = 'Домашнее задание'

--1. Найти документы в таблице Payment, где сумма (Amount)  больше равна 26024.92.

select * 
from Payment p
where p.Amount = 26024.92
or p.Amount > 26024.92

--2. Найти документы в таблице Payment, где назначение платежа (TXT) имеет слово 'рахунок' в любом сегменте строки, И валюта (Currency) документов может быть '978', '980'.

select * 
from Payment p
where p.TXT  like '%рахунок%'
and p.Currency in ( 978,980 )


--3. Найти документы в таблице Payment, где дата документа между 2010-02-11 и 2011-05-22, и валюта документов НЕ равна 980.
select * 
from Payment p
where p.Data_doc  between '2010-02-11' and '2011-05-22'
and p.Currency !=980 

--4. Найти документы в таблице Payment, где Дебет счета (DebAcc) может иметь  такие счета '260070001','260088791','260006443', Статус '+' и валюта НЕ 980.

select * 
from Payment p
where p.DebAcc  in ('260070001','260088791','260006443')
and p.Status = '+'
and p.Currency !=980 

/*Найти документы в таблице Payment, где Дебет счета (DebAcc) может иметь  такие счета '260070001','260088791','260006443'.
При этом вывести сумму документа Amount умноженную на 3 и от этой суммы отнять 1000.*/

select SUM (Amount) *3 -1000
from Payment p
where p.DebAcc  in ('260070001','260088791','260006443')

/*6. Вывести счета с таблицы Account, где "(" Status равен 'O' И дата открытия OpenDate равна 2016-01-21 ")"
ИЛИ дата закрытия CloseDate явяется НЕ NULL. Здесь обратите внимание на скобки в условии.*/

select *
from Account a 
where (a.Status = 'O' 
and a.OpenDate = '2016-01-21')
or a.CloseDate != ''

/*7. Вывести счета с таблицы Account, где Status равен 'O' И "(" дата открытия OpenDate равна 2016-01-21 ИЛИ дата закрытия CloseDate явяется НЕ NULL ")".
Здесь обратите внимание на скобки в условии.*/
select *
from Account a 
where a.Status = 'O' 
and (a.OpenDate = '2016-01-21'
or a.CloseDate != '')

--8. Вывести пользователей с таблицы Customer и Salary, у которых ДР '1977-09-26', получал Бонус и дата ЗП между '2019-03-31' и '2019-09-30'.

select *
from Customer c,Salary s
where c.Birthday = '1977-09-26'
and s.Bonus != 0
and s.Date between '2019-03-31' and '2019-09-30'

/*9. Вывести информацию о пользователях и его счетах с таблиц Customer и Account, где:
	- Клиенты нерезиденты
	- Счет начинается на 2650
	вторая часть выборки
	- Клиенты нерезиденты
	- Код валюты 980.
Подсказка: между запросами использовать UNION или UNION ALL, но что бы выводимые строки не дублировались (попрактикуйте с этим оператором соединения)
Поля для вывода такие: CustomerLogin, NameUser, Resident, Country, Gender, Account, Currency, [Status], OpenDate
Отсортировать по дате открытия счета в обратном порядке.*/

select *
from Customer c,Account a
where c.Resident = 'N'
and a.Account like '2650%'

union

select *
from Customer c,Account a
where c.Resident = 'N'
and a.Currency = 980

--10. Выбрать тех клиентов, у которых была сумма ЗП но без бонусов и при этом они ниразу не были оштрафованы, и статус клиента Открыт.

select *
from Customer c, Penalty p,Salary s
where  c.Cust_Id != p.CustomerId 
and s.Amount !=0 
and s.Bonus is NULL
and c.Status = 'O'

/*11.
Найти платежи, назначение платежа которых имеет фрагмент слова "алког" (в любом сегменте назначения платежа).
Дебет DebAcc счета этих платежей использовать для поиска/связи счета в таблице счетов Account.
А с таблицы Account сделать связь на клиента-владельца с таблицы Customer.	
Вывести только поле NameUser.*/ 

select *
from Payment p
where p.TXT like '%алког%'


select NameUser 
from Customer c, Account a
where c.Cust_Id = a.Cust_Id
and a.Account in( '260027466', '260006443')































 

