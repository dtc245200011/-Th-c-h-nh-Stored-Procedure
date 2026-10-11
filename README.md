# Thực hành Stored Procedure - classicmodels

## Mục tiêu
Tạo và gọi stored procedures mẫu trên bảng `customers`.

## Hướng dẫn nhanh
1. Import database classicmodels.
2. Chạy: mysql -u user -p classicmodels < sql/create_procedures.sql
3. Kiểm tra bằng: mysql -u user -p classicmodels < sql/test_calls.sql
4. Xóa procedures: mysql -u user -p classicmodels < sql/drop_procedures.sql

## Lưu ý
- Dùng `DELIMITER` khi tạo procedure.
- Kiểm tra quyền: cần quyền CREATE ROUTINE / ALTER ROUTINE.
