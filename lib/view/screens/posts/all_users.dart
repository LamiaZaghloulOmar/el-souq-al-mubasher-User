import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efood_multivendor/helper/cacheHelper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:efood_multivendor/view/screens/posts/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({Key key}) : super(key: key);

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("UserId + ${CacheHelper.getData(key: "UserId")}");
    getAllUsers();
  }

  List users = [];
  getAllUsers() async {
    await FirebaseFirestore.instance.collection(CacheHelper.getData(key: "UserId")).get().then((value) {
      print("Length + ${value.docs.length}");
      value.docs.forEach((element) {
        setState(() {
          users.add(element);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Chats"),
      body: users.isEmpty
          ? Center(
              child: Text("No Messages"),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          Get.to(ChatScreen(
                            name: users[index]["ServiceName"],
                            image: users[index]["ServiceImage"],
                            ServiceId: users[index]["ServiceProviderId"],
                            UserId: CacheHelper.getData(key: "UserId"),
                            
                            NotfromAll: false,
                          ));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                ClipOval(
                                    child: CustomImage(
                                  image:
                                      "${AppConstants.BASE_URL}/storage/app/public/delivery-man/${users[index]["ServiceImage"]}",
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  users[index]["ServiceName"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              color: Colors.black,
                              thickness: 0.5,
                              height: 1,
                              indent: 20,
                              endIndent: 20,
                            )
                          ],
                        ),
                      )),
            ),
    );
  }
}
