--  1002DDL語法小測驗
/*
建立資料庫TestDB,資料庫要有三個檔案群組(含預設群組),每群組需有二個資料檔,
每個資料檔初始容量30MB,每次成長30%,最大限制2G,
建立兩個記錄檔,初始容量10MB,成長10MB,最大限制2G,
資料檔請存C:\DataBase目錄,記錄檔請存C:\DBLog目錄
*/
create database testdb
on --執行資料庫的設定
(name = testdb, --設定資料庫的邏輯名稱
filename = 'C:\DataBase\testdb.mdf', --設定資料庫的存放位置
size = 30MB, --設定資料庫初始大小
filegrowth = 30%, --設定資料庫成長大小
maxsize = 2GB), --設定資料章最大限制空間
(name = testdb2, --設定資料庫的邏輯名稱
filename = 'C:\DataBase\testdb2.ndf', --設定資料庫的存放位置
size = 30MB, --設定資料庫初始大小
filegrowth = 30%, --設定資料庫成長大小
maxsize = 2GB), --設定資料章最大限制空間
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

--卸離資料庫
exec sp_detach_db testdb
go

--附加資料庫
exec sp_attach_db testdb, 'C:\DataBase\testdb.mdf'
go

--在Primary群組裡新增一個資料檔案 DB3.NDF
ALTER DATABASE testdb
add file
(name = DB3,
FILENAME = 'C:\DBLog\DB3.ndf',
size = 30MB,
maxsize = 2GB,
filegrowth = 30%)
go


--刪除資料檔案 DB3.NDF
ALTER DATABASE testdb
remove file DB3
go
/*
1.請新增一個檔案群組G3
2.新增一個資料檔案G3_DB1,
3.將檔案群組G3修改為Default群組
4.將Primary群組裡的資料檔案的不限制最大值
5.新增一個記錄檔DB_Log_3,檔案大小500MB
*/

--1. 請新增一個檔案群組G3
ALTER DATABASE testdb
add filegroup G3
go
--2. 新增一個資料檔案G3_DB1
ALTER DATABASE testdb
add file
(name = G3_DB1,
FILENAME = 'C:\DBLog\G3_DB1.ndf',
size = 30MB,
maxsize = 2GB,
filegrowth = 30%) 
TO filegroup G3
go

--3. 將檔案群組G3修改為Default群組
ALTER DATABASE testdb
modify filegroup G3 Default
go

--4. 將Primary群組裡的資料檔案的不限制最大值
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
--5. 新增一個記錄檔DB_Log_3,檔案大小500MB
ALTER DATABASE testdb
add log file 
(
name =DB_Log_3,
FILENAME ='C:\DBLog\DB_Log_3.ldf',
size =500MB
)
go






