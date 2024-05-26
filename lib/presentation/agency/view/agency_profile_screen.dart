import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/presentation/agency/controller/agency_profile_controller.dart';
import 'package:travel_app/presentation/agency/model/agency_profile_model.dart';
import 'package:travel_app/presentation/agency/view/update_agency_screen.dart';

import '../../../app/configs/app_colors.dart';
import '../../../app/configs/app_size_config.dart';
import '../../../app/utils/custom_widgets/common_text.dart';
import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';

class AgencyProfileScreen extends StatefulWidget {
  const AgencyProfileScreen({super.key});

  @override
  State<AgencyProfileScreen> createState() => _AgencyProfileScreenState();
}

class _AgencyProfileScreenState extends State<AgencyProfileScreen> {
  final AgencyProfileController agencyProfileController =
      Get.put(AgencyProfileController());
  final Rx<AgencyProfileModel> agencyProfileModel = AgencyProfileModel().obs;
  final RxBool isLoading = false.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      agencyProfileController.fetchAgency();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Agency Profile',
        ),
        body: Obx(() {
          var data1 = agencyProfileController.agencyProfileModel.value;
          if (agencyProfileController.isLoading.value) {
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
                            Icon(Icons.info_outline_rounded,
                                color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Code",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.code ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.person_outline_rounded,
                                color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Name",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.name ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                // FontAwesomeIcons.solidIdBadge,
                                color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Address",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.address ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
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
                          text: data1.email ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.phone, color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Phone 1",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.phone1 ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined,
                                color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Phone 2",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.phone2 ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(Icons.manage_accounts_outlined,
                                color: AppColors.appColorPrimary),
                            CommonText(
                              text: "Contact Person",
                              weight: FontWeight.w300,
                              fontSize: 14,
                            ),
                          ],
                        ),
                        CommonText(
                          text: data1.contactPerson ?? "- - -",
                          weight: FontWeight.w500,
                          fontSize: 18,
                        ),
                        SizedBox(height: 20),
                        CustomButton(
                            height: 40,
                            width: w,
                            text: 'Update',
                            onPress: () {
                              Get.to(() => UpdateAgencyProfileScreen(
                                    id: data1.id!.toInt(),
                                    name: data1.name.toString(),
                                    code: data1.code.toString(),
                                    address: data1.address.toString(),
                                    email: data1.email.toString(),
                                    phone1: data1.phone1.toString(),
                                    phone2: data1.phone2.toString(),
                                    contactPerson:
                                        data1.contactPerson.toString(),
                                  ));
                            })
                      ],
                    ),
                  );
                });
          }
        }));
  }
}
