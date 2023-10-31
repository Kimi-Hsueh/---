

/*
���D�G
���s�إߡutestDB�v��Ʈw
�Ӹ�Ʈw��2���ɮ׸s��(Primary & G1)
�䤤�uPrimary�v�s�զ�2�Ӹ����
�uG1�v�s�զ�1�Ӹ����
����ɨϥιw�]�ȳ]�w�Y�i
*/
use master
if exists (select * from sys.databases where name='TESTDB')
drop database testdb
go
--�إߡuTestDB�v
create database TestDB

--�إ�primary�s�ո���ɡA�n�screate database���O�@�_����
ON primary(
	NAME=DB1,
	FileName='C:\DB\DB1.mdf'),
	(
	NAME=DB2,
	FileName='C:\DB\DB2.ndf'),
--�إ�G1�s�ո����
FileGroup G1(
	NAME=DB3,
	FileName='C:\DB\DB3.ndf')

/*
���D�T
���O�b�uPrimary�v�P�uG1�v�s�դ��إ߸�ƪ�A1���Ρ�A2��
���W��p�U�G
��W�Gid,name
���O�Gint, nvarchar(10)
�ȡG�۰ʽs����ABCDE
*/
--�s�uTestDB��Ʈw
use TestDB
go

--�NA1��ƪ�إߦbPrimary�s��
create table A1
(
id int identity,
name nvarchar(10)) on [primary]

--�NA1��ƪ�إߦbG1�s��
create table A2
(
id int identity,
name nvarchar(10)) on G1

--�bA1��ƪ��g�J60�U�������
insert into A1 values ('�W�s���Ѫ�')
go 600000

--�bA2��ƪ��g�J20�U�������
insert into A2 values ('�ڦb�F�_���d��')
go 100000

--�d��A1/A2��ƪ�������
select COUNT(*) from A1
select COUNT(*) from A2

--�d��A1/A2��ƪ��e
select * from A1
select * from A2

--�u�Ȥ�v��ƪ�s�W������A����15
alter table �Ȥ� add ��� nvarchar(15)
go
--�u����v�����קאּ20
alter table �Ȥ� alter column ��� nvarchar(20)

--�ܧ�u�a�}�v��쬰not Null
ALTER TABLE �Ȥ� ALTER COLUMN �a�} NVARCHAR(30) NOT NULL
GO

--��uck_�Ȥ�_�W�١v�W�h�אּ�ˬd�u�a�}�v�P�u�q�ܡv���i�P�ɬ�Null
--1 �d�߸�ƪ��Ҧ�����������W�h
EXEC sp_helpconstraint �Ȥ�
--2 �R����CK_�Ȥ�_�W�١���������W�h
alter table �Ȥ� drop CK_�Ȥ�_�W��
--3 �s�W��ck_�Ȥ�_�W�١���������W�h���G�ˬd�u�a�}�v�P�u�q�ܡv���i�P�ɬ�Null
alter table �Ȥ� drop constraint [CK_�Ȥ�_�W��]
alter table �Ȥ� with nocheck add constraint [CK_�Ȥ�_�W��] check (�a�} is not null or �q�� is not null)
go
--�s�W�u�Ƶ����v�A�w�]�ȡ��L��
alter table �Ȥ� add �Ƶ� nvarchar(500) constraint DF_�Ȥ�_�Ƶ� default '�L'
go