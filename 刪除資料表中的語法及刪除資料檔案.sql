--�ϥ�delete���覡�R��A1��ƪ������
/*�ϥ�delete���覡�R����ơA�|�O���idb��log�ɮ�
�s���|�q�W�@���R������m�}�l����*/
delete from A1

--�ϥ�truncate���覡�R��A2��ƪ������
/*�ϥ�truncate�R����ơA���|�O���idb��log�ɮ�
�s���|�q�Y�}�l*/
truncate table A2

--�N����ɮײM��
dbcc shrinkfile (DB2,emptyfile)

--���������
alter database testdb remove file DB2


select * from A1
select * from A2

insert into A1 values ('show time')
go 30

insert into A2 values ('�W�W�U�U�����k�k')
go 40