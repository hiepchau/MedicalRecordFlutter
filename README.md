# MEDICAL RECORD
Medical Record là một ứng dụng hồ sơ sức khỏe điện tử được thực hiện bằng cách sử dụng flutter và firebase firestore. Nó cho phép người dùng tiết kiệm và bảo tồn hồ sơ sức khỏe và lịch sử y tế của họ. Các bác sĩ có thể xác nhận dữ liệu y tế của người dùng thông qua xác thực mã QR. Có một phần riêng cho các nhà tài trợ máu, nơi người dùng có thể tìm thấy các nhà tài trợ máu gần đó theo nhóm máu và chỉnh sửa hồ sơ tài trợ của riêng họ.

## Contributors
- GV hướng dẫn: ThS. Huỳnh Tuấn Anh
- Trần Hữu Trí - 20520327
- Nguyễn Huy Trí Dũng - 20520459
- Châu Đức Hiệp - 20520499
- Trần Nam Khánh - 20520577

## Chức năng
-	Đăng ký, đăng nhập và đăng xuất.
-	Quản lý thông tin cá nhân.
-	Quản lý các chỉ số sức khỏe cá nhân.
-	Tìm kiếm và gọi các user khác.
-	Quản lý và thêm các bệnh án, chẩn đoán.
-	Quản lý thông tin hiến máu.
-	Xem danh sách người hiến máu theo nhóm máu.
-	Xem những người đã hiến máu trên map.
-	Chia sẻ QR về thông tin chỉ số sức khỏe, chẩn đoán cho bác sĩ.
-	Gọi điện số y tế khẩn cấp (115).
-	Với chế độ bác sĩ, bác sĩ có thể theo dõi lịch sử bệnh án, chẩn đoán, chỉ số sức khỏe của người dùng thông qua QR.

## Yêu cầu cài đặt
- Flutter
    - SDK: ">=2.7.0 <3.0.0"
- Database: Firebase
- IDE: Android Studio, IntelliJ IDEA

## Hướng dẫn sử dụng
- Bước 1: Cài đặt đầy đủ phần mềm yêu cầu
- Bước 2: Chạy ứng dụng
- Bước 3: Đăng ký, Đăng nhập và trải nghiệm
- 
>Tài khoản mặc định:
test1@gmail.com||
> password: bo201202

## Ưu điểm
-	Độ tin cậy: Hệ thống có thể kiểm tra dữ liệu nhập vào (ràng buộc dữ liệu) và thông báo các dữ liệu thực thi sai.
-	Dễ sử dụng: Hệ thống được thiết kế với đồ họa của các thành phần giao diện có bố cục hợp lý, phù hợp với thói quen sử dụng chung của người dùng.
-	Hỗ trợ quét mã QR tiện lợi, gọi số khẩn cấp.
-	Tương đối hoàn chỉnh tính năng cơ bản của ứng dụng bệnh án.
-	Áp dụng kiến thức về giao tiếp giữa Client và Sever.

## Hạn chế
-	Về chức năng: chưa đầu tư kinh phí cho server, cloud database còn hạn chế, chưa tối ưa được hết mức hiệu năng từ android dẫn đến còn hạn chế trong UX.
-	Về nội dung: các chức năng cần được mở rộng, phát triển sâu

## Hướng phát triển
-	Thêm các tính năng như: Bảo mật bằng vân tay, thêm các chỉ số như nước uống, quản lý giấc ngủ, calo tiêu thụ, lưu trữ các QR về giấy chứng nhận tiêm chủng các loại vaccine, sức khỏe, BHYT, giao tiếp giữa bác sĩ và người dùng, chẩn đoán các bệnh thông qua các triệu chứng bằng AI.
-	Tối ưu UI, UX.
-	Publish lên Google Play và Apple Store.
-	Hỗ trợ thêm nhiều ngôn ngữ.
-	Nghiên cứu áp dụng AI để gợi ý cho người dùng.
-	Tối ưu việc giao tiếp giữa Client và Sever.
