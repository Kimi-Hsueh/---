/*����mdf����ɮ�*/
CREATE DATABASE NorthwindC on
(filename= 'C:\DB\NorthwindC.mdf')
for attach

/* 
select�y�k�`�Ϋ��O
SELECT �����
FROM	��ƨӷ�
WHERE	��ƹL�o
GROUP BY	�s��(����)���
HAVING	�s�չL�o
ORDER BY �Ƨ�
*	�U�Φr��-�N���ƨӷ����Ҧ����
*/

/*�d�߭��utable�����Ҧ����*/
SELECT * FROM NorthwindC.dbo.���u
SELECT * FROM ���u

/*�u�d�߫��w�����*/
/*�u�d�߭��u�s���A�m�W�A¾��*/
SELECT ���u�s�� , �m�W , ¾�� FROM ���u

--���ϥ�SELECT * FROM �����Ӭd�߸�Ʈw���e
SELECT * FROM ������
--�ϥ�AS���O�A���w��쪺�O�W
SELECT ���� AS ��F�� FROM ������

--�ϥ�DISTINCT���O�h������ۦP���d��(�p�G�d�ߪ���쬰Null�A�|�������Ƹ��)
SELECT DISTINCT �s���H¾�� FROM ������
--DISTINCT���O�|�N�d����쪺NULL�ȵ������Ƹ��
SELECT DISTINCT �ۤ� FROM ���u

--�b�d�ߤ��ϥ�int��float���A�p������(��ĳ�A�b�p���̦n�O�n�����G�@�����O�W)
SELECT * FROM �q�f����
SELECT ��� * �ƶq AS �`�� FROM �q�f����

--�b�d�ߤ��i��X�֨�L����ƭȪ���r�p��
SELECT * FROM ���u
SELECT �m�W+'-�^��W-'+�W AS ���^��W��� FROM ���u
--�b�d�ߤ����w��줤����r�æX���L����ƭȪ���r�p��
SELECT LEFT(�m�W,1)+�٩I AS ���ͩΤp�j FROM ���u

--where��ƹL�o��like�ҽk���
--�d�X���u��ƪ�b������즳���{�u��������r
select* from ���u
SELECT * from ���u WHERE ���� LIKE '%�{�u%'
--�u�d�߭��u��ƪ�b�������H���{�u��������������r
SELECT * from ���u WHERE ���� LIKE '%�{�u'

--��1 �C�X�Ȧ�Ȥ�
SELECT * FROM �Ȥ�
SELECT * from �Ȥ� WHERE ���q�W�� LIKE '%�Ȧ�%'
--��2 ��X�b��������������
SELECT * from �Ȥ� WHERE �a�} LIKE '%������%'
--��3 �Ȥ�W�Ĥ@�ӬO�j�άO�s�άO�F���Ȥ���
SELECT * FROM �Ȥ� WHERE ���q�W�� LIKE '[�j�s�F]%'
--��4 �Ȥ�s��as��ar��os��or���������
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '%[AO][RS]' /*������AO�}�Y RS����*/
--��5 �Ȥ�s����2�Ӧr��NAO�γ̫�@�Ӧr�OGHIJK���������
SELECT * FROM �Ȥ� WHERE �Ȥ�s�� LIKE '_[NAO]%[G-K]'

--��s���u��ƪ������u�s��4�A�b�����[�J���n���V�W�A�{�u�t�d��
UPDATE ���u SET ����='�n���V�W�A�{�u�t�d' WHERE ���u�s��=4
UPDATE ���u SET ����='�_���͹F�����j�D1��' WHERE ���u�s��=8

--�ϥ��޿�B��l�j�M���
--�޿�B��l���u������ NOT>AND>OR
--�p�G�n���ܱƧǡA�i�H�Q�άA���u�����檺�覡�i��j�M
SELECT * FROM ���~��� WHERE (�����ӽs��=1 OR �����ӽs��=6) AND �w�s�q<=�w���s�q

--IN����r�G��ݭn�b�P�@��������h������r�j�M��
SELECT * FROM �Ȥ� WHERE ���� IN ('�x�_��','�x����','������')
----IN����r�G��ݭn�b�P�@��������h������r�ϦV�j�M��
SELECT * FROM �Ȥ� WHERE ���� NOT IN ('�x�_��','�x����','������')

--NULL�ȷj�M-���i�ϥΤ���B��k�i��j�M�A�ݨϥδ��էP�_�k
SELECT * FROM ���u WHERE �ۤ� IS NULL --���T�g�k
SELECT * FROM ���u WHERE �ۤ�=NULL --���~�g�k

--ISNULL���
--�d�߸�ƪ�ɡA�p�G�����ȬONULL�ȮɡA�i�H�ϥ�ISNULL()��ƨӿ�X���N��
--�ϥα��ҡG�ˬd�B�⦡�O�_��NULL�ŭȡA�p�G�O�A�N�H���N�ȿ�X�C
SELECT ���u�s��,�m�W,ISNULL(�ۤ�,'�S���ۤ�') FROM ���u
--��ISNULL��ƪ��j�M���G�O���|����Ʀ�W�١A���ɥi�H�ϥ����O�W���覡�i��j�M
SELECT ���u�s��,�m�W,ISNULL(�ۤ�,'�S���ۤ�') AS ú��ۤ���� FROM ���u

--�E�X���
--�p��q�f���Ӫ������~�s��51�U����T
SELECT SUM(�ƶq) AS '�q���`��' FROM �q�f���� WHERE ���~�s��=51
SELECT COUNT(�q�渹�X) AS '�q�ʵ���' FROM �q�f���� WHERE ���~�s��=51
SELECT AVG(�ƶq) AS '�����ƶq' FROM �q�f���� WHERE ���~�s��=51
SELECT MIN(�ƶq) AS '�浧�q�ʳ̤p��' FROM �q�f���� WHERE ���~�s��=51
SELECT MAX(�ƶq) AS '�浧�q�ʳ̤j��' FROM �q�f���� WHERE ���~�s��=51
--�N�U����T�ϥΤ@�Ө�Ʀ��i��p��
SELECT * FROM �q�f���� WHERE ���~�s��=51
SELECT SUM(�ƶq) '�q���`��', --�ϥλE�X��ƪ��[�`�\��p���`�ƶq
COUNT(�q�渹�X) '�q�浧��', --
AVG(�ƶq) '�����ƶq',
MIN(�ƶq) '�浧�q�ʳ̤p��',
MAX(�ƶq) '�浧�q�ʳ̤j��'
FROM �q�f���� WHERE ���~�s�� IN (50,51) GROUP BY ���~�s��

--HAVING�s�չL�o
--�ҡG�L�o�X�q���`�ƶW�L500�H�W�����~�s��
SELECT ���~�s��,SUM(�ƶq) '�q���`��' FROM �q�f���� GROUP BY ���~�s��  HAVING SUM(�ƶq)>=500
--�ҡG�L�o�X�q����Ӥ��C���q�業���W�L20�Ӫ����~�s��
SELECT ���~�s��,AVG(�ƶq) '�����ƶq' FROM �q�f���� GROUP BY ���~�s��  HAVING AVG(�ƶq)>=20

--Grouping sets ->�۩w�q���p�p�P�έp
--�p�p
--�Ϊk�GGrouping sets(GROUP BY���, �p�p���)
SELECT ���~�s��, ���, SUM(�ƶq) �`�ƶq FROM �q�f���� 
WHERE ���~�s�� IN (50,51) 
GROUP BY Grouping sets ((���~�s��,���),���~�s��)

--�`�p->�b�A�������̫ᶵ�ؿ�J()
--�Ϊk�GGrouping sets(GROUP BY���, �p�p���,�`�p)
SELECT ���~�s��, ���, SUM(�ƶq) �`�ƶq FROM �q�f���� 
WHERE ���~�s�� IN (50,51) 
GROUP BY Grouping sets ((���~�s��,���),���~�s��, ())

--TOP N
SELECT TOP 10 * FROM �q�f�D��

--TOP N PERCENT
SELECT TOP 10 PERCENT * FROM �q�f�D��

--TOP N �q�`�|�f�tORDER BY�@�_�ϥ�
SELECT TOP 5 * FROM �q�f���� ORDER BY �ƶq DESC

--�Y���P�춥��ơA�i�ϥ�TOP N WITH TIES
SELECT TOP 5 WITH TIES * FROM �q�f���� ORDER BY �ƶq DESC

--�����d��-OFFSET-> ���L�eN�����
SELECT �q�渹�X,���u�s�� FROM �q�f�D�� ORDER BY �q�渹�X OFFSET 20 ROW

--�����d��-FETCH NEXT->�Ǧ^N�����
SELECT �q�渹�X,���u�s�� FROM �q�f�D�� ORDER BY �q�渹�X OFFSET 30 ROW FETCH NEXT 10 ROW ONLY









