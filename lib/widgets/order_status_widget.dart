import 'package:hommie/core/app_export.dart';
Widget orderStatusWidget(String status){
  if(status == "Chờ Xử Lý"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.blueAccent,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else if(status == "Đang Đóng Gói"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.yellow,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else if(status == "Đang Vận Chuyển"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.indigoAccent,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else if(status == "Hoàn Thành"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.greenAccent,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else if(status == "Hủy Đơn Hàng"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.redAccent,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else{
    return const SizedBox();
  }
}