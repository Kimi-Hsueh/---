

/*
例題二
重新建立「testDB」資料庫
該資料庫有2個檔案群組(Primary & G1)
其中「Primary」群組有2個資料檔
「G1」群組有1個資料檔
資料檔使用預設值設定即可
*/
use master
if exists (select * from sys.databases where name='TESTDB')
drop database testdb
go
--建立「TestDB」
create database TestDB

--建立primary群組資料檔，要連create database指令一起執行
ON primary(
	NAME=DB1,
	FileName='C:\DB\DB1.mdf'),
	(
	NAME=DB2,
	FileName='C:\DB\DB2.ndf'),
--建立G1群組資料檔
FileGroup G1(
	NAME=DB3,
	FileName='C:\DB\DB3.ndf')

/*
例題三
分別在「Primary」與「G1」群組中建立資料表“A1”及“A2”
欄位規格如下：
欄名：id,name
型別：int, nvarchar(10)
值：自動編號“ABCDE
*/
--連線TestDB資料庫
use TestDB
go

--將A1資料表建立在Primary群組
create table A1
(
id int identity,
name nvarchar(10)) on [primary]

--將A1資料表建立在G1群組
create table A2
(
id int identity,
name nvarchar(10)) on G1

--在A1資料表中寫入60萬次的資料
insert into A1 values ('上山打老虎')
go 600000

--在A2資料表中寫入20萬次的資料
insert into A2 values ('我在東北玩泥巴')
go 100000

--查詢A1/A2資料表中的筆數
select COUNT(*) from A1
select COUNT(*) from A2

--查詢A1/A2資料表內容
select * from A1
select * from A2

--「客戶」資料表新增手機欄位，長度15
alter table 客戶 add 手機 nvarchar(15)
go
--「手機」欄位長度改為20
alter table 客戶 alter column 手機 nvarchar(20)

--變更「地址」欄位為not Null
ALTER TABLE 客戶 ALTER COLUMN 地址 NVARCHAR(30) NOT NULL
GO

--原「ck_客戶_名稱」規則改為檢查「地址」與「電話」不可同時為Null
--1 查詢資料表中所有的條件約束規則
EXEC sp_helpconstraint 客戶
--2 刪除“CK_客戶_名稱”條件約束規則
alter table 客戶 drop CK_客戶_名稱
--3 新增“ck_客戶_名稱”條件約束規則為：檢查「地址」與「電話」不可同時為Null
alter table 客戶 drop constraint [CK_客戶_名稱]
alter table 客戶 with nocheck add constraint [CK_客戶_名稱] check (地址 is not null or 電話 is not null)
go
--新增「備註欄位」，預設值“無”
alter table 客戶 add 備註 nvarchar(500) constraint DF_客戶_備註 default '無'
go