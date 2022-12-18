import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/response/category_model.dart';
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {
  final CategoryController categoryController;
  CategoryView({@required this.categoryController});
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class All {
  String id;
  List<CategoryModel> arr;
  All(this.id, this.arr);
}

class _CategoryViewState extends State<CategoryView> {
  List<All> all = [];
  int itemSelected=0;
  // List<CategoryModel> al = [];
  List<CategoryModel> subcat = [];
  @override
  void initState() {
    super.initState();
    // widget.categoryController.categoryList.forEach((e) {
    //   getSub(e.id).then((value) {
    //     all.add(All(
    //         e.id.toString(), Get.find<CategoryController>().subCategoryList));
    //   });
    // });
    if (widget.categoryController.categoryList.isNotEmpty) {
      getSub(widget.categoryController.categoryList[0].id).then((value) {
        // all.add(All(
        //     widget.categoryController.categoryList[0].id.toString(), Get.find<CategoryController>().subCategoryList));
        subcat = Get.find<CategoryController>().subCategoryList;
        print(subcat);
      });
    }
  }

  Future getSub(id) async {
    await Get.find<CategoryController>().getSubCategoryList(id.toString());
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    return Column(
      children: [
        // Padding(
        //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //   child: TitleWidget(
        //       title: 'categories'.tr,
        //       onTap: () => Get.toNamed(RouteHelper.getCategoryRoute())),
        // ),
        widget.categoryController.categoryList != null ||
                all.isNotEmpty ||
                all != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                    height: 50,
                    color: Color(0xfffe0235),
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount:
                            widget.categoryController.categoryList.length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          // List<CategoryModel> al = [];
                          // for (var i = 0; i < all.length; i++) {
                          //   if (all[i].id ==
                          //       widget.categoryController.categoryList[index].id
                          //           .toString()) {
                          // al = all[0].arr;
                          // break;
                          // }
                          // }
                          return InkWell(
                              onTap: () {
                                itemSelected=index;
                                getSub(widget.categoryController
                                        .categoryList[index].id)
                                    .then((value) {
                                  print(value);
                                  subcat.clear(); 
                                  subcat = Get.find<CategoryController>()
                                      .subCategoryList;
                                  print(subcat);
                                });
                              },
                              child: Container( 
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  //                   <--- left side
                                  color:itemSelected==index? Colors.white:Colors.transparent,
                                  width:itemSelected==index? 2.0:0,
                                ))),
                                margin: EdgeInsets.only(left: 10, right: 10,bottom: 5,top: 5),
                                // height: 100,
                                // width: 20,
                                child: Center(
                                    child: Text(
                                  widget.categoryController.categoryList[index]
                                      .name,
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                  ),
                                )),
                              ));
                        })))
//                       return Column(
//                         children: [

//                           // SizedBox(
//                           //   child: Column(children: [

//                           //     Stack(
//                           //       alignment: Alignment.topRight,
//                           //       children: [
//                           //         Container(
//                           //           width: MediaQuery.of(context).size.width,
//                           //           height: 130,
//                           //           // decoration: BoxDecoration(
//                           //             // borderRadius: BorderRadius.only(
//                           //             //   topLeft: Radius.circular(
//                           //             //       Dimensions.RADIUS_LARGE),
//                           //             //   topRight: Radius.circular(
//                           //             //       Dimensions.RADIUS_LARGE),
//                           //             // ),
//                           //           // ),
//                           //           child: ClipRRect(
//                           //             // borderRadius: BorderRadius.circular(
//                           //             //     Dimensions.RADIUS_LARGE),
//                           //             child: CustomImage(
//                           //               image:
//                           //                   '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${widget.categoryController.categoryList[index].image}',
//                           //               fit: BoxFit.cover,
//                           //             ),
//                           //           ),
//                           //         ),
//                           //         Padding(
//                           //           padding: const EdgeInsets.all(8.0),
//                           //           child: Text(
//                           //             widget.categoryController
//                           //                 .categoryList[index].name,
//                           //             style: robotoMedium.copyWith(
//                           //                 fontSize: 14, color: Colors.white),
//                           //             maxLines: 2,
//                           //             overflow: TextOverflow.ellipsis,
//                           //             textAlign: TextAlign.center,
//                           //           ),
//                           //         )
//                           //       ],
//                           //     ),
//                           //   ]),
//                           // ),
// // SizedBox(height: 20,),
//                           // Text("خصومات تصل حتي 70% علي كل شئ",style: TextStyle(fontWeight: FontWeight.bold,
//               // fontSize: 18,color: primaryColor),),
// SizedBox(height: 10,),
// Container(
//                                                       height:50,
//                                                       width: MediaQuery.of(context).size.width,
//                                                       color: Color(0xfffe0235),
//                                                   //    child:
//                                                   //  ListView.builder(
//                                                   //   scrollDirection: Axis.horizontal,
//                                                   //   itemCount:1,
//                                                   //    itemBuilder: (context, index) {
//                                                   //     return InkWell(
//                                                   //       onTap: (){
//                                                   //         print(index);
//                                                   //       },
//                                                         child: Container(
//                                                         margin: EdgeInsets.only(bottom: 5),
//                                                         //  decoration: BoxDecoration(
//     //  border: Border(
//     //   bottom: BorderSide( //                   <--- left side
//     //     color:index==0?  Colors.white:Colors.transparent,
//     //     width:index==0? 1.0:0,
//     //   )),
//   // ),
//                                                         padding: EdgeInsets.only(left: 15,right: 15,
//                                                         top: 15),
//                                                         child:Text( widget.categoryController
//                                           .categoryList[index].name,
//                                           textAlign: TextAlign.center,
//                                                         style: TextStyle(fontWeight:
//                                                          FontWeight.bold,fontSize: 16,color: Colors.white),
//                                                          ))
//                                                         //  );
//                                                     //  }
//                                                   //  ),

//                                                     ),

//                           if (al.isNotEmpty)
//                             Padding(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                   // color: Colors.blue.shade600,
//                                   // borderRadius: BorderRadius.only(
//                                   //   bottomRight: Radius.circular(
//                                   //       Dimensions.RADIUS_LARGE),
//                                   //   bottomLeft: Radius.circular(
//                                   //       Dimensions.RADIUS_LARGE),
//                                   // ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 15.0),
//                                   child: GridView.count(
//                                     shrinkWrap: true,
//                                     crossAxisCount: 4,
//                                     padding: EdgeInsets.all(0),
//                                     // childAspectRatio: 1 / 1.3,
//                                     physics: NeverScrollableScrollPhysics(),
//                                     children: List.generate(al.length, (i) {
//                                       return InkWell(
//                                         onTap: () {
//                                           print("CatId + ${al[i].id}");
//                                           Get.toNamed(RouteHelper
//                                               .getCategoryProductRoute(
//                                                   al[i].id, al[i].name));
//                                         },
//                                         child: Column(
//                                           children: [
//                                             Container(
//                                               padding: EdgeInsets.all(3),
//                                              decoration: BoxDecoration(
//                     color: Colors.white,
//                      border: Border.all(color: Color(0xfffe0235)),
//                     borderRadius:
//                         BorderRadius.circular(50),
//                   ),
//                                                 // radius: 29,
//                                                 // backgroundColor: Colors.white,
//                                                 child: Container(
//                                               padding: EdgeInsets.all(3),
//                                              decoration: BoxDecoration(
//                     color: Color(0xfffe0235),
//                      border: Border.all(color: Color(0xfffe0235)),
//                     borderRadius:
//                         BorderRadius.circular(50),
//                   ),
//                                                 // radius: 29,
//                                                 // backgroundColor: Colors.white,
//                                                 child: CircleAvatar(
//                                                 radius: 27,
//                                                 backgroundImage: NetworkImage(
//                                                     '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${al[i].image}',

//                                                     )),
//                                             )),
//                                              SizedBox(height: 10,),
//                                               Text(al[i].name,
//                                               style: TextStyle(color: Colors.black),),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           if (al.isEmpty)
//                             SizedBox(
//                               height: 15,
//                             )
//                         ],
//                       );
            //   },
            // ),
            // ),
            // )
            : CategoryShimmer(categoryController: widget.categoryController),

        //////////////////////////////////////////
        if (subcat.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              // height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  // color: Colors.blue.shade600,
                  // borderRadius: BorderRadius.only(
                  //   bottomRight: Radius.circular(
                  //       Dimensions.RADIUS_LARGE),
                  //   bottomLeft: Radius.circular(
                  //       Dimensions.RADIUS_LARGE),
                  // ),
                  ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  padding: EdgeInsets.all(0),
                  // childAspectRatio: 1 / 1.3,
                  physics: NeverScrollableScrollPhysics(),
                  children: List.generate(subcat.length, (i) {
                    return InkWell(
                      onTap: () {
                        print("CatId + ${subcat[i].id}");
                        Get.toNamed(RouteHelper.getCategoryProductRoute(
                            subcat[i].id, subcat[i].name));
                      },
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xfffe0235)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              // radius: 29,
                              // backgroundColor: Colors.white,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  color: Color(0xfffe0235),
                                  border: Border.all(color: Color(0xfffe0235)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                // radius: 29,
                                // backgroundColor: Colors.white,
                                child: CircleAvatar(
                                    radius: 27,
                                    backgroundImage: NetworkImage(
                                      '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${subcat[i].image}',
                                    )),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            subcat[i].name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        if (subcat.isEmpty)
          SizedBox(
            height: 15,
          ),

        /////////////////////////////////////////////

        SizedBox(
          child: Column(children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 130,
                  // decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(
                  //       Dimensions.RADIUS_LARGE),
                  //   topRight: Radius.circular(
                  //       Dimensions.RADIUS_LARGE),
                  // ),
                  // ),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(
                    //     Dimensions.RADIUS_LARGE),
                    child: CustomImage(
                      image:
                          'https://k.nooncdn.com/cms/pages/20220608/1abd91998e53cd7e35fc3de720671422/en_mb-banner-02a.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // )
              ],
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "خصومات تصل حتي 70% علي كل شئ",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: primaryColor),
        ),
        SizedBox(
          height: 20,
        ),

        Divider(),
        Text(
          "المنتجات الاكثر مشاهدة",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Container(
            height: 300,
            // color: Colors.red,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width / 2.1,
                    color: Colors.white,
                    margin: EdgeInsets.all(5),
                    child: Column(children: [
                      Container(
                        height: 180,
                        // color: Colors.black,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://z.nooncdn.com/products/tr:n-t_240/v1668154732/N43087236V_1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        // child: Image.network('https://z.nooncdn.com/products/tr:n-t_240/v1668154732/N43087236V_1.jpg',
                        // fit: BoxFit.cover,)
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ثريدز باي اجوني",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text("فستان متوسط متوسط "),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("250 \$"),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "250 \$",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ]),
                  );
                })),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Shimmer(
              duration: Duration(seconds: 2),
              enabled: categoryController.categoryList == null,
              child: Column(children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  ),
                ),
                SizedBox(height: 5),
                Container(height: 10, width: 50, color: Colors.grey[300]),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryAllShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: categoryController.categoryList == null,
          child: Column(children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}

List mainCatItems = ['ادوات منزلية', 'موبيلات', 'الالكترونيات'];
