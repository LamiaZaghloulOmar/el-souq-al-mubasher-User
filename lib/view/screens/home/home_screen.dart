import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/banner_controller.dart';
import 'package:efood_multivendor/controller/campaign_controller.dart';
import 'package:efood_multivendor/controller/category_controller.dart';
import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/controller/notification_controller.dart';
import 'package:efood_multivendor/controller/product_controller.dart';
import 'package:efood_multivendor/controller/restaurant_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/controller/user_controller.dart';
import 'package:efood_multivendor/data/model/response/config_model.dart';
import 'package:efood_multivendor/helper/responsive_helper.dart'; 
import 'package:efood_multivendor/helper/route_helper.dart';
import 'package:efood_multivendor/util/app_constants.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/web_menu_bar.dart';
import 'package:efood_multivendor/view/screens/home/advertise_screen.dart';
import 'package:efood_multivendor/view/screens/home/web_home_screen.dart';
import 'package:efood_multivendor/view/screens/home/widget/banner_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/category_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/popular_food_view.dart';
import 'package:efood_multivendor/view/screens/home/widget/popular_restaurant_view.dart';
import 'package:efood_multivendor/view/screens/posts/all_users.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../base/custom_image.dart';
import '../posts/post_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    Get.find<BannerController>().getBannerList(reload);
    Get.find<CategoryController>().getCategoryList(reload);
    Get.find<CategoryController>().getServices();
    Get.find<RestaurantController>()
        .getPopularRestaurantList(reload, 'all', false);
    Get.find<CampaignController>().getItemCampaignList(reload);
    Get.find<ProductController>().getPopularProductList(reload, 'all', false);
    Get.find<RestaurantController>()
        .getLatestRestaurantList(reload, 'all', false);
    Get.find<ProductController>().getReviewedProductList(reload, 'all', false);
    Get.find<RestaurantController>().getRestaurantList('1', reload);
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  ConfigModel _configModel = Get.find<SplashController>().configModel;

  @override
  void initState() {
    super.initState();
    print(
        "ImgUrl + ${Get.find<SplashController>().configModel.baseUrls.campaignImageUrl}");
    HomeScreen.loadData(false);
  }
int selectServ=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      backgroundColor: ResponsiveHelper.isDesktop(context)
          ? Theme.of(context).cardColor
          : null,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await Get.find<BannerController>().getBannerList(true);
            await Get.find<CategoryController>().getCategoryList(true);
            await Get.find<RestaurantController>()
                .getPopularRestaurantList(true, 'all', false);
            await Get.find<CampaignController>().getItemCampaignList(true);
            await Get.find<ProductController>()
                .getPopularProductList(true, 'all', false);
            await Get.find<RestaurantController>()
                .getLatestRestaurantList(true, 'all', false);
            await Get.find<ProductController>()
                .getReviewedProductList(true, 'all', false);
            await Get.find<RestaurantController>().getRestaurantList('1', true);
            if (Get.find<AuthController>().isLoggedIn()) {
              await Get.find<UserController>().getUserInfo();
              await Get.find<NotificationController>()
                  .getNotificationList(true);
            }
          },
          child: ResponsiveHelper.isDesktop(context)
              ? WebHomeScreen(scrollController: _scrollController)
              : CustomScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // App Bar
                    SliverAppBar(
                      floating: true,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      backgroundColor: ResponsiveHelper.isDesktop(context)
                          ? Colors.transparent
                          : Colors.white,
                      title: Center(
                          child: Container(
                        width: Dimensions.WEB_MAX_WIDTH,
                        // height: 50,
                        color: Colors.white,
                        child: Row(children: [
                          Expanded(
                              child: InkWell(
                            onTap: () => Get.toNamed(
                                RouteHelper.getAccessLocationRoute('home')),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Dimensions.PADDING_SIZE_SMALL,
                                horizontal: ResponsiveHelper.isDesktop(context)
                                    ? Dimensions.PADDING_SIZE_SMALL
                                    : 0,
                              ),
                              child: GetBuilder<LocationController>(
                                  builder: (locationController) {
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      child: Container(
                                        // decoration: BoxDecoration(
                                            // color: Colors.black,
                                            // borderRadius:
                                            //     BorderRadius.circular(10)),
                                        child:
                                         Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 5),
                                          child:Image.asset('assets/image/add.png',
                                          color: Colors.black,
                                          width: 22,height: 22,),
                                          //  Icon(
                                          //   Icons.post_add_outlined,
                                          //   size: 22,
                                          //   color: Colors.black,
                                          // ),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(PostScreen());
                                      },
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      // decoration: BoxDecoration(
                                      //     color: Colors.blue.shade200,
                                      //     borderRadius:
                                      //         BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5.0, vertical: 5),
                                        child: Icon(
                                          locationController
                                                      .getUserAddress()
                                                      .addressType ==
                                                  'home'
                                              ? Icons.location_on_sharp
                                              : locationController
                                                          .getUserAddress()
                                                          .addressType ==
                                                      'office'
                                                  ? Icons.work
                                                  : Icons.location_on,
                                          size: 22,
                                          color:Colors.black,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(width: 10),
Spacer(),
                                      Container(
                           
                            child: Image.asset(
                              'assets/image/logo.png',
                              height: 90,
                              // width: 100,
                              // fit: BoxFit.contain,
                              color: primaryColor,
                            )
                          ),
                          Spacer(),
                                    // Flexible(
                                    //   child: Text(
                                    //     locationController
                                    //         .getUserAddress()
                                    //         .address,
                                    //     style: robotoRegular.copyWith(
                                    //       color: Theme.of(context)
                                    //           .textTheme
                                    //           .bodyText1
                                    //           .color,
                                    //       fontSize: Dimensions.fontSizeSmall,
                                    //     ),
                                    //     maxLines: 1,
                                    //     overflow: TextOverflow.ellipsis,
                                    //   ),
                                    // ),
                                    // Icon(Icons.arrow_drop_down,
                                    //     color: Theme.of(context)
                                    //         .textTheme
                                    //         .bodyText1
                                    //         .color),
                                  ],
                                );
                              }),
                            ),
                          )),
                        
                          InkWell(
                            child: Container(
                              
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 5),
                                child: Image.asset('assets/image/chat.png',
                                          color: Colors.black,
                                          width: 22,height: 22,),
                              ),
                            ),
                            onTap: () {
                              Get.to(AllUsersScreen());
                            },
                          ),
                          SizedBox(width: 3),
                          InkWell(
                            child: GetBuilder<NotificationController>(
                                builder: (notificationController) {
                              bool _hasNewNotification = false;
                              if (notificationController.notificationList !=
                                  null) {
                                _hasNewNotification = notificationController
                                        .notificationList.length !=
                                    notificationController
                                        .getSeenNotificationCount();
                              }
                              return Container(
                                
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 5),
                                  child: Stack(children: [
                                    Image.asset('assets/image/notification.png',
                                          color: Colors.black,
                                          width: 22,height: 22,),
                                    _hasNewNotification
                                        ? Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .cardColor),
                                              ),
                                            ))
                                        : SizedBox(),
                                  ]),
                                ),
                              );
                            }),
                            onTap: () =>
                                Get.toNamed(RouteHelper.getNotificationRoute()),
                          ),
                         
                        
                        ]),
                      )),
                    ),

                    // Search Button
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: Center(
                              child: Container(
                        height: 60,
                        width: Dimensions.WEB_MAX_WIDTH,
                        // color: Colors.blue.shade200,
                        padding: EdgeInsets.symmetric(
                          // vertical: 1,
                            horizontal: Dimensions.PADDING_SIZE_SMALL),
                        child: InkWell(
                          onTap: () =>
                              Get.toNamed(RouteHelper.getSearchRoute()),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.PADDING_SIZE_SMALL),
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        Colors.grey[Get.isDarkMode ? 800 : 200],
                                    spreadRadius: 1,
                                    blurRadius: 5)
                              ],
                            ),
                            child: Row(children: [
                              Icon(Icons.search,
                                  size: 25,
                                  color: Theme.of(context).primaryColor),
                              SizedBox(
                                  width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                              Expanded(
                                  child: Text('search_food_or_restaurant'.tr,
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).hintColor,
                                      ))),
                            ]),
                          ),
                        ),
                      ))),
                    ),
 
                   SliverToBoxAdapter(
                      child: Center(
                          child: Container(

                            margin: EdgeInsets.only(top: 15),
                              width: MediaQuery.of(context).size.width ,
                              height: 60,
                              child: Image.asset('assets/image/baner.png',
                              fit: BoxFit.cover,)
                              // color: Colors.teal,
                              ))),
                    SliverToBoxAdapter(
                      child: Center(
                          child: Container( 
                              width: Dimensions.WEB_MAX_WIDTH,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GetBuilder<BannerController>(
                                        builder: (bannerController) {
                                      return bannerController.bannerImageList ==
                                              null
                                          ? BannerView(
                                              bannerController:
                                                  bannerController)
                                          : bannerController
                                                      .bannerImageList.length ==
                                                  0
                                              ? SizedBox()
                                              : BannerView(
                                                  bannerController:
                                                      bannerController);
                                    }),
                                    Container(
                                      // color: Colors.blue.shade200,
                                      // padding: const EdgeInsets.symmetric(
                                          // horizontal: 10.0),
                                      child: GetBuilder<CategoryController>(
                                          builder: (categoryController) {
                                        return categoryController
                                                .services.isEmpty
                                            ? SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10.0),
                                                child: Column(
                                                  children: [
                                                    // Stack(
                                                    //   children: [
                                                    //     Container(
                                                    //       height: 120,
                                                    //       decoration:
                                                    //           BoxDecoration(
                                                    //         borderRadius:
                                                    //             BorderRadius
                                                    //                 .only(
                                                    //           topLeft: Radius
                                                    //               .circular(
                                                    //                   Dimensions
                                                    //                       .RADIUS_LARGE),
                                                    //           topRight: Radius
                                                    //               .circular(
                                                    //                   Dimensions
                                                    //                       .RADIUS_LARGE),
                                                    //         ),
                                                            
                                                    //       ),
                                                    //       child: ClipRRect(
                                                    //           borderRadius:
                                                    //               BorderRadius.circular(
                                                    //                   Dimensions
                                                    //                       .RADIUS_LARGE),
                                                    //           child: Image.asset(
                                                    //               "assets/image/services.png",fit: BoxFit.cover,)),
                                                    //     ),
                                                    //     Padding(
                                                    //       padding:
                                                    //           const EdgeInsets
                                                    //               .all(8.0),
                                                    //       child: Text(
                                                    //         "قسم الخدمات",
                                                    //         style: robotoMedium
                                                    //             .copyWith(
                                                    //                 fontSize:
                                                    //                     14,
                                                    //                 color: Colors
                                                    //                     .white),
                                                    //         maxLines: 2,
                                                    //         overflow:
                                                    //             TextOverflow
                                                    //                 .ellipsis,
                                                    //         textAlign: TextAlign
                                                    //             .center,
                                                    //       ),
                                                    //     )
                                                    //   ],
                                                    // ),
                                                    SizedBox(height: 10,), 
                                                     
                                                    Container(
                                                      height:50,
                                                      width: MediaQuery.of(context).size.width,
                                                      color: primaryColor,
                                                     child: 
                                                   ListView.builder(
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount:5,
                                                     itemBuilder: (context, index) {
                                                      return InkWell(
                                                        onTap: (){
                                                          print(index);
                                                          setState(() {
                                                            selectServ=index;
                                                          });
                                                          
                                                        },
                                                        child: Container(
                                                        margin: EdgeInsets.only(bottom: 5),
                                                         decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                  //                   <--- left side
                                  color: selectServ == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: selectServ == index ? 2.0 : 0,
                                ))),
                                                        padding: EdgeInsets.only(left: 15,right: 15,
                                                        top: 15),
                                                        child:Text('الخدمات',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(fontWeight:
                                                         FontWeight.bold,fontSize: 16,color: Colors.white),
                                                         )
                                                     
                                                   ),);})
                                                       
                                                    ),
                                                      //  SizedBox(height: 30,),

                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight: Radius
                                                              .circular(Dimensions
                                                                  .RADIUS_LARGE),
                                                          bottomLeft: Radius
                                                              .circular(Dimensions
                                                                  .RADIUS_LARGE),
                                                        ),
                                            
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GridView.builder(
                                                          physics:
                                                              NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          gridDelegate:
                                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount:
                                                                ResponsiveHelper
                                                                        .isMobile(
                                                                            context)
                                                                    ? 4
                                                                    : 4,
                                                            crossAxisSpacing:
                                                                10,
                                                            mainAxisSpacing: 10,
                                                            childAspectRatio:
                                                                (1 / 1.5),
                                                          ),

                                                          // separatorBuilder:
                                                          //     (context, index) =>
                                                          //         SizedBox(width: 10),
                                                          itemCount: Get.find<
                                                                  CategoryController>()
                                                              .services
                                                              .length,

                                                          itemBuilder: (context,
                                                                  index) =>
                                                              InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                  AdvertiseScreen(
                                                                title: Get.find<
                                                                        CategoryController>()
                                                                    .services[
                                                                        index]
                                                                    .name,
                                                                serviceId: Get.find<
                                                                        CategoryController>()
                                                                    .services[
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ));
                                                            },
                                                            child:Container(
                                                              
                                                                decoration: BoxDecoration(
                                            color: Colors.white,
                                              border: Border.all(color: primaryColor,width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                                              child:  Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: 90,
                                                              decoration: BoxDecoration(
                                            color: Colors.white,
                                            
                                            borderRadius:
                                                BorderRadius.circular(18)),
                                                                  padding: EdgeInsets.only(left: 3,right: 3,top: 5,),
                                                                  child:  
                                                                ClipRRect(
                                                                   borderRadius: BorderRadius.circular(18.0),
                                                                    child: SizedBox.fromSize(
      // size: Size.fromRadius(48),
                                                                      child:  Image.network(
                                                                            '${AppConstants.BASE_URL}/storage/app/public/service/${Get.find<CategoryController>().services[index].image}',
                                                                            fit: BoxFit.cover
                                                                            //  height: 80,
                                                                      )
                                                                            ))),
                                                                            SizedBox(height: 5,),
                                                                Text(Get.find<
                                                                        CategoryController>()
                                                                    .services[
                                                                        index]
                                                                    .name,textAlign: TextAlign.center,
                                                                    style: TextStyle(fontSize: 13),overflow: TextOverflow.ellipsis,),
                                                              ],
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                      }),
                                    ),
 SizedBox(height: 12,),
                                    GetBuilder<CategoryController>(
                                        builder: (categoryController) {
                                      return categoryController.categoryList ==
                                              null
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : categoryController
                                                      .categoryList.length ==
                                                  0
                                              ? SizedBox()
                                              : CategoryView(
                                                  categoryController:
                                                      categoryController);
                                    }),


                                    // _configModel.popularRestaurant == 1 ? GetBuilder<RestaurantController>(builder: (restController) {
                                    //   return restController.popularRestaurantList == null ? PopularRestaurantView(restController: restController, isPopular: true)
                                    //       : restController.popularRestaurantList.length == 0 ? SizedBox() : PopularRestaurantView(restController: restController, isPopular: true);
                                    // }) : SizedBox(),

                                    // GetBuilder<CampaignController>(builder: (campaignController) {
                                    //   return campaignController.itemCampaignList == null ? ItemCampaignView(campaignController: campaignController)
                                    //       : campaignController.itemCampaignList.length == 0 ? SizedBox() : ItemCampaignView(campaignController: campaignController);
                                    // }),

                                    _configModel.popularFood == 1 ? GetBuilder<ProductController>(builder: (productController) {
                                      return productController.popularProductList == null ? PopularFoodView(productController: productController, isPopular: true)
                                          : productController.popularProductList.length == 0 ? SizedBox() : PopularFoodView(productController: productController, isPopular: true);
                                    }) : SizedBox(),

                                    // _configModel.newRestaurant == 1 ? GetBuilder<RestaurantController>(builder: (restController) {
                                    //   return restController.latestRestaurantList == null ? PopularRestaurantView(restController: restController, isPopular: false)
                                    //       : restController.latestRestaurantList.length == 0 ? SizedBox() : PopularRestaurantView(restController: restController, isPopular: false);
                                    // }) : SizedBox(),

                                    _configModel.mostReviewedFoods == 1 ? GetBuilder<ProductController>(builder: (productController) {
                                      return productController.reviewedProductList == null ? PopularFoodView(productController: productController, isPopular: false)
                                          : productController.reviewedProductList.length == 0 ? SizedBox() : PopularFoodView(productController: productController, isPopular: false);
                                    }) : SizedBox(),
                                    // Padding(
                                    //   padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                                    //   child: GetBuilder<RestaurantController>(builder: (restaurantController) {
                                    //     return Row(children: [
                                    //       Expanded(child: Text('all_restaurants'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge))),
                                    //       restaurantController.restaurantList != null ? PopupMenuButton(
                                    //         itemBuilder: (context) {
                                    //           return [
                                    //             PopupMenuItem(value: 'all', child: Text('all'.tr), textStyle: robotoMedium.copyWith(
                                    //               color: restaurantController.restaurantType == 'all'
                                    //                   ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).disabledColor,
                                    //             )),
                                    //             PopupMenuItem(value: 'take_away', child: Text('take_away'.tr), textStyle: robotoMedium.copyWith(
                                    //               color: restaurantController.restaurantType == 'take_away'
                                    //                   ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).disabledColor,
                                    //             )),
                                    //             PopupMenuItem(value: 'delivery', child: Text('delivery'.tr), textStyle: robotoMedium.copyWith(
                                    //               color: restaurantController.restaurantType == 'delivery'
                                    //                   ? Theme.of(context).textTheme.bodyText1.color : Theme.of(context).disabledColor,
                                    //             )),
                                    //           ];
                                    //         },
                                    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
                                    //         child: Padding(
                                    //           padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                    //           child: Icon(Icons.filter_list),
                                    //         ),
                                    //         onSelected: (value) => restaurantController.setRestaurantType(value),
                                    //       ) : SizedBox(),
                                    //     ]);
                                    //   }),
                                    // ),
                                    // RestaurantView(scrollController: _scrollController),
 SizedBox(height: 40,),
                                  ]))),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
List mainCat=['الخدمات'];