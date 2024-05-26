// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/presentation/profile/controller/update_profile_controller.dart';

import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../../app/utils/custom_widgets/custom_textfield_required.dart';

class UpdateProfileScreen extends StatefulWidget {
  String? name;
  String? midName;
  String? lastName;
  String? username;
  String? email;
  UpdateProfileScreen(
      {required this.name,
      required this.midName,
      required this.lastName,
      required this.username,
      required this.email,
      super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController midNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  var isLoading = true.obs;
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

  final UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());

  @override
  void initState() {
    setArgs();
    super.initState();
  }

  void setArgs() {
    setState(() {
      nameController = TextEditingController(text: "${widget.name}");
      lastNameController = TextEditingController(text: "${widget.lastName}");
      midNameController = TextEditingController(text: "${widget.midName}");
      emailController = TextEditingController(text: "${widget.email}");
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
        title: 'Update Profile',
      ),
      body: Obx(() {
        if (updateProfileController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    0.03.ph,
                    Custom_textfield_required(
                        controller: nameController,
                        requiredLabel: 'First Name',
                        hint: 'First Name',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter First Name";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: midNameController,
                        requiredLabel: 'Middle Name',
                        hint: 'Middle Name',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter First Name";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: lastNameController,
                        requiredLabel: 'Last Name',
                        hint: 'Last Name',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Last Name";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        readOnly: true,
                        controller: usernameController,
                        requiredLabel: 'Username',
                        hint: '${widget.username}',
                        validator: (inputValue) {
                          // if (inputValue!.isEmpty) {
                          //   return "Enter First Name";
                          // }
                          // return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: emailController,
                        requiredLabel: 'Email',
                        hint: 'Email',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        }),
                    SizedBox(height: 20),
                    CustomButton(
                      height: 40,
                      width: w,
                      text: 'Update',
                      onPress:
                          // () { updateProfileController.updateUser();}
                          () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            isValidForm = true;
                            updateProfileController.updateUser(
                                nameController.text.trim(),
                                midNameController.text.trim(),
                                lastNameController.text.trim(),
                                emailController.text.trim());
                          });
                        } else {
                          setState(() {
                            isValidForm = false;
                          });
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
