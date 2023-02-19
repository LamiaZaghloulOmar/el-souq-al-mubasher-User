import 'package:efood_multivendor/controller/auth_controller.dart';
import 'package:efood_multivendor/controller/splash_controller.dart';
import 'package:efood_multivendor/data/model/body/social_log_in_body.dart';
import 'package:efood_multivendor/util/dimensions.dart';
import 'package:efood_multivendor/util/images.dart';
import 'package:efood_multivendor/util/styles.dart';
import 'package:efood_multivendor/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialLoginWidget extends StatelessWidget {
  final GoogleSignIn _google = GoogleSignIn(
                // clientId:'413373745155-92l2n00blitupsr09qp12ru6nqc0uujl.apps.googleusercontent.com',
      clientId: '885278567001-saja79h13bmsaultqe6lejh7ml2ohord.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ], );

  @override
  Widget build(BuildContext context) {
 
    return 
    // (Get.find<SplashController>().configModel.socialLogin[0].status
    // || Get.find<SplashController>().configModel.socialLogin[1].status) ? 
    Column(children: [

      Center(child: Text('social_login'.tr, style: robotoMedium)),
      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

      Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        // Get.find<SplashController>().configModel.socialLogin[0].status ?
         InkWell(
          onTap: () async {
              
            final GoogleSignInAccount  googleUser = await _google.signIn();
              print(googleUser);
               final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
            // GoogleSignInAuthentication _auth = await _googleAccount.authentication;
            if(googleUser != null) {
              Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                email: googleUser.email, token: googleAuth.accessToken, uniqueId: googleUser.id,
                 medium: 'google',
              ));
            }
          },
          child: Container(
            height: 40,width: 40,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], spreadRadius: 1, blurRadius: 5)],
            ),
            child: Image.asset(Images.google),
          ),
        ),
        //  : SizedBox(),
        SizedBox(width:
        //  Get.find<SplashController>().configModel.socialLogin[0].status ?
         Dimensions.PADDING_SIZE_SMALL 
        //  : 0
         ),

        // Get.find<SplashController>().configModel.socialLogin[1].status ? 
        InkWell(
          onTap: () async{
//             final facebookSignIn = FacebookLogin();
// facebookSignIn.loginBehavior = FacebookLoginBehavior.webOnly;
            LoginResult _result = await FacebookAuth.instance.login(
              permissions: ["public_profile", "email"],
              loginBehavior: LoginBehavior.webOnly
            );
            if (_result.status == LoginStatus.success) {
              Map _userData = await FacebookAuth.instance.getUserData();
              print(_userData);
              if(_userData != null){
                Get.find<AuthController>().loginWithSocialMedia(SocialLogInBody(
                  image: _userData['picture']['url']??"http://",
                  id:_userData['id']??"",
                  phone: "0000",
                  email: _userData['email'],
                   token: _result.accessToken.token, 
                   uniqueId: _result.accessToken.userId,
                    medium: 'facebook',

                ));
              }
            } else {
              showCustomSnackBar('${_result.status} ${_result.message}');
            }
          },
          child: Container(
            height: 40, width: 40,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], spreadRadius: 1, blurRadius: 5)],
            ),
            child: Image.asset(Images.facebook),
          ),
        ),
        //  : SizedBox(),
SizedBox(width:  Dimensions.PADDING_SIZE_SMALL ,),
   InkWell(
          onTap: () async {
               final twitterLogin = new TwitterLogin(
    apiKey: 'O6V8m2jSIIlqYWjnKHaJQ3yzy',
    apiSecretKey:'uSXBGtOswaxg0DeEJb1kAeROMbnxXJSiuvNy6u0pWSur2kMicm',
    redirectURI: 'elsouqalmubasher://'
  );

  // Trigger the sign-in flow
  final authResult = await twitterLogin.login();
 print(authResult);
          },
          child: Container(
            height: 40,width: 40,
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 300], spreadRadius: 1, blurRadius: 5)],
            ),
            child: Image.asset(Images.twiter),
          ),
        ),
        // SizedBox(width:  Dimensions.PADDING_SIZE_SMALL ,),
   
      ]),
      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

    ]) ;
    // : SizedBox();
  }
}
