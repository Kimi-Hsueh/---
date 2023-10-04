create database testdb /*建立db指令*/

drop database testdb /*刪除db指令*/

--用DDL指令建立database
create database kimi_test /*命名資料庫名稱*/
on --執行資料庫的設定
(name = kimi_test, /*設定資料庫的邏輯名稱*/
filename = 'C:\2023_Python\各項作業區\資料庫\kimi_test.mdf', /*設定資料庫的存放位置*/
size = 30MB, /*設定資料庫初始大小*/
filegrowth = 30%), /*設定資料自動成長*/
--如果要再設定其他的設定，在括號後面一定要加"逗號"
filegroup kimi_g1 /*設定資料群組
(name = kimi_g1, /*設定資料庫的邏輯名稱*/
filename = 'C:\2023_Python\各項作業區\資料庫\kimi_g1.ndf', /*設定資料庫的存放位置*/
size = 30MB, /*設定資料庫初始大小*/
filegrowth = 30%) /*設定資料自動成長*/

--查詢db狀態
exec sp_helpdb kimi_test /*查詢資料庫的狀態*/

--缷離資料庫
exec sp_detach_db kimi_test

--掛載資料庫
exec sp_attach_db kimi_test, 'C:\2023_Python\各項作業區\DBTEST\kimi_test.mdf'

--轉移資料庫-->從A資料夾移到B資料夾
	--Step1 缷載資料庫
	exec sp_detach_db kimi_test
	--Step2 複製mdf檔及ndf檔到B資料夾
	--Step3 建立一個database名稱，並附加mdf檔及ndf檔到B資料夾
	create database kimi_test on
	(filename= 'C:\2023_Python\各項作業區\DBTEST\kimi_test.mdf'),
	(filename= 'C:\2023_Python\各項作業區\DBTEST\kimi_g1.ndf')
	FOR ATTACH