/*掛載mdf資料檔案*/
CREATE DATABASE NorthwindC on
(filename= 'C:\DB\NorthwindC.mdf')
for attach

/* 
select語法常用指令
SELECT 欄位資料
FROM	資料來源
WHERE	資料過濾
GROUP BY	群組(分類)資料
HAVING	群組過濾
ORDER BY 排序
*	萬用字元-代表資料來源的所有資料
*/

/*查詢員工table內的所有資料*/
SELECT * FROM NorthwindC.dbo.員工
SELECT * FROM 員工

/*只查詢指定的欄位*/
/*只查詢員工編號，姓名，職稱*/
SELECT 員工編號 , 姓名 , 職稱 FROM 員工

--先使用SELECT * FROM 供應商查詢資料庫內容
SELECT * FROM 供應商
--使用AS指令，指定欄位的別名
SELECT 城市 AS 行政區 FROM 供應商

--使用DISTINCT指令去除條件相同的查詢(如果查詢的欄位為Null，會視為重複資料)
SELECT DISTINCT 連絡人職稱 FROM 供應商
--DISTINCT指令會將查詢欄位的NULL值視為重複資料
SELECT DISTINCT 相片 FROM 員工

--在查詢中使用int或float型態計算值欄位(建議，在計算後最好是要給結果一個欄位別名)
SELECT * FROM 訂貨明細
SELECT 單價 * 數量 AS 總價 FROM 訂貨明細

--在查詢中進行合併其他欄位資料值的文字計算
SELECT * FROM 員工
SELECT 姓名+'-英文名-'+名 AS 中英文名對照 FROM 員工
--在查詢中指定欄位中的文字並合伴其他欄位資料值的文字計算
SELECT LEFT(姓名,1)+稱呼 AS 先生或小姐 FROM 員工

--where資料過濾及like模糊比對
--查出員工資料表在附註欄位有“認真”的關鍵字
select* from 員工
SELECT * from 員工 WHERE 附註 LIKE '%認真%'
--只查詢員工資料表在附註欄位以“認真”為結尾的關鍵字
SELECT * from 員工 WHERE 附註 LIKE '%認真'

--例1 列出銀行客戶
SELECT * FROM 客戶
SELECT * from 客戶 WHERE 公司名稱 LIKE '%銀行%'
--例2 找出在中正路的供應商
SELECT * from 客戶 WHERE 地址 LIKE '%中正路%'
--例3 客戶名第一個是大或是山或是東的客戶資料
SELECT * FROM 客戶 WHERE 公司名稱 LIKE '[大山東]%'
--例4 客戶編號as或ar或os或or結尾的資料
SELECT * FROM 客戶 WHERE 客戶編號 LIKE '%[AO][RS]' /*比對條件為AO開頭 RS結尾*/
--例5 客戶編號第2個字為NAO及最後一個字是GHIJK結尾的資料
SELECT * FROM 客戶 WHERE 客戶編號 LIKE '_[NAO]%[G-K]'

--更新員工資料表中的員工編號4，在附註加入“積極向上，認真負責”
UPDATE 員工 SET 附註='積極向上，認真負責' WHERE 員工編號=4
UPDATE 員工 SET 附註='北市凱達格蘭大道1號' WHERE 員工編號=8

--使用邏輯運算子搜尋資料
--邏輯運算子的優先順序 NOT>AND>OR
--如果要改變排序，可以利用括號優先執行的方式進行搜尋
SELECT * FROM 產品資料 WHERE (供應商編號=1 OR 供應商編號=6) AND 庫存量<=安全存量

--IN關鍵字：當需要在同一個欄位執行多個關鍵字搜尋時
SELECT * FROM 客戶 WHERE 城市 IN ('台北市','台中市','高雄市')
----IN關鍵字：當需要在同一個欄位執行多個關鍵字反向搜尋時
SELECT * FROM 客戶 WHERE 城市 NOT IN ('台北市','台中市','高雄市')

--NULL值搜尋-不可使用比較運算法進行搜尋，需使用測試判斷法
SELECT * FROM 員工 WHERE 相片 IS NULL --正確寫法
SELECT * FROM 員工 WHERE 相片=NULL --錯誤寫法

--ISNULL函數
--查詢資料表時，如果有欄位值是NULL值時，可以使用ISNULL()函數來輸出替代值
--使用情境：檢查運算式是否為NULL空值，如果是，就以替代值輸出。
SELECT 員工編號,姓名,ISNULL(相片,'沒有相片') FROM 員工
--但ISNULL函數的搜尋結果是不會有資料行名稱，此時可以使用欄位別名的方式進行搜尋
SELECT 員工編號,姓名,ISNULL(相片,'沒有相片') AS 繳交相片資料 FROM 員工

--聚合函數
--計算訂貨明細表中的產品編號51各項資訊
SELECT SUM(數量) AS '訂購總數' FROM 訂貨明細 WHERE 產品編號=51
SELECT COUNT(訂單號碼) AS '訂購筆數' FROM 訂貨明細 WHERE 產品編號=51
SELECT AVG(數量) AS '平均數量' FROM 訂貨明細 WHERE 產品編號=51
SELECT MIN(數量) AS '單筆訂購最小值' FROM 訂貨明細 WHERE 產品編號=51
SELECT MAX(數量) AS '單筆訂購最大值' FROM 訂貨明細 WHERE 產品編號=51
--將各項資訊使用一個函數式進行計算
SELECT * FROM 訂貨明細 WHERE 產品編號=51
SELECT SUM(數量) '訂購總數', --使用聚合函數的加總功能計算總數量
COUNT(訂單號碼) '訂單筆數', --
AVG(數量) '平均數量',
MIN(數量) '單筆訂購最小值',
MAX(數量) '單筆訂購最大值'
FROM 訂貨明細 WHERE 產品編號 IN (50,51) GROUP BY 產品編號

--HAVING群組過濾
--例：過濾出訂購總數超過500以上的產品編號
SELECT 產品編號,SUM(數量) '訂購總數' FROM 訂貨明細 GROUP BY 產品編號  HAVING SUM(數量)>=500
--例：過濾出訂單明細中每筆訂單平均超過20個的產品編號
SELECT 產品編號,AVG(數量) '平均數量' FROM 訂貨明細 GROUP BY 產品編號  HAVING AVG(數量)>=20

--Grouping sets ->自定義的小計與統計
--小計
--用法：Grouping sets(GROUP BY欄位, 小計欄位)
SELECT 產品編號, 單價, SUM(數量) 總數量 FROM 訂貨明細 
WHERE 產品編號 IN (50,51) 
GROUP BY Grouping sets ((產品編號,單價),產品編號)

--總計->在括號內的最後項目輸入()
--用法：Grouping sets(GROUP BY欄位, 小計欄位,總計)
SELECT 產品編號, 單價, SUM(數量) 總數量 FROM 訂貨明細 
WHERE 產品編號 IN (50,51) 
GROUP BY Grouping sets ((產品編號,單價),產品編號, ())

--TOP N
SELECT TOP 10 * FROM 訂貨主檔

--TOP N PERCENT
SELECT TOP 10 PERCENT * FROM 訂貨主檔

--TOP N 通常會搭配ORDER BY一起使用
SELECT TOP 5 * FROM 訂貨明細 ORDER BY 數量 DESC

--若取同位階資料，可使用TOP N WITH TIES
SELECT TOP 5 WITH TIES * FROM 訂貨明細 ORDER BY 數量 DESC

--分頁查詢-OFFSET-> 跳過前N筆資料
SELECT 訂單號碼,員工編號 FROM 訂貨主檔 ORDER BY 訂單號碼 OFFSET 20 ROW

--分頁查詢-FETCH NEXT->傳回N筆資料
SELECT 訂單號碼,員工編號 FROM 訂貨主檔 ORDER BY 訂單號碼 OFFSET 30 ROW FETCH NEXT 10 ROW ONLY









