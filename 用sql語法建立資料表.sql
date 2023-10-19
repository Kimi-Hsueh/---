create table �q��(
	�q��s��	int,
	�U����	datetime,
	�Ȥ�s��	nchar(3)
)
go

create table �q�����(
	�q��s��	int,
	���~�s��	int,
	���		smallint,
	�ƶq		smallint,
	�p�p	AS	���*�ƶq --����쬰�p�����A�y�k�� AS ���*���
)
go
insert �q����� values(2,9,33,562) --insert�y�k�G insert "table�W��" values (���1,���2,�K)
select * from �q����� --select�y�k�Gselect ���U�βŸ��� from ��table�W�١�
go

--�إ�primary key��not null
drop table �q��

create table �q��(
	�q��s��	int primary key,  --�]��primary key�����󭭨�w�]�tnot null�F�A�ҥH���ΦA��J"not null"
	�U����	datetime not null, --�p�G�n�b�����O���DNull�ɡA�b��ƫ��A�᭱��J��not null"
	�Ȥ�s��	nchar(3)
)
select * from �q��
go

--�ϥ�constraint�إ�table�����ƦX�D��
drop table �q�����

create table �q�����(
	�q��s��	int,
	���~�s��	int,
	���		smallint,
	�ƶq		smallint,
	�p�p	AS	���*�ƶq --����쬰�p�����A�y�k�� AS ���*���
	constraint PK_�q��s���β��~�s�� primary key(�q��s��,���~�s��) --constraint�y�k�G constraint "������W��" primary key(���1,���2,�K)

)
go

--�]�wdefault�ɶ��Pnull����k
drop table �q��

create table �q��(
	�q��s��	int primary key,
	�U����	datetime null default getdate(), --�p�G�n�b�����O��Null�ɡA�b��ƫ��A�᭱��J��null"
	�Ȥ�s��	nchar(3)
)
go

insert �q�� values (1,'2023/10/4 15:00:00','C01') --��n��J�r��ɡA�n�b��J����r�e��[�W��޸�

insert �q�� (�q��s��,�Ȥ�s��) values (2,'C01') --���wtable�������W�ٶi���ƿ�J

insert �q�� values(3,default,'C01') --�۰ʱa�J�t�ήɶ��G��U�������w��default

insert �q�� values (4,null,'C01') --��U�������w��null

select * from �q��
go
--UNIQUE�]�w�]�ߤ@�ȡ^
create table �Ȥ�(
	�Ȥ�s��	int primary key,
	�����Ҹ�	nchar(10) UNIQUE,
	�a�}		nvarchar(30),
	�q��		nvarchar(15)
)
go
insert �Ȥ� values(1,'f123456789','�s�_��','02-3939889')
insert �Ȥ� values(2,NULL,'�x����','04-3839112')
insert �Ȥ� values(3,'t198765432','������','07-28825252') 
insert �Ȥ� values(4,NULL,'�y����','02-3839112') --�p�G��UNIQUE�ȬۦP�ɡA�|�X�{���_�����ޭȰT��
insert �Ȥ� values(4,'k192168152','�Ὤ��','02-3839112') --�p�G��primary key�ȬۦP�ɡA�]�L�k�إ߸�Ƴ�
select * from �Ȥ�
go
--check�]�w:�w��S�w���i���ˬd
drop table �Ȥ�

create table �Ȥ�(
	�Ȥ�s��	int primary key,
	�����Ҹ�	nchar(10) UNIQUE,
	�a�}		nvarchar(30),
	�q��		nvarchar(15),
	constraint [CK_�a�}/�q�ܥ��ݿ�J�@��] check (�a�} is not null or �q�� is not null) --check�������and/or���覡�h���վ�
)
go
insert �Ȥ� values(1,'f123456789','�s�_��','02-3939889')
insert �Ȥ� values(2,'t198765432',null,'07-28825252') --�a�}���null
insert �Ȥ� values(3,'k192168152','�Ὤ��',null) --�q�����null
insert �Ȥ� values(4,'f143456789',null,null) --��a�}�P�q�����Ҭ�null�ɡA�]���]�wcheck���󬰡��a�}/�q�ܥ��ݿ�J�@�����A�ҥH�X�{���~
select * from �Ȥ�
go

--�إ�FOREIGN KEY
drop table �q��

create table �q��(
	�q��s��	int primary key,
	�U����	datetime null default getdate(), --�p�G�n�b�����O��Null�ɡA�b��ƫ��A�᭱��J��null"
	�Ȥ�s��	int
	constraint FK_�q��_to_�Ȥ�s�� foreign key (�Ȥ�s��) references �Ȥ�(�Ȥ�s��)
)
go
insert �q�� values (1,getdate(),3)
select * from �q��
insert �q�� values (2,getdate(),4) --�X�{���~�T���A�]���b�Ȥ᪺table���S���Ȥ�s����4��
select * from �Ȥ�
go

delete �Ȥ� where �Ȥ�s��=3 --�X�{���~�T���A�]���b�q�檺table���w�g�s�b�Ȥ�s����3���F�A�ҥH�L�k�R��
select * from �q��
select * from �Ȥ�
go

delete �Ȥ� where �Ȥ�s��=2 --�Ȥ�s����2���Q�R���F�A�]���Ȥ�s��2�S���s�b�����table��
select * from �Ȥ�
go

--ALTER TABLE
--�N�Ȥ�Table�����Ȥ�a�}�����ק�אּ50
alter table �Ȥ� alter column �a�} nvarchar(50)
go
--�b�Ȥ�table���W�[�����q�W�١������A���׬�30
alter table �Ȥ� add ���q�W�� nvarchar(30)
go
--�b�Ȥ�table���R�������q�W�١������
alter table �Ȥ� drop column ���q�W��
go

EXEC sp_helpconstraint �Ȥ�

--�R���������
alter table �Ȥ� drop UQ_�Ȥ�_532B9214305E355E
go