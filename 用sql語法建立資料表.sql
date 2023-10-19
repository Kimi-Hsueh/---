create table 訂單(
	訂單編號	int,
	下單日期	datetime,
	客戶編號	nchar(3)
)
go

create table 訂單明細(
	訂單編號	int,
	產品編號	int,
	單價		smallint,
	數量		smallint,
	小計	AS	單價*數量 --此欄位為計算欄位，語法為 AS 欄位*欄位
)
go
insert 訂單明細 values(2,9,33,562) --insert語法： insert "table名稱" values (欄位1,欄位2,…)
select * from 訂單明細 --select語法：select “萬用符號” from “table名稱”
go

--建立primary key及not null
drop table 訂單

create table 訂單(
	訂單編號	int primary key,  --因為primary key的條件限制已包含not null了，所以不用再輸入"not null"
	下單日期	datetime not null, --如果要在欄位註記為非Null時，在資料型態後面輸入“not null"
	客戶編號	nchar(3)
)
select * from 訂單
go

--使用constraint建立table內的複合主鍵
drop table 訂單明細

create table 訂單明細(
	訂單編號	int,
	產品編號	int,
	單價		smallint,
	數量		smallint,
	小計	AS	單價*數量 --此欄位為計算欄位，語法為 AS 欄位*欄位
	constraint PK_訂單編號及產品編號 primary key(訂單編號,產品編號) --constraint語法： constraint "索引鍵名稱" primary key(欄位1,欄位2,…)

)
go

--設定default時間與null的方法
drop table 訂單

create table 訂單(
	訂單編號	int primary key,
	下單日期	datetime null default getdate(), --如果要在欄位註記為Null時，在資料型態後面輸入“null"
	客戶編號	nchar(3)
)
go

insert 訂單 values (1,'2023/10/4 15:00:00','C01') --當要輸入字串時，要在輸入的文字前後加上單引號

insert 訂單 (訂單編號,客戶編號) values (2,'C01') --指定table內的欄位名稱進行資料輸入

insert 訂單 values(3,default,'C01') --自動帶入系統時間：把下單日期指定為default

insert 訂單 values (4,null,'C01') --把下單日期指定為null

select * from 訂單
go
--UNIQUE設定（唯一值）
create table 客戶(
	客戶編號	int primary key,
	身份證號	nchar(10) UNIQUE,
	地址		nvarchar(30),
	電話		nvarchar(15)
)
go
insert 客戶 values(1,'f123456789','新北市','02-3939889')
insert 客戶 values(2,NULL,'台中市','04-3839112')
insert 客戶 values(3,'t198765432','高雄市','07-28825252') 
insert 客戶 values(4,NULL,'宜蘭市','02-3839112') --如果當UNIQUE值相同時，會出現重復的索引值訊息
insert 客戶 values(4,'k192168152','花蓮市','02-3839112') --如果當primary key值相同時，也無法建立資料喔
select * from 客戶
go
--check設定:針對特定欄位進行檢查
drop table 客戶

create table 客戶(
	客戶編號	int primary key,
	身份證號	nchar(10) UNIQUE,
	地址		nvarchar(30),
	電話		nvarchar(15),
	constraint [CK_地址/電話必需輸入一項] check (地址 is not null or 電話 is not null) --check的條件用and/or的方式去做調整
)
go
insert 客戶 values(1,'f123456789','新北市','02-3939889')
insert 客戶 values(2,'t198765432',null,'07-28825252') --地址欄位null
insert 客戶 values(3,'k192168152','花蓮市',null) --電話欄位null
insert 客戶 values(4,'f143456789',null,null) --當地址與電話欄位皆為null時，因為設定check條件為“地址/電話必需輸入一項”，所以出現錯誤
select * from 客戶
go

--建立FOREIGN KEY
drop table 訂單

create table 訂單(
	訂單編號	int primary key,
	下單日期	datetime null default getdate(), --如果要在欄位註記為Null時，在資料型態後面輸入“null"
	客戶編號	int
	constraint FK_訂單_to_客戶編號 foreign key (客戶編號) references 客戶(客戶編號)
)
go
insert 訂單 values (1,getdate(),3)
select * from 訂單
insert 訂單 values (2,getdate(),4) --出現錯誤訊息，因為在客戶的table內沒有客戶編號“4”
select * from 客戶
go

delete 客戶 where 客戶編號=3 --出現錯誤訊息，因為在訂單的table內已經存在客戶編號“3”了，所以無法刪除
select * from 訂單
select * from 客戶
go

delete 客戶 where 客戶編號=2 --客戶編號“2”被刪除了，因為客戶編號2沒有存在於任何table中
select * from 客戶
go

--ALTER TABLE
--將客戶Table內的客戶地址欄位長度更改為50
alter table 客戶 alter column 地址 nvarchar(50)
go
--在客戶table內增加“公司名稱”的欄位，長度為30
alter table 客戶 add 公司名稱 nvarchar(30)
go
--在客戶table內刪除“公司名稱”的欄位
alter table 客戶 drop column 公司名稱
go

EXEC sp_helpconstraint 客戶

--刪除條件約束
alter table 客戶 drop UQ_客戶_532B9214305E355E
go