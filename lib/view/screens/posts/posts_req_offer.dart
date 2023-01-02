import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/base/custom_text_field.dart';
import 'package:efood_multivendor/view/screens/posts/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../helper/cacheHelper.dart';
import '../../base/custom_app_bar.dart';

class WorkerInfoForService extends StatefulWidget {
  final String serviceId,orderid,name,image;
  const WorkerInfoForService({Key key, this.serviceId, this.orderid, this.name, this.image}) : super(key: key);

  @override
  State<WorkerInfoForService> createState() => _WorkerInfoForServiceState();
}

class _WorkerInfoForServiceState extends State<WorkerInfoForService> {
  
  int indexSelected=0;
  final TextEditingController _commnetController = TextEditingController();
 double rate=1;
  @override
  Widget build(BuildContext context) {
     bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

    if (_isLoggedIn) {
      // Get.find<CategoryController>().getserviceorders(widget.serviceId);
      // Get.find<CategoryController>().getshowserviceReview(widget.serviceId);
      // Get.find<CategoryController>().completMyOrder(widget.orderid);
    }
    
    return SafeArea(child:Scaffold(
      
      appBar:CustomAppBar(
          title: "مراسلة",
        ),
      body:Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.only(left:5,right: 5,top: 15,bottom: 15),
           decoration:BoxDecoration(
            color: Colors.white,
                  borderRadius: BorderRadius.all( Radius.circular(5) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)) ,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
      //    InkWell(
      //     onTap: (){
      //       setState(() {
      //         indexSelected=0;
      //       });
      //     },
      //     child:Container(child: Text("الاتجاه",textAlign: TextAlign.center,
      //     style: TextStyle(  color: indexSelected==0?Colors.white:Colors.black,),),
      //     padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      //      decoration:BoxDecoration(
      //         color: indexSelected==0?primaryColor:Colors.white,
      //       border: Border(
      // left: BorderSide( //                   <--- left side
      //   color: Colors.black,
      //   width: 0.5,
      // ),
      //       ))
      //     )),
      //     // Spacer(),
           InkWell(
          onTap: (){
            setState(() {
              indexSelected=1;
            });
          },
          child:Container(child: Text("الاعمال",textAlign: TextAlign.center,
          style: TextStyle(  color: indexSelected==1?Colors.white:Colors.black,),),
           padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
           decoration:BoxDecoration(
              color: indexSelected==1?primaryColor:Colors.white,
            border: Border(
      left: BorderSide( //                   <--- left side
        color: Colors.black,
        width: 0.5,
      ),
            )))),
          // Spacer(),

          InkWell(
          onTap: (){
            setState(() {
              indexSelected=2;
            });
          },
          child: Container(child: Text("التقيمات",textAlign: TextAlign.center,
          style: TextStyle(  color: indexSelected==2?Colors.white:Colors.black,),),
           padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
           decoration:BoxDecoration(
              color: indexSelected==2?primaryColor:Colors.white,
            border: Border(
      left: BorderSide( //                   <--- left side
        color: Colors.black,
        width: 0.5,
      ),
            )))),
          // Spacer(),

       

              InkWell(
             onTap: (){
            setState(() {
              indexSelected=3;
            });
      showDialog(context: context, builder: (BuildContext context) {
            return Dialog(
      shape: RoundedRectangleBorder(borderRadius: 
      BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL))),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:  SizedBox(
        width: 600,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20,),
              Text("تقييم مقدم الخدمة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Divider(),

              RatingBar.builder(
   initialRating: rate,
   minRating: 1,
   direction: Axis.horizontal,
   itemCount: 5,
   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => Icon(
     Icons.star,
     color: Colors.amber,
     size: 20,
   ),
   onRatingUpdate: (rating) {
     print(rating);
     rate=rating;
   },
),
              SizedBox(height: 20,),
Container(
  margin: EdgeInsets.only(left: 20,right: 20),
  decoration:BoxDecoration(
     border: Border.all(
      width: 0.5,
      color: Colors.grey
      ) ),
  child:CustomTextField(
     
                          hintText: 'اكتب تعليق',
                          controller: _commnetController,
                          inputType: TextInputType.name,
                          capitalization: TextCapitalization.words,
                          divider: true,
                          maxLines: 4,
                        )),
              SizedBox(height: 20,),
CustomButton(
  width: MediaQuery.of(context).size.width/2,
                              buttonText: 'save'.tr,
                              onPressed:  (){
                                if(_commnetController.text=='')_commnetController.text='.';
                                  Get.find<CategoryController>().addrateForWorker(widget.serviceId,
              CacheHelper.getData(key: "UserId"),
              widget.orderid,rate,_commnetController.text);
              navigator.pop(context);
                              },
                            ),
              SizedBox(height: 20,),


              
            ]))));
      });
           
          },
         
          child: Container(child: Text("تقييم العامل",textAlign: TextAlign.center,
          style: TextStyle(  color: indexSelected==3?Colors.white:Colors.black,),),
           padding: EdgeInsets.only( top: 15,bottom: 15,left: 15,right: 15),
           decoration:BoxDecoration(
              color: indexSelected==3?primaryColor:Colors.white,
            border: Border(
      left: BorderSide( //                   <--- left side
        color: Colors.black,
        width: 0.5,
      ),
            )))),

   InkWell(
          onTap: (){
            setState(() {
              indexSelected=4;
            });
     
     
 
             
                        
  Get.find<CategoryController>().completMyOrder(widget.orderid);
                             
                            
           
           
          },
          child: Container(
            color: indexSelected==4?primaryColor:Colors.white,
            child: Text("اكمال الطلب",textAlign: TextAlign.center,
            style: TextStyle(  color: indexSelected==4?Colors.white:Colors.black,),),
           padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
   
            )),
        ]),)
      ]) ,
    
    floatingActionButton:Center(child:Container(
      width: MediaQuery.of(context).size.width/1.5,
      child:CustomButton(
                                buttonText: "تواصل الأن",
                                onPressed: ()  {

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen(
                                                name:
                                                    widget.name,
                                                UserId: CacheHelper.getData(
                                                    key: "UserId"),
                                                ServiceId: widget
                                                    .serviceId,
                                                image: widget.image,
                                                NotfromAll: true,
                                              )));
                                }))),
    ));
    
  }
 
}