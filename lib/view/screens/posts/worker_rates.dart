import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart'; 
import 'package:efood_multivendor/view/screens/home/all_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/splash_controller.dart';
import '../../../util/app_constants.dart';
import '../../base/custom_image.dart';
import '../../base/not_logged_in_screen.dart';

class WorkerRateScreen extends StatefulWidget {
  final serviceId;
  const WorkerRateScreen({Key key, this.serviceId}) : super(key: key);

  @override
  State<WorkerRateScreen> createState() => _WorkerRateScreenState();
}

class _WorkerRateScreenState extends State<WorkerRateScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      Get.find<CategoryController>().getshowserviceReview(widget.serviceId);
    }
    
    return  _isLoggedIn
            ? GetBuilder<CategoryController>(builder: (catController) {
                return   Padding(
                          padding: const EdgeInsets.all(28.0),
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
                           padding: EdgeInsets.only(top: 5,bottom: 5,right: 10,left: 10),
                         decoration: BoxDecoration(
                          // color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all( Radius.circular(10) ),
                  //  border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)
                   ),
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
                                    image:catController.reviewList[index]['service_owner_img'] ==null?'https://www.w3schools.com/howto/img_avatar.png':
                                          '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                                                        '/ ${catController.reviewList[index]['service_owner_img']}',
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
                                                    SizedBox(height: 20,),
                                                    Row(
                                                      children: [
                                                        SizedBox(width: 5,),
                                                        
                                                        Text(
                                                           catController.reviewList[index]['service_owner_name']??"",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,color:  Colors.black)),
                                                      ],
                                                    ),
                                                   
                                                  
                                                  ],
                                                ),
                                            ],
                                          ),
                                         
                                        ],
                                        ),
                                        
                                          ),
                                          ]),

                                   Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                             left:30.0,right: 30  ),
                                                      child: Container(
                                                      child:  RatingBar.builder(
   initialRating:catController.reviewList[index]['rate']==null?5.0: double.parse(catController.reviewList[index]['rate'].toString() ),
   minRating: 1,
   direction: Axis.horizontal,
   itemCount: 5,
   itemSize: 18,
   itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
     size: 5,
   ),
   
   onRatingUpdate: (rating) {
     print(rating);
   },
),
                                                        
                                                      )),  
                                   Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                             left:30.0,right: 30,top:5,bottom: 5),
                                                      child: Container(
                                                        child: Text(
                                                            catController
                                                                .reviewList[
                                                                    index]
                                                                ['comment'],
                                                                style: TextStyle(fontSize: 
                                                                15,height: 1.5),),
                                                      ),
                                                    ),
                               
                                      
                                    

                                   
                                ],
                              ));
                            }),
                            // separatorBuilder: (context, index) => Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Divider(thickness: 1),
                            // ),
                            itemCount: catController.reviewList.length,
                          ),
                        );
                       
              })
            : NotLoggedInScreen();
  }
}
