drop talbe �Ȥ�

--�إ߸�ƪ�
create table �Ȥ�(
	�Ȥ�s��	int identity(1,1),
	�����Ҹ�	nchar(10),
	�a�}		nvarchar(50),
	�q��		nvarchar(15),
	constraint [CK_�a�}/�q�ܥ��ݿ�J�@��] check (�a�} is not null or �q�� is not null) --check�������and/or���覡�h���վ�
)
go

--��J�Ȥ���
insert �Ȥ� values('s1212121','������','0911124124')
insert �Ȥ� values('p1212121','�����D��','0911124125')
go 5

--�d�߫Ȥ�
select * from �Ȥ�

--�s�W�Ȥ�
insert �Ȥ� (�a�},�q��) values ('�s�_��',NULL)

--�b��ƪ��s�W���
alter table �Ȥ� add �W�� nvarchar(30)

--�b��ƪ��s�W�������(�w�]��WITH CHECK)�A�p�G�n���J�����s���A�h�ݦb�]�w���󪺫e���[�W��WITH NOCHECK��
alter table �Ȥ� WITH NOCHECK add constraint CK_�Ȥ�_�W�� CHECK (�W�� is not NULL)

insert �Ȥ� (�a�},�q��) values ('�s�_��','7533967')

insert �Ȥ� (�a�},�q��,�W��) values ('�s�_��','7533967','���c�k��')

--�۰���쪺�ɸ�
set IDENTITY_INSERT �Ȥ� ON
insert �Ȥ� (�Ȥ�s��,�a�},�q��,�W��) values (14,'�s�_��','7533967','��ߤj��')
set IDENTITY_INSERT �Ȥ� OFF

--�إ߸�ƪ�D��
ALTER TABLE �Ȥ� add constraint PK_�Ȥ�_�W�� PRIMARY KEY (�Ȥ�s��)
--�إ߫Ȥ�P�q�檺�~����
ALTER TABLE �q�� add constraint FK_�q��_�Ȥ�s�� foreign key (�Ȥ�s��) references �Ȥ�(�Ȥ�s��)
go

--�d�߭q���ƪ�
select * from �q��
go

--�b�q���ƪ���J�h�����
insert into �q�� values
(15,GETDATE(),14),
(16,GETDATE(),12),
(19,GETDATE(),13)
go

--�b�q���ƪ��R�����
delete from �q�� where �Ȥ�s��=12
go

--��ݭn�R���Ȥ�S�o�O�d�q���ƮɡA�ݭn���Ȱ��~����ѦҡA�ݧR����A�ҥΥ~����Ѧ�

--�~����Ȱ��Ѧ�
alter table �Ȥ� nocheck constraint FK_�q��_�Ȥ�s��

--�R���Ȥ�14
delete from �Ȥ� where �Ȥ�s��=14

--�ҥΥ~����Ѧ�
alter table �q�� check constraint FK_�q��_�Ȥ�s��
go

--�d�߸�ƪ����������
sp_helpconstraint �q��

--�N�~����אּ���|���(�ϥγ����G�n�����s�ʸ�Ʈɥi�H��
	--step1 �����~����]�w
	alter table �q�� drop FK_�q��_�Ȥ�s��
	--�إ߻P�~���䪺���|���
	alter table �q�� add constraint FK_�q��_�Ȥ�s�� foreign key (�Ȥ�s��) references �Ȥ�(�Ȥ�s��) on delete cascade 
