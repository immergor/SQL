
--1. �������� ����� ������� ���� � ������� Course.

select* 
from Course c

insert into Course ( CourseId, Code, Title, [Description], Amount, [Status], CreateDate)
values ( 500, 'WT500', '�������� �������', '���������� ��������� ������� ����� ������ 3', 5000.50, 'A', CURRENT_TIMESTAMP)

/*2. �������� �������� �������������� ����� (�.1.) � ������� CourseContent (������� 3 ������).*/

select* 
from CourseContent cc

insert into CourseContent (CourseId,ContentType,Title, [Description])
values ( 200,'HW','���������� ������� �������� �����', ' '),
        ( 200,'HW','������������ ����� ���������� ������', ' '),
		( 200,'HW','�������� ��������� ���������� ������', ' ')


 /*3. �������� ����� ������� ������ � ������� UserGroup*/

 select * 
 from UserGroup ug

 insert into UserGroup (CourseId, [Name], CreateDate, UpdateDate, [Status])
  values (500,'������ �5. �������� ������', CURRENT_TIMESTAMP, 2021-05-02, 'D') 

--4. �������� 2 ����� ������������ � ������� UserData �� �������� 'D' � ���������� 0 � 1.

select * 
from UserData ud

insert into UserData
values( 'test1','456lnhjp','����1', '����', '����',CURRENT_TIMESTAMP,2021-05-05,'D',0),
      ( 'test2','456ln456','����2', '����', '����',CURRENT_TIMESTAMP,2021-05-05,'D',1)


-- 5. �������� ��� 2 ������������ � ������� UserData � ������ ���������� �������� � ���������� 0 � 1.
insert into UserData
values( 'test3','456lnh522p','����3', '����', '����',CURRENT_TIMESTAMP,2021-05-05,'A',0),
      ( 'test4','456ln422256','����4', '����', '����',CURRENT_TIMESTAMP,2021-05-05,'A',1)

/*.6 �������� ������  �� '��������' ��� ����� ������������� ������������� � ������� ������ 'D'. 
�������� �������� �� 1 ��� ����� ������������� ������������� � ������� �������� 0.
����� �������� ���� � ����  UpdateDate ����� 
������� CURRENT_TIMESTAMP ������ ��� ����� ������������� � ������� ������������� ��������� ������� � ���������.*/

update UserData set [Status] = 'A' , UpdateDate = CURRENT_TIMESTAMP, Parameter= '1'
where Login = 'test1'
 or Login = 'test2' 
 or Login = 'test3' 

 /*7. ������� ����� 4-� ����� ������������� � ������� (����� ������ � ������ UserGroup � UserData ����� ������� UserGroupLink). 
 ��� ����������� �������������� ������������, ������������ ��������� ������������ ������� getUserId.
������ �� ������������� ���� � ������� 3 - Insert_Tables.sql ��� ������� � ������� "[UserRoleLink] inserts".
�������, ��� ������������� ��������, ��� �� �������� ������� ����������� ������������� ������������, ������� � ��� � � ���� ����� ����������.*/

select *
from UserGroupLink ugl

insert into UserGroupLink 

select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = '������ �5. �������� ������'), (select* from getUserId( 'test1'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = '������ �5. �������� ������'), (select* from getUserId( 'test2'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = '������ �5. �������� ������'), (select* from getUserId( 'test3'))
union all
select ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name = '������ �5. �������� ������'), (select* from getUserId( 'test4'))

/*8. ������� ���� ������������� �� ����� ������ � ������ �����, ������������ �� ����� ������������ (FirstName). ������� ������ ��� �������: 
Login, FirstName, MiddleName, LastName, [Name] as GroupName (������� � ������� UserGroup), Title (������� Course).
������ �������� SELECT � ������ FROM �������� ����� �������� 4 ������� (UserData, UserGroupLink, UserGroup, Course),
����� � ������� WHERE � AND ���������� ������� ��� ������� �� ���������� ��������������� ������.
��� �� �������� �������������� ������� ���������� (AND) �� �������� ����� ������, ��� �� ������� ������ ����� 4-� ��������� �� ����� ������.
����������, ��� �������������� ������� � ����� ����� �������: ORDER BY FirstName.*/

select ud.Login, ud.FirstName,ud.MiddleName, ud.LastName, ug.Name, c.Title
from UserData ud, UserGroupLink ugl, UserGroup ug, Course c
where ud.UserDataId = ugl.UserDataId
and ug.UserGroupId= ugl.UserGroupId
and ug.CourseId = c.CourseId
 and ug.Name = '������ �5. �������� ������'
 order by FirstName

 /*9. ������� ����� ������������� � ��, ��������� ������ � ��������� ����� � ����. ����� ����� ��������� ������ �  �������� �������.
 ������ ��� ������������ ������� �� ���������, ������ ��� �� ����� ������ � ������������� �������.
���������� �������� �� Login � ������� UserData. ��� ���� ��������� � �������� ������ ��� ������������, 
�������� �� �������� � ������� WHERE Login  = '����� ������������' ��� ����� IN ('','','') 
������ �������� ������� �������������. ��� �� ����� ������������ �������, �� ���� ����������.*/

select *
from UserGroupLink

delete from UserGroupLink
where UserGroupId in ( select ug.UserGroupId 
    from UserGroup ug
	where ug.Name in ( '������ �5. �������� ������'))

delete 
from UserData 
where Login in( 'test1','test2','test3','test4')

delete 
from UserGroup
where Name = '������ �5. �������� ������'

delete 
from CourseContent
where  ContentType = 'HW'

delete 
from Course
where  Title = '�������� �������'

--1. ����� ��������� � ������� Payment, ��� ����� (Amount)  ������ ����� 26024.92.

select * 
from Payment p
where p.Amount = 26024.92
or p.Amount > 26024.92

--2. ����� ��������� � ������� Payment, ��� ���������� ������� (TXT) ����� ����� '�������' � ����� �������� ������, � ������ (Currency) ���������� ����� ���� '978', '980'.

select * 
from Payment p
where p.TXT  like '%�������%'
and p.Currency in ( 978,980 )


--3. ����� ��������� � ������� Payment, ��� ���� ��������� ����� 2010-02-11 � 2011-05-22, � ������ ���������� �� ����� 980.
select * 
from Payment p
where p.Data_doc  between '2010-02-11' and '2011-05-22'
and p.Currency !=980 

--4. ����� ��������� � ������� Payment, ��� ����� ����� (DebAcc) ����� �����  ����� ����� '260070001','260088791','260006443', ������ '+' � ������ �� 980.

select * 
from Payment p
where p.DebAcc  in ('260070001','260088791','260006443')
and p.Status = '+'
and p.Currency !=980 

/*����� ��������� � ������� Payment, ��� ����� ����� (DebAcc) ����� �����  ����� ����� '260070001','260088791','260006443'.
��� ���� ������� ����� ��������� Amount ���������� �� 3 � �� ���� ����� ������ 1000.*/

select SUM (Amount) *3 -1000
from Payment p
where p.DebAcc  in ('260070001','260088791','260006443')

/*6. ������� ����� � ������� Account, ��� "(" Status ����� 'O' � ���� �������� OpenDate ����� 2016-01-21 ")"
��� ���� �������� CloseDate ������� �� NULL. ����� �������� �������� �� ������ � �������.*/

select *
from Account a 
where (a.Status = 'O' 
and a.OpenDate = '2016-01-21')
or a.CloseDate != ''

/*7. ������� ����� � ������� Account, ��� Status ����� 'O' � "(" ���� �������� OpenDate ����� 2016-01-21 ��� ���� �������� CloseDate ������� �� NULL ")".
����� �������� �������� �� ������ � �������.*/
select *
from Account a 
where a.Status = 'O' 
and (a.OpenDate = '2016-01-21'
or a.CloseDate != '')

--8. ������� ������������� � ������� Customer � Salary, � ������� �� '1977-09-26', ������� ����� � ���� �� ����� '2019-03-31' � '2019-09-30'.

select *
from Customer c,Salary s
where c.Birthday = '1977-09-26'
and s.Bonus != 0
and s.Date between '2019-03-31' and '2019-09-30'

/*9. ������� ���������� � ������������� � ��� ������ � ������ Customer � Account, ���:
	- ������� �����������
	- ���� ���������� �� 2650
	������ ����� �������
	- ������� �����������
	- ��� ������ 980.
���������: ����� ��������� ������������ UNION ��� UNION ALL, �� ��� �� ��������� ������ �� ������������� (������������� � ���� ���������� ����������)
���� ��� ������ �����: CustomerLogin, NameUser, Resident, Country, Gender, Account, Currency, [Status], OpenDate
������������� �� ���� �������� ����� � �������� �������.*/

select *
from Customer c,Account a
where c.Resident = 'N'
and a.Account like '2650%'

union

select *
from Customer c,Account a
where c.Resident = 'N'
and a.Currency = 980

--10. ������� ��� ��������, � ������� ���� ����� �� �� ��� ������� � ��� ���� ��� ������ �� ���� �����������, � ������ ������� ������.

select *
from Customer c, Penalty p,Salary s
where  c.Cust_Id != p.CustomerId 
and s.Amount !=0 
and s.Bonus is NULL
and c.Status = 'O'

/*11.
����� �������, ���������� ������� ������� ����� �������� ����� "�����" (� ����� �������� ���������� �������).
����� DebAcc ����� ���� �������� ������������ ��� ������/����� ����� � ������� ������ Account.
� � ������� Account ������� ����� �� �������-��������� � ������� Customer.	
������� ������ ���� NameUser.*/ 

select *
from Payment p
where p.TXT like '%�����%'


select NameUser 
from Customer c, Account a
where c.Cust_Id = a.Cust_Id
and a.Account in( '260027466', '260006443')































 

