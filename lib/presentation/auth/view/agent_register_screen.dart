import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/presentation/auth/controller/agent_register_controller.dart';

class AgentRegisterScreen extends StatefulWidget {
  const AgentRegisterScreen({super.key});

  @override
  State<AgentRegisterScreen> createState() => _AgentRegisterScreenState();
}

class _AgentRegisterScreenState extends State<AgentRegisterScreen> {
  final AgentRegisterController agentRegisterController =
      Get.put(AgentRegisterController());
  final firstNameController = TextEditingController();
  final midNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final codeController = TextEditingController();
  var isLoading = true.obs;
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

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
              ),
            ),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 100),
                    CommonText(
                        text: "Create an account",
                        color: Colors.white,
                        fontSize: 25,
                        weight: FontWeight.w600),
                    SizedBox(height: 10),
                    CommonText(
                        text: "Sign up your account",
                        textAlign: TextAlign.center,
                        color: Colors.white,
                        fontSize: 15,
                        weight: FontWeight.w400),
                    SizedBox(height: 100),
                    Container(
                      // height: 400,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "First Name",
                                    hint: "Enter First Name here",
                                    controller: firstNameController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Middle Name",
                                    hint: "Enter Middle Name here",
                                    controller: midNameController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Last Name",
                                    hint: "Enter Last Name here",
                                    controller: lastNameController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Username",
                                    hint: "Enter username here",
                                    controller: userController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Email",
                                    hint: "Enter email here",
                                    controller: emailController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Password",
                                    hint: "Enter username here",
                                    obscureText: true,
                                    controller: passController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Confirm Password",
                                    hint: "Confirm password here",
                                    obscureText: true,
                                    controller: confirmPassController),
                                SizedBox(height: 20),
                                Custom_textfield_required(
                                    requiredLabel: "Agent Code",
                                    hint: "Enter Code here",
                                    controller: codeController),
                                SizedBox(height: 50),
                                Obx(() {
                                  return agentRegisterController.isLoading.value
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
                                                agentRegisterController
                                                    .registerAgent(
                                                  firstNameController.text
                                                      .trim(),
                                                  midNameController.text.trim(),
                                                  lastNameController.text
                                                      .trim(),
                                                  userController.text.trim(),
                                                  passController.text.trim(),
                                                  emailController.text.trim(),
                                                  codeController.text.trim(),
                                                );
                                              });
                                            } else {
                                              setState(() {
                                                isValidForm = false;
                                              });
                                            }
                                          },
                                          text: "Sign up");
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
                                    ))
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
