import 'dart:io';

import 'package:efood_multivendor/controller/location_controller.dart';
import 'package:efood_multivendor/data/api/api_client.dart';
import 'package:efood_multivendor/view/base/custom_app_bar.dart';
import 'package:efood_multivendor/view/base/not_logged_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../controller/auth_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../base/confirmation_dialog.dart';
import '../../base/custom_button.dart';
import '../../base/custom_loader.dart';
import '../../base/custom_snackbar.dart';
import '../../base/no_data_screen.dart';
import '../address/add_address_screen.dart';
import '../address/widget/address_widget.dart';

class AdvertiseScreen extends StatefulWidget {
  final String title;
  final String serviceId;

  AdvertiseScreen({Key key, @required this.title, @required this.serviceId})
      : super(key: key);

  @override
  State<AdvertiseScreen> createState() => _AdvertiseScreenState();
}

class _AdvertiseScreenState extends State<AdvertiseScreen> {
  String id = "";
  String addName = "";
  XFile imageFile = null;
  ApiClient apiClient;
  bool isLoading = false;
   @override
  void initState() {
    super.initState();
  
  }

  final _formKey = GlobalKey<FormState>();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn) Get.find<LocationController>().getAddressList();
     
    return Scaffold(
      appBar: CustomAppBar(title: "خدمة ${widget.title}"),
      body: _isLoggedIn
          ? GetBuilder<LocationController>(builder: (locationController) {
// locationController.getAddressList();
              return RefreshIndicator(
                onRefresh: () async {
                  await locationController.getAddressList();
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: ListView(children: [
                        SizedBox(height: 10,),
                        Container(

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: textController,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: 4,
                              maxLength: 200,
                              decoration: InputDecoration(
                                labelText: 'تفاصيل الأعلان',
                                hintText:
                                    'مثال : انا اريد نجار محترف لتصليح باب منزل',
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(fontSize: 15),
                                
                                labelStyle: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              // textStyle: TextStyle(fontSize: 15),
                              validator: (value) => value.isNotEmpty
                                  ? null
                                  : 'هذا الحقل مطلوب',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                              onSaved: (content) {},
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                          
                            //     Text("اختر صورة",
                            //         style: TextStyle(
                            //             color: Colors.white, fontSize: 15)),
                            //   ],
                            // ),
                            InkWell(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18.0, vertical: 5),
                                    child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                 Text(
                                      "اختر صورة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    
                                    Spacer(),
                                   imageFile == null
                                    ? Icon(
                                        Icons.image,
                                        size: 50,
                                      )
                                    :Container(
                                      height: 40,
                                      width: 40,
                                      child: Image.file(
                                        File(imageFile.path),
                                        fit: BoxFit.contain,
                                    ))
                                    ]),
                                  )),
                              onTap: () async {
                                PickedFile pickedFile =
                                    await ImagePicker().getImage(
                                  source: ImageSource.gallery,
                                );
                                if (pickedFile != null) {
                                  setState(() {
                                    imageFile = XFile(pickedFile.path);
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            // Container(
                            //     height: 250,
                            //     width: 250,
                            //     child: imageFile == null
                            //         ? Icon(
                            //             Icons.image,
                            //             size: 100,
                            //           )
                            //         : Image.file(
                            //             File(imageFile.path),
                            //             fit: BoxFit.cover,
                            //           ))
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("اختار العنوان",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                            GetBuilder<LocationController>(
                                builder: (locationController) {
                              return locationController.addressList != null
                                  ? locationController.addressList.length > 0
                                      ? RefreshIndicator(
                                          onRefresh: () async {
                                            await locationController
                                                .getAddressList();
                                          },
                                          child: Scrollbar(
                                              child: SingleChildScrollView(
                                            physics:
                                                AlwaysScrollableScrollPhysics(),
                                            child: Center(
                                                child: SizedBox(
                                              width: Dimensions.WEB_MAX_WIDTH,
                                              child: ListView.builder(
                                                padding: EdgeInsets.all(
                                                    Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                itemCount: locationController
                                                    .addressList.length,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Dismissible(
                                                    key: UniqueKey(),
                                                    onDismissed: (dir) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomLoader(),
                                                          barrierDismissible:
                                                              false);
                                                      locationController
                                                          .deleteUserAddressByID(
                                                              locationController
                                                                  .addressList[
                                                                      index]
                                                                  .id,
                                                              index)
                                                          .then((response) {
                                                        Navigator.pop(context);
                                                        showCustomSnackBar(
                                                            response.message,
                                                            isError: !response
                                                                .isSuccess);
                                                      });
                                                    },
                                                    child: AddressWidget(
                                                      address:
                                                          locationController
                                                                  .addressList[
                                                              index],
                                                      fromAddress: true,
                                                      onTap: () {
                                                        showCustomSnackBar(
                                                            "تم تعيين العنوان ${locationController.addressList[index].address}",
                                                            isError: false);
                                                        setState(() {
                                                          id =
                                                              locationController
                                                                  .addressList[
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                          addName =
                                                              locationController
                                                                  .addressList[
                                                                      index]
                                                                  .address
                                                                  .toString();
                                                        });
                                                        print("Id is $id");
                                                      },
                                                      onRemovePressed: () {
                                                        if (Get
                                                            .isSnackbarOpen) {
                                                          Get.back();
                                                        }
                                                        Get.dialog(
                                                            ConfirmationDialog(
                                                                icon: Images
                                                                    .warning,
                                                                description:
                                                                    'are_you_sure_want_to_delete_address'
                                                                        .tr,
                                                                onYesPressed:
                                                                    () {
                                                                  Get.back();
                                                                  Get.dialog(
                                                                      CustomLoader(),
                                                                      barrierDismissible:
                                                                          false);
                                                                  locationController
                                                                      .deleteUserAddressByID(
                                                                          locationController
                                                                              .addressList[index]
                                                                              .id,
                                                                          index)
                                                                      .then((response) {
                                                                    Get.back();
                                                                    showCustomSnackBar(
                                                                        response
                                                                            .message,
                                                                        isError:
                                                                            !response.isSuccess);
                                                                  });
                                                                }));
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                          )),
                                        )
                                      : Column(
                                          children: [
                                            NoDataScreen(
                                                text: 'no_saved_address_found'
                                                    .tr),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.to(AddAddressScreen(fromCheckout: false,));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Colors.white)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .location_on_outlined,
                                                            color:
                                                                Colors.white),
                                                        SizedBox(width: 5),
                                                        Text(
                                                            'add_new_address'
                                                                .tr,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 15,
                                            )
                                          ],
                                        )
                                  : Center(child: CircularProgressIndicator());
                            })
                          ],
                        ),
                        CustomButton(
                            buttonText: isLoading?'يتم نشر الأعلان برجاء الأنتظار...':'نشر الاعلان',
                            
                            onPressed: () async {
                              print("Pr");
                              if (_formKey.currentState.validate()) {
                                if (id == "") {
                                  showCustomSnackBar("برجاء ملئ جميع البيانات",
                                      isError: true);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  await locationController.AdvertisePost(
                                          id,
                                          widget.serviceId,
                                          textController.text,
                                          addName,
                                          imageFile)
                                      .then((value) {})
                                      .then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Get.back();
                                    showCustomSnackBar("تم النشر بنجاح",
                                        isError: false);
                                  }).catchError((e) {
                                    showCustomSnackBar(e.toString(),
                                        isError: true);
                                  });
                                }
                              } else {
                                showCustomSnackBar("برجاء ملئ جميع البيانات",
                                    isError: true);
                              }
                            })
                      ]),
                    ),
                  ),
                ),
              );
            })
          : NotLoggedInScreen(),
    );
  }
}
