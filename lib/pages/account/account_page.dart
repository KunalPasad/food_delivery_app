import 'package:flutter/material.dart';
import 'package:food_delivery_app/base/custom_loader.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utils/colors.dart';
import 'package:food_delivery_app/utils/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print('User has logged in');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: Center(
          child: BigText(
            text: 'Profile',
            size: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: GetBuilder<UserController>(
        builder: (userController){
          return _userLoggedIn ? (userController.isLoading ?
            Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
                top: Dimensions.height20
            ),
            child: Column(
              children: [
                AppIcon(
                  icon: Icons.person,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimensions.height15 * 5,
                  size: Dimensions.height15 * 10,
                ),
                SizedBox(
                  height: Dimensions.height30,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                                text: userController.userModel.name
                            )
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                                text: userController.userModel.phone
                            )
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                                text: userController.userModel.email
                            )
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.location_on,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                                text: 'Fill in your address'
                            )
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        AccountWidget(
                            appIcon: AppIcon(
                              icon: Icons.message_outlined,
                              backgroundColor: Colors.redAccent,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height10 * 2.5,
                              size: Dimensions.height10 * 5,
                            ),
                            bigText: BigText(
                                text: 'Messages'
                            )
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().clearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.offNamed(RouteHelper.getSignInPage());
                            }
                          },
                          child: AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.logout,
                                backgroundColor: Colors.redAccent,
                                iconColor: Colors.white,
                                iconSize: Dimensions.height10 * 2.5,
                                size: Dimensions.height10 * 5,
                              ),
                              bigText: BigText(
                                  text: 'LogOut'
                              )
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ) :
          CustomLoader()
            ) :
          Container(
            child: Center(
              child: Text(
                'You must login'
              ),
            ),
          );
        },
      )
    );
  }
}
