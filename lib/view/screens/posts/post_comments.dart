import 'dart:convert';

import 'package:efood_multivendor/helper/cacheHelper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/custom_button.dart';
import 'package:efood_multivendor/view/screens/posts/chat_screen.dart';
import 'package:efood_multivendor/view/screens/posts/posts_req_offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../base/custom_image.dart';

class PostComent {
  int id;
  String price;
  String userFname;
  String userLname;
  String userId;
  String comment;
  String image;
  String orderId;
  String createdAt;
  String updatedAt;

  PostComent(
      {this.id,
      this.userFname,
      this.userLname,
      this.userId,
      this.comment,
      this.image,
      this.orderId,
      this.createdAt,
      this.updatedAt,
      this.price});

  PostComent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    userFname = json['user_fname'];
    userLname = json['user_lname'];
    userId = json['user_id'];
    comment = json['comment'];
    image = json['image'];
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['user_fname'] = this.userFname;
    data['user_lname'] = this.userLname;
    data['user_id'] = this.userId;
    data['comment'] = this.comment;
    data['image'] = this.image;
    data['order_id'] = this.orderId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class PostComments extends StatefulWidget {
  int id;
  PostComments({Key key, @required this.id}) : super(key: key);
  List<PostComent> postComments = [];
  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  @override
  void initState() {
    getComments(widget.id);
    super.initState();
  }

  void getComments(id) async {
    widget.postComments = [];
    await http
        .get(Uri.parse(
            "${AppConstants.BASE_URL}${AppConstants.POST_COMMENTS}/${id.toString()}"))
        .then((value) {
      print(value.body);
      jsonDecode(value.body)[0].forEach((e) {
        setState(() {
          widget.postComments.add(PostComent.fromJson(e));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "العروض المقدمة",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await getComments(widget.id);
          },
          child: widget.postComments.isEmpty
              ? Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.comments_disabled_rounded, size: 30),
                        Text("لا يوجد تعليقات حتي الأن",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ]),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemBuilder: ((context, index) {
                      return Container(
                                margin: EdgeInsets.only(bottom: 15),
                                decoration:BoxDecoration(
                           
                  borderRadius: BorderRadius.all( Radius.circular(10) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)) ,
                                child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Container(
                           padding: EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
                         decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all( Radius.circular(10) ),
                   border: Border.all( width: 0.5,color: Theme.of(context).primaryColor)),
                        child:  Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).cardColor),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: widget.postComments[index].image.isEmpty
                                    ? Icon(Icons.person)
                                    : ClipOval(
                                        child: CustomImage(
                                        image:
                                            "${AppConstants.BASE_URL}/storage/app/public/delivery-man/${widget.postComments[index].image}",
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      )),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Text(widget.postComments[index].userLname,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,color: Colors.white)),
                                      SizedBox(width: 2),
                                      Text(widget.postComments[index].userFname,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,color: Colors.white)),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  // Text(
                                  //     "Post is ${catController.postsList[index].status}"),
                                ],
                              ),
                            ],
                          )),
                          SizedBox(height: 3),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 1,right: 1),
                                    // width:
                                    //     MediaQuery.of(context).size.width - 100,
                                    child: Text(
                                        widget.postComments[index].comment)),
                                        Spacer(),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          "${widget.postComments[index].price.toString()} ريال",
                                          style:
                                              TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          // if (catController.postsList[index].image != null)
                          //   InkWell(
                          //     onTap: () {
                          //       Navigator.push(context,
                          //           MaterialPageRoute(builder: (_) {
                          //         return FullImageScreen(
                          //             '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsList[index].image}');
                          //       }));
                          //     },
                          //     child: Hero(
                          //       tag: 'imageHero',
                          //       child: Container(
                          //         height: 300,
                          //         width: double.infinity,
                          //         child: Image.network(
                          //             '${AppConstants.BASE_URL}/storage/app/public/serviceorder/${catController.postsList[index].image}',
                          //             fit: BoxFit.contain),
                          //       ),
                          //     ),
                          //   )
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 0.0),
                            child: CustomButton(
                                buttonText: "تواصل الأن",
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WorkerInfoForService()
                                          // ChatScreen(
                                          //       name:
                                          //           "${widget.postComments[index].userFname} ${widget.postComments[index].userLname}",
                                          //       UserId: CacheHelper.getData(
                                          //           key: "UserId"),
                                          //       ServiceId: widget
                                          //           .postComments[index].userId,
                                          //       image: widget
                                          //           .postComments[index].image,
                                          //       NotfromAll: true,
                                          //     )
                                              ));
                                }),
                          ),
                        ],
                      ));
                    }),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      // child: Divider(thickness: 1),
                    ),
                    itemCount: widget.postComments.length,
                  ),
                ),
        ));
  }
}
