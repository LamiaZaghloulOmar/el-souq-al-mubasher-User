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

class WorkerWorkScreen extends StatefulWidget {
  final serviceId;
  const WorkerWorkScreen({Key key, this.serviceId}) : super(key: key);

  @override
  State<WorkerWorkScreen> createState() => _WorkerWorkScreenState();
}

class _WorkerWorkScreenState extends State<WorkerWorkScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      Get.find<CategoryController>().getserviceorders(widget.serviceId);
    }
    
    return  _isLoggedIn
            ? GetBuilder<CategoryController>(builder: (catController) {
                return   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: ((context, index) {
                              return Container( 
                                margin: EdgeInsets.only(bottom: 15),
                                decoration:BoxDecoration(
                  borderRadius: BorderRadius.all( Radius.circular(10) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)) ,
                                child:
                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                     Container(
                           padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                         decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all( Radius.circular(10) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)),
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
                                           
                                          catController.nameW.isEmpty?Container():  Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                            catController
                                                                .nameW[0].lName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,color: Theme.of(context).cardColor)),
                                                        SizedBox(width: 2),
                                                        Text(
                                                            catController
                                                                .nameW[0].fName,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,color: Theme.of(context).cardColor)),
                                                      ],
                                                    ),
                                                    SizedBox(height: 5),
                                                   Container(
                                                    margin: EdgeInsets.only(left: 10,right: 10),
                                                    child: Text(
                                                        'poststutas'.tr + "${catController.postsByWorkerList[index].status}",
                                                        style: TextStyle(color: Theme.of(context).cardColor,fontSize: 14),)),
                                                    SizedBox(height: 6),
                                                  
                                                  ],
                                                ),
                                            ],
                                          ),
                                         
                                        ],
                                        ),
                                        
                                          ),
                                          ]),
                                   
                                  SizedBox(height: 3),
                                   Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                             left:30.0,right: 30,top:10,bottom: 5),
                                                      child: Container(
                                                        child: Text(
                                                            catController
                                                                .postsByWorkerList[
                                                                    index]
                                                                .details,
                                                                style: TextStyle(fontSize: 
                                                                15,height: 1.5),),
                                                      ),
                                                    ),
                                  if (catController.postsByWorkerList[index].image !=
                                      null)
                                  Center(child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width-50,
                          child:   InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) {
                                          return FullImageScreen(
                                              '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsByWorkerList[index].image}');
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
                                              '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsByWorkerList[index].image}',
                                              fit: BoxFit.cover),
                                       ) ),
                                      
                                    ))),

                                   
                                ],
                              ));
                            }),
                            // separatorBuilder: (context, index) => Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Divider(thickness: 1),
                            // ),
                            itemCount: catController.postsByWorkerList.length,
                          ),
                        );
                       
              })
            : NotLoggedInScreen();
  }
}
