import 'package:flutter/material.dart';
import 'package:shopwhey_app_2022/constants/constants.dart';
import 'package:shopwhey_app_2022/repositories/notification_repository.dart';
import 'package:shopwhey_app_2022/repositories/rest_api_notifi.dart';
import 'package:http/http.dart' as http;
import '../../models/models.dart';

class Notification1 extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification1> {
  bool _isLoading = false;
  List<Notifi> _notifi = [];
  String _errorMessage = '';
  RestApiNotifi restApiNotifi = RestApiNotifi();

  @override
  void initState() {
    super.initState();
    NotificationRepository.instance.getNotifi(x: 1).then((responseStudents) {
      setState(() {
        _notifi = responseStudents;
        _isLoading = false;
      });
    }).catchError((errorDetail) {
      //Bam Camping => this code will run ? navigation lesson
      setState(() {
        _notifi = [];
        _isLoading = false;
        _errorMessage = errorDetail;
        //alert(context: context, title: 'Error', content: _errorMessage);
      });
    }); //async
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
          child: Container(
              width: getWidth(812),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        searchField(context),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'You can check your \n notification here',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Expanded(
                    flex: 7,
                    child: FutureBuilder<List<Notifi>>(
                        future: restApiNotifi.fetchPhotos(http.Client()),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('An error has occurred!'),
                            );
                          } else if (snapshot.hasData) {
                            return NotifiListItem(
                              notifis: snapshot.data!,
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))
              ]))),
    );
  }

  Widget searchField(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: getWidth(812),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const TextField(
        style: TextStyle(
            color: MyColors.primary, fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.indigoAccent,
            size: 25,
          ),
        ),
      ),
    );
  }
}

class NotifiListItem extends StatelessWidget {
  final List<Notifi> notifis; //not null
  NotifiListItem({
    super.key,
    required this.notifis,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child:  Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        // child: Container(
                        //   height: 50,
                        //   width: 50,
                        //   color: Colors.red,
                        //   child: Text("Nhat"),
                        // ),
                        child: Image.network(
                          "http://3.bp.blogspot.com/-j1KNJXnh5sQ/UuLoNL4vIlI/AAAAAAAAAFw/ImDXSaPEGGg/s1600/roronoa+zoro.jpg" ,
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Container(
                        margin: const EdgeInsets.only(top: 5, left: 5),
                        width: getWidth(235),
                        child: Text(
                          "Notifi: ${notifis[index].title}",
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style:
                          const TextStyle(color: Colors.indigoAccent),
                        ))
                  ],
                ),
              ],
            ),
            // child: ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: [
            //     Row(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             ClipRRect(
            //               borderRadius: BorderRadius.circular(40),
            //               child: Image.network(
            //                 notifis[index].url,
            //                 width: 50.0,
            //                 height: 50.0,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //             Container(
            //                 margin: EdgeInsets.only(top: 5, left: 5),
            //                 width: getWidth(235),
            //                 child: Container(
            //                   child: Text(
            //                     "Notifi: ${notifis[index].title}",
            //                     overflow: TextOverflow.fade,
            //                     maxLines: 2,
            //                     style:
            //                         const TextStyle(color: Colors.indigoAccent),
            //                   ),
            //                 ))
            //           ],
            //         ),
            //         const SizedBox(width: 10),
            //       ],
            //     )
            //   ],
            // ));
        );
      },
    );
  }
}
