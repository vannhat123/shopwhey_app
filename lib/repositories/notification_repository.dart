import 'package:shopwhey_app_2022/models/models.dart';

class NotificationRepository {
  NotificationRepository._privateConstructor();

  static final NotificationRepository instance = NotificationRepository
      ._privateConstructor();

  Future<List<Notifi>> getNotifi({required int x}) {
    return Future.delayed(const Duration(microseconds: 5000), (){
        if(x ==-22){
          return Future.error("Cannot get data from Server");
        }

        return Future.value([
          Notifi(
              id: 1,
              url: 'assets/images/Monkey-D-Luffy-Profile-Picture-For-Whatsaap.jpg',
              title: "Đã chuyển tới 50\$"),

        ]);
        }
    );
  }

}