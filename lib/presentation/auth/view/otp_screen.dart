// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:get/get.dart";

import "../../../app/configs/app_colors.dart";
import "../../../app/utils/custom_widgets/common_text.dart";
import "../../../app/utils/custom_widgets/custom_button.dart";
import "../controller/verify_otp_controller.dart";

class OTPScreen extends StatefulWidget {
  String? firstName;
  String? midName;
  String? lastName;
  String? username;
  String? password;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  OTPScreen({
    super.key,
    required this.firstName,
    required this.midName,
    required this.lastName,
    required this.username,
    required this.password,
    required this.email,
    required this.phoneCode,
    required this.phoneNumber,
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String otp = '';
  List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());
  List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());
  var isLoading = true.obs;
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();
  final VerifyOtpController verifyOtpController =
      Get.put(VerifyOtpController());

  @override
  void initState() {
    super.initState();
    _controllers.forEach((controller) {
      controller.addListener(_onTextChanged);
    });
  }

  @override
  void dispose() {
    _controllers.forEach((controller) {
      controller.removeListener(_onTextChanged);
    });
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      otp = '';
      _controllers.forEach((controller) {
        otp += controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue.withOpacity(0.5),
            Colors.black.withOpacity(0.5),
          ],
        )),
        child: Stack(
          children: [
            Container(
                height: 550,
                width: double.infinity,
                // color: Colors.red.shade300,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.blue.withOpacity(0.5),
                    BlendMode.srcATop,
                  ),
                  child: Image(
                      image: AssetImage("assets/images/onboard_background.png"),
                      fit: BoxFit.cover),
                )),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 100),
                  CommonText(
                      text: "Create an account",
                      color: Colors.white,
                      fontSize: 25,
                      weight: FontWeight.w600),
                  SizedBox(height: 10),
                  CommonText(
                      text: "Verify the OTP",
                      textAlign: TextAlign.center,
                      color: Colors.white,
                      fontSize: 15,
                      weight: FontWeight.w400),
                  SizedBox(height: 100),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 250,
                // padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25.0),
                      topLeft: Radius.circular(25.0)),
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                (index) => Container(
                                  width: 45,
                                  height: 45,
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.black54, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: AppColors.appColorPrimary,
                                              width: 2.5),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(bottom: 5)),
                                    controller: _controllers[index],
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    autofocus: index == 0,
                                    focusNode: _focusNodes[index],
                                    onChanged: (value) {
                                      if (value.isNotEmpty) {
                                        if (index < 5) {
                                          _focusNodes[index].unfocus();
                                          FocusScope.of(context).requestFocus(
                                              _focusNodes[index + 1]);
                                        } else {
                                          _focusNodes[index].unfocus();
                                        }
                                      } else {
                                        if (index > 0) {
                                          _focusNodes[index].unfocus();
                                          _focusNodes[index - 1].requestFocus();
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                // CustomButton(
                                //     onPress: () {
                                // Get.to(() => OTPScreen());

                                // print('Entered OTP: $otp');
                                // },
                                // text: "Verify"),
                                Obx(() {
                                  return verifyOtpController.isLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.appColorPrimary,
                                          ),
                                        )
                                      : CustomButton(
                                          onPress: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              setState(() {
                                                isValidForm = true;
                                                // checkConnectivity();
                                                verifyOtpController.verifyOTP(
                                                    widget.firstName,
                                                    widget.midName,
                                                    widget.lastName,
                                                    widget.username,
                                                    widget.password,
                                                    widget.email,
                                                    widget.phoneCode,
                                                    widget.phoneNumber,
                                                    otp.toString());
                                              });
                                            } else {
                                              setState(() {
                                                isValidForm = false;
                                              });
                                            }
                                          },
                                          text: "Verify");
                                }),
                                SizedBox(height: 10),
                                TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: CommonText(
                                      text: "Back",
                                      color: AppColors.appColorPrimary,
                                      weight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
