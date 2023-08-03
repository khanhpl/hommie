import 'package:hommie/core/app_export.dart';
Widget itemStatusWidget(String status){
  if(status == "Còn Hàng"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.green,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );
  }else if(status == "Tạm Hết Hàng"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.orangeAccent,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );

  }else if(status == "Ngừng Kinh Doanh"){
    return Text(
      status,
      maxLines: null,
      style: TextStyle(
        color: Colors.blueGrey,
        fontSize: size.height * 0.018,
        fontWeight: FontWeight.w400,
      ),
    );

  }else{
    return const SizedBox();
  }
}