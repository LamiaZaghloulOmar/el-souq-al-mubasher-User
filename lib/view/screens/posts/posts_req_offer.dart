import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../base/custom_app_bar.dart';

class WorkerInfoForService extends StatefulWidget {
  const WorkerInfoForService({Key key}) : super(key: key);

  @override
  State<WorkerInfoForService> createState() => _WorkerInfoForServiceState();
}

class _WorkerInfoForServiceState extends State<WorkerInfoForService> {
  
  int indexSelected=0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      
      appBar:CustomAppBar(
          title: "مراسلة",
        ),
      body:Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          // padding: EdgeInsets.only(left:5,right: 5,top: 15,bottom: 15),
           decoration:BoxDecoration(
                  borderRadius: BorderRadius.all( Radius.circular(5) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)) ,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
         InkWell(
          onTap: (){
            setState(() {
              indexSelected=0;
            });
          },
          child:Container(child: Text("الاتجاه",textAlign: TextAlign.center,
          style: TextStyle(  color: indexSelected==0?Colors.white:Colors.black,),),
          padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
           decoration:BoxDecoration(
              color: indexSelected==0?primaryColor:Colors.white,
            border: Border(
      left: BorderSide( //                   <--- left side
        color: Colors.black,
        width: 0.5,
      ),
            ))
          )),
          // Spacer(),
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
          },
          child: Container(
            color: indexSelected==3?primaryColor:Colors.white,
            child: Text("اكمال الطلب",textAlign: TextAlign.center,
            style: TextStyle(  color: indexSelected==3?Colors.white:Colors.black,),),
           padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
      //      decoration:BoxDecoration(
      //       border: Border(
      // left: BorderSide( //                   <--- left side
      //   color: Colors.black,
      //   width: 0.5,
      // ),
            // )
            // )
            )),
        ]),)
      ]) ,
    
    floatingActionButton: CustomButton(
                                buttonText: "تواصل الأن",
                                onPressed: ()  {}),
    ));
    
  }
}