--使用delete的方式刪除A1資料表內的資料
/*使用delete的方式刪除資料，會記錄進db的log檔案
編號會從上一次刪除的位置開始延續*/
delete from A1

--使用truncate的方式刪除A2資料表內的資料
/*使用truncate刪除資料，不會記錄進db的log檔案
編號會從頭開始*/
truncate table A2

--將資料檔案清空
dbcc shrinkfile (DB2,emptyfile)

--移除資料檔
alter database testdb remove file DB2


select * from A1
select * from A2

insert into A1 values ('show time')
go 30

insert into A2 values ('上上下下左左右右')
go 40