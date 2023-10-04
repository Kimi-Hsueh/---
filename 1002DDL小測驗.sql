--  1002DDL�y�k�p����
/*
�إ߸�ƮwTestDB,��Ʈw�n���T���ɮ׸s��(�t�w�]�s��),�C�s�ջݦ��G�Ӹ����,
�C�Ӹ���ɪ�l�e�q30MB,�C������30%,�̤j����2G,
�إߨ�ӰO����,��l�e�q10MB,����10MB,�̤j����2G,
����ɽЦsC:\DataBase�ؿ�,�O���ɽЦsC:\DBLog�ؿ�
*/
create database testdb
on --�����Ʈw���]�w
(name = testdb, --�]�w��Ʈw���޿�W��
filename = 'C:\DataBase\testdb.mdf', --�]�w��Ʈw���s���m
size = 30MB, --�]�w��Ʈw��l�j�p
filegrowth = 30%, --�]�w��Ʈw�����j�p
maxsize = 2GB), --�]�w��Ƴ��̤j����Ŷ�
(name = testdb2, --�]�w��Ʈw���޿�W��
filename = 'C:\DataBase\testdb2.ndf', --�]�w��Ʈw���s���m
size = 30MB, --�]�w��Ʈw��l�j�p
filegrowth = 30%, --�]�w��Ʈw�����j�p
maxsize = 2GB), --�]�w��Ƴ��̤j����Ŷ�
filegroup project1
(
name = p_task1,
filename = 'C:\DataBase\p_task1.ndf',
size =30MB,
filegrowth = 30%,
maxsize = 2GB
),
(
name = p_task2,
filename = 'C:\DataBase\p_task2.ndf',
size =30MB,
filegrowth = 30%,
maxsize = 2GB
),
filegroup project2
(
name = r_task1,
filename = 'C:\DataBase\r_task1.ndf',
size =30MB,
filegrowth = 30%,
maxsize = 2GB
),
(
name = r_task2,
filename = 'C:\DataBase\r_task2.ndf',
size =30MB,
filegrowth = 30%,
maxsize = 2GB
)
LOG on
  (
  NAME = Archlog1,
    FILENAME = 'C:\DBLog\archlog1.ldf',
    SIZE = 10MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 10MB),
  (
  NAME = Archlog2,
    FILENAME = 'C:\DBLog\archlog2.ldf',
    SIZE = 10MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 10MB)
go

--������Ʈw
exec sp_detach_db testdb
go

--���[��Ʈw
exec sp_attach_db testdb, 'C:\DataBase\testdb.mdf'
go

--�bPrimary�s�ո̷s�W�@�Ӹ���ɮ� DB3.NDF
ALTER DATABASE testdb
add file
(name = DB3,
FILENAME = 'C:\DBLog\DB3.ndf',
size = 30MB,
maxsize = 2GB,
filegrowth = 30%)
go


--�R������ɮ� DB3.NDF
ALTER DATABASE testdb
remove file DB3
go
/*
1.�зs�W�@���ɮ׸s��G3
2.�s�W�@�Ӹ���ɮ�G3_DB1,
3.�N�ɮ׸s��G3�קאּDefault�s��
4.�NPrimary�s�ո̪�����ɮת�������̤j��
5.�s�W�@�ӰO����DB_Log_3,�ɮפj�p500MB
*/

--1. �зs�W�@���ɮ׸s��G3
ALTER DATABASE testdb
add filegroup G3
go
--2. �s�W�@�Ӹ���ɮ�G3_DB1
ALTER DATABASE testdb
add file
(name = G3_DB1,
FILENAME = 'C:\DBLog\G3_DB1.ndf',
size = 30MB,
maxsize = 2GB,
filegrowth = 30%) 
TO filegroup G3
go

--3. �N�ɮ׸s��G3�קאּDefault�s��
ALTER DATABASE testdb
modify filegroup G3 Default
go

--4. �NPrimary�s�ո̪�����ɮת�������̤j��
ALTER DATABASE testdb
modify file
(
name =testdb,
maxsize = unlimited
)
ALTER DATABASE testdb
modify file
(
name = testdb2,
maxsize = unlimited
)
go
--5. �s�W�@�ӰO����DB_Log_3,�ɮפj�p500MB
ALTER DATABASE testdb
add log file 
(
name =DB_Log_3,
FILENAME ='C:\DBLog\DB_Log_3.ldf',
size =500MB
)
go






