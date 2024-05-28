import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/airline/auth/view/login_screen.dart';
import 'package:travel_app/airline/profile/controller/user_profile_controller.dart';
import 'package:travel_app/airline/profile/model/user_profile_model.dart';

import '../../../app/configs/app_size_config.dart';
import '../../../app/data/data_controller.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../booking_history/view/my_bookings_screen.dart';
import 'update_profile_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final UserProfileController userProfileController =
      Get.put(UserProfileController());
  final Rx<UserProfileModel> userProfileModel = UserProfileModel().obs;
  final RxBool isLoading = false.obs;
  final DataController dataController = Get.put(DataController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProfileController.fetchUser();
      dataController.loadMyData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: dataController.myLoggedIn.value
            ? Obx(() {
                var data1 = userProfileController.userProfileModel.value;
                if (userProfileController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.appColorPrimary,
                                    ),
                                    child: Icon(
                                      Icons.person_2_outlined,
                                      color: Colors.white54,
                                      size: 38,
                                    )),
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Icon(Icons.person,
                                      color: AppColors.appColorPrimary),
                                  CommonText(
                                    text: "First Name",
                                    weight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              CommonText(
                                text: data1.firstName.toString(),
                                weight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.person_outline_rounded,
                                      color: AppColors.appColorPrimary),
                                  CommonText(
                                    text: "Middle Name",
                                    weight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              CommonText(
                                text: data1.middleName.toString(),
                                weight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.person_outline_rounded,
                                      color: AppColors.appColorPrimary),
                                  CommonText(
                                    text: "Last Name",
                                    weight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              CommonText(
                                text: data1.lastName.toString(),
                                weight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.verified_rounded,
                                      // FontAwesomeIcons.solidIdBadge,
                                      color: AppColors.appColorPrimary),
                                  CommonText(
                                    text: "Username",
                                    weight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              CommonText(
                                text: data1.username.toString(),
                                weight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.email_outlined,
                                      color: AppColors.appColorPrimary),
                                  CommonText(
                                    text: "Email",
                                    weight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                ],
                              ),
                              CommonText(
                                text: data1.email.toString(),
                                weight: FontWeight.w500,
                                fontSize: 18,
                              ),
                              SizedBox(height: 20),
                              CustomButton(
                                  height: 40,
                                  width: w,
                                  text: 'Update',
                                  onPress: () {
                                    Get.to(() => UpdateProfileScreen(
                                          name: data1.firstName.toString(),
                                          midName: data1.middleName.toString(),
                                          lastName: data1.lastName.toString(),
                                          email: data1.email.toString(),
                                          username: data1.username.toString(),
                                        ));
                                  })
                            ],
                          ),
                        );
                      });
                }
              })
            : Padding(
                padding: EdgeInsets.all(20),
                child: GotoLoginWidget(),
              ));
  }
}
