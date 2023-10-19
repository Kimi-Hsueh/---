drop talbe 客戶

--建立資料表
create table 客戶(
	客戶編號	int identity(1,1),
	身份證號	nchar(10),
	地址		nvarchar(50),
	電話		nvarchar(15),
	constraint [CK_地址/電話必需輸入一項] check (地址 is not null or 電話 is not null) --check的條件用and/or的方式去做調整
)
go

--輸入客戶資料
insert 客戶 values('s1212121','高雄縣','0911124124')
insert 客戶 values('p1212121','不知道縣','0911124125')
go 5

--查詢客戶
select * from 客戶

--新增客戶
insert 客戶 (地址,電話) values ('新北市',NULL)

--在資料表中新增欄位
alter table 客戶 add 名稱 nvarchar(30)

--在資料表中新增條件約束(預設為WITH CHECK)，如果要“既往不究”，則需在設定條件的前面加上☆WITH NOCHECK☆
alter table 客戶 WITH NOCHECK add constraint CK_客戶_名稱 CHECK (名稱 is not NULL)

insert 客戶 (地址,電話) values ('新北市','7533967')

insert 客戶 (地址,電話,名稱) values ('新北市','7533967','紅鞋女孩')

--自動欄位的補號
set IDENTITY_INSERT 客戶 ON
insert 客戶 (客戶編號,地址,電話,名稱) values (14,'新北市','7533967','花心大少')
set IDENTITY_INSERT 客戶 OFF

--建立資料表主鍵
ALTER TABLE 客戶 add constraint PK_客戶_名稱 PRIMARY KEY (客戶編號)
--建立客戶與訂單的外來鍵
ALTER TABLE 訂單 add constraint FK_訂單_客戶編號 foreign key (客戶編號) references 客戶(客戶編號)
go

--查詢訂單資料表
select * from 訂單
go

--在訂單資料表中輸入多筆資料
insert into 訂單 values
(15,GETDATE(),14),
(16,GETDATE(),12),
(19,GETDATE(),13)
go

--在訂單資料表中刪除資料
delete from 訂單 where 客戶編號=12
go

--當需要刪除客戶又得保留訂單資料時，需要先暫停外來鍵參考，待刪除後，啟用外來鍵參考

--外來鍵暫停參考
alter table 客戶 nocheck constraint FK_訂單_客戶編號

--刪除客戶14
delete from 客戶 where 客戶編號=14

--啟用外來鍵參考
alter table 訂單 check constraint FK_訂單_客戶編號
go

--查詢資料表內的條件約束
sp_helpconstraint 訂單

--將外來鍵改為重疊顯示(使用場景：要移除連動資料時可以使
	--step1 移除外來鍵設定
	alter table 訂單 drop FK_訂單_客戶編號
	--建立與外來鍵的重疊顯示
	alter table 訂單 add constraint FK_訂單_客戶編號 foreign key (客戶編號) references 客戶(客戶編號) on delete cascade 
