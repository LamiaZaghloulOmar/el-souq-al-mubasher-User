import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/helper/cacheHelper.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:efood_multivendor/view/screens/home/all_image_screen.dart';
import 'package:efood_multivendor/view/screens/posts/post_comments.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../controller/auth_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../util/app_constants.dart';
import '../../base/custom_image.dart';
import '../../base/not_logged_in_screen.dart';

class Post {
  String address;
  int id;
  String status;
  String image;
  String details;
  String serviceId;

  Post({this.address, this.status, this.image, this.details, this.serviceId});

  Post.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    id = json['id'];
    status = json['status'];
    image = json['image'];
    details = json['details'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['id'] = this.id;
    data['status'] = this.status;
    data['image'] = this.image;
    data['details'] = this.details;
    data['service_id'] = this.serviceId;
    return data;
  }
}

class Name {
  String fName;
  String lName;

  Name({this.fName, this.lName});

  Name.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    return data;
  }
} 

class PostScreen extends StatefulWidget {
  const PostScreen({Key key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      Get.find<CategoryController>().getPosts();
      Get.find<UserController>().getUserInfo();
    }
    
    return Scaffold(
      appBar: CustomAppBar(title:  'posts'.tr, isBackButtonExist: true,),
        body: _isLoggedIn
            ? GetBuilder<CategoryController>(builder: (catController) {
                return catController.postsList.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: () async {
                          await catController.getPosts();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.separated(
                            itemBuilder: ((context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                     Container(
                           padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                         decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                                                    borderRadius: BorderRadius.all(
       Radius.circular(10),
      
    ),
                                 
                                    border: Border.all(
                                        width: 0.5,
                                        color: Theme.of(context).primaryColor)),
                        child:  Row(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GetBuilder<UserController>(
                                                  builder: (userController) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Theme.of(context)
                                                            .cardColor),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: ClipOval(
                                      child: CustomImage(
                                    image:userController.userInfoModel.image ==null?'https://www.w3schools.com/howto/img_avatar.png':
                                          '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                                                        '/${(userController.userInfoModel != null) ? userController.userInfoModel.image : ''}',
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  )),
                                  
                                                );
                                              }),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(PostComments(
                                                      id: catController
                                                          .postsList[index]
                                                          .id));
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            catController
                                                                .name[0].lName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,color: Theme.of(context).cardColor)),
                                                        SizedBox(width: 2),
                                                        Text(
                                                            catController
                                                                .name[0].fName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,color: Theme.of(context).cardColor)),
                                                      ],
                                                    ),
                                                    SizedBox(height: 3),
                                                   Container(
                                                    margin: EdgeInsets.only(left: 10,right: 10),
                                                    child: Text(
                                                        'poststutas'.tr + "${catController.postsList[index].status}",
                                                        style: TextStyle(color: Theme.of(context).cardColor,fontSize: 14),)),
                                                    SizedBox(height: 6),
                                                  
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Container(
                                              child: Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Container(
                                                    child: Row(children: [
                                                      PopupMenuButton(
                                                        icon: Icon(
                                                            Icons.more_vert,
                                                            color:
                                                                Colors.black),
                                                        itemBuilder:
                                                            (contextt) => [
                                                          PopupMenuItem(
                                                            onTap: () async {
                                                              print("Tapped");
                                                              print("IDDD + ${catController.postsList[index].id}");
                                                              print(CacheHelper
                                                                        .getData(
                                                                            key:
                                                                                AppConstants.TOKEN));
                                                              http.Response
                                                                  res =
                                                                  await http.post(
                                                                      Uri.parse(
                                                                          "http://elsouqalmubasher.com/api/v1/services/post/delete/${catController.postsList[index].id}"),
                                                                      body: {
                                                                    "token": CacheHelper
                                                                        .getData(
                                                                            key:
                                                                                AppConstants.TOKEN),
                                                                  });
                                                              print(res
                                                                  .statusCode);
                                                              if (res.statusCode ==
                                                                  200) {
                                                                print(
                                                                    "Deleted!");
                                                                await catController
                                                                    .getPosts();
                                                                showCustomSnackBar(
                                                                    "تم الحذف ",
                                                                    isError:
                                                                        false);
                                                              }
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text("مسح"),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ]),
                                                  ))),
                                        ],
                                        )   )]),
                                   
                                  SizedBox(height: 3),
                                   Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                             left:30.0,right: 30,top:10,bottom: 5),
                                                      child: Container(
                                                        child: Text(
                                                            catController
                                                                .postsList[
                                                                    index]
                                                                .details),
                                                      ),
                                                    ),
                                  if (catController.postsList[index].image !=
                                      null)
                                  Center(child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width-50,
                          child:   InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return FullImageScreen(
                                              '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsList[index].image}');
                                        }));
                                      },
                                      child:    Container(
                                // height: 300,
                                 decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
                                 
                                    border: Border.all(
                                        width: 0.5,
                                        color: Theme.of(context).primaryColor),
                                     
                                  ),
                                width: double.infinity,
                                child:ClipRRect(
                                                                                   borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
                                  child:  Image.network(
                                              '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsList[index].image}',
                                              fit: BoxFit.cover),
                                       ) ),
                                      
                                    )))
                                ],
                              );
                            }),
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(thickness: 1),
                            ),
                            itemCount: catController.postsList.length,
                          ),
                        ),
                      )
                    : Center(
                        child: Text('no_Posts'.tr),
                      );
              })
            : NotLoggedInScreen());
  }
}
