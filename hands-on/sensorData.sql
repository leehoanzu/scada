USE Sensor --Sử dụng vùng data

--1. Hiển thị giá trị full bảng 
SELECT * FROM [Data HG]
SELECT * FROM [Data HG] ORDER BY Times Desc --theo thời gian giảm dần
SELECT * FROM [Data HG] ORDER BY ValueSensor ASC --theo giá trị tăng dần
SELECT TOP 100 [Name Sensor], ValueSensor, Times FROM [Data HG] ORDER BY Times Desc -- chọn 100 giá trị đầu tiên

--2. Hiển thị giá trị theo cột cụ thể từ bảng
SELECT [Name sensor] FROM [Data HG] --theo cột Name sensor

--Hiển thị Name sensor có giá trị ValueSensor = 20
SELECT [Name sensor] FROM [Data HG] WHERE ValueSensor = 20

--Hiển thị ValueSensor trị theo [Name sensor] 
SELECT ValueSensor FROM [Data HG] WHERE [Name sensor] = 'CB0001HG' --20
SELECT ValueSensor FROM [Data HG] WHERE [Name sensor] = 'CB0009REF' --68

--Hiển thị tất cả các cảm biển có cùng giá trị với 'CB0009REF'
SELECT * FROM [Data HG] WHERE ValueSensor =
			(SELECT ValueSensor FROM [Data HG] WHERE [Name sensor] = 'CB0009REF') 

--Hiển thị tất cả các cảm biển có cùng giá trị với 'CB0009REF' và không liệt lê CB0009REF
SELECT * FROM [Data HG] WHERE ValueSensor =
			(SELECT ValueSensor FROM [Data HG] WHERE [Name sensor] = 'CB0009REF')
												AND [Name sensor] <> 'CB0009REF'
					

--3.Liệt kê các cảm biến
SELECT * FROM [Data HG]	WHERE [Name Sensor] = 'MUC_NUOC'; --Có tên MUC_NUOC
SELECT * FROM [Data HG]	WHERE ValueSensor = 68; --có giá trị là 68

--4. Chèn dữ liệu
INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('CB0001HG', 68, GETDATE())

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES(N'CẢM_BIẾN_HIẾU_KHÍ', 88, GETDATE())

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('CB14', 68, GETDATE())

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('MUC_NUOC_DH_NHO', 68, GETDATE())

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('MUC_NUOC_DH_LON', 68, GETDATE())

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('MUC_NUOC_BHK', 68, GETDATE()) 

INSERT INTO [Data HG] ([Name Sensor], ValueSensor, Times) 
			VALUES('CB0009REF', 68, GETDATE()) --Thành phần tham chiếu duy nhất

--5. Xóa đi một phần tử
DELETE FROM [Data HG] WHERE [Name Sensor] = 'CB0009REF'; -- xóa phần tử có tên CB0009REF

DELETE FROM [Data HG] WHERE [Name Sensor] = N'CẢM_BIẾN_HIẾU_KHÍ'; -- xóa phần tử có tên CẢM_BIẾN_HIẾU_KHÍ

--6. Đếm có bao nhiêu cảm biến theo nhóm tên [Name Sensor] xuất hiện lặp lại
SELECT COUNT(*) AS CONFIDENT FROM [Data HG] 
				GROUP BY [Name Sensor]
SELECT [Name Sensor], COUNT(*) FROM [Data HG] 
				GROUP BY [Name Sensor]

--7. Đếm có bao nhiêu cảm biến theo nhóm tên [Name Sensor] xuất hiện lặp lại từ 10 lần 
SELECT [Name Sensor], COUNT(*) FROM [Data HG] 
				GROUP BY [Name Sensor] HAVING COUNT(*) > 10

--9. Cảm biến nào được insert giá trị mới nhiều nhất
SELECT MAX(CONFIDENT) FROM 
	(SELECT [Name Sensor], COUNT(*) AS CONFIDENT FROM [Data HG] 
				GROUP BY [Name Sensor] HAVING COUNT(*) > 10) AS NAME --Lấy được giá trị max

SELECT [Name Sensor], COUNT(*) FROM [Data HG] 
				GROUP BY [Name Sensor] HAVING COUNT(*) = 
					(SELECT MAX(CONFIDENT) FROM 
						(SELECT [Name Sensor], COUNT(*) AS CONFIDENT FROM [Data HG] 
								GROUP BY [Name Sensor] HAVING COUNT(*) > 10) AS NAME)

--10. Cảm biến xuất hiện bao nhiêu lần
SELECT [Name Sensor], COUNT(*) FROM [Data HG] WHERE [Name Sensor] = 'MUC_NUOC_BKT' OR [Name Sensor] = 'CB0001HG'
				GROUP BY [Name Sensor]

SELECT [Name Sensor], COUNT(*) FROM [Data HG] WHERE [Name Sensor] = 'MUC_NUOC_BKT'
				GROUP BY [Name Sensor]

SELECT [Name Sensor], COUNT(*) FROM [Data HG] GROUP BY [Name Sensor]
									HAVING [Name Sensor] = 'MUC_NUOC_BKT' --Chia theo tên rồi đếm

--11. Cập nhật tất cả gía trị mới tại tên bằng CB0001HG
UPDATE [Data HG] SET ValueSensor = 20, Times = GETDATE()
			WHERE [Name Sensor] = 'CB0001HG'; --Các sensor CB0001HG có giá trị mới là 20