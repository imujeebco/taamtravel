// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_app/app/configs/app_size_config.dart';

import '../../../app/utils/custom_widgets/custom_appbar.dart';
import '../../../app/utils/custom_widgets/custom_button.dart';
import '../../../app/utils/custom_widgets/custom_textfield_required.dart';
import '../controller/update_agency_controller.dart';

class UpdateAgencyProfileScreen extends StatefulWidget {
  int id;
  String? name;
  String? code;
  String? address;
  String? email;
  String? phone1;
  String? phone2;
  String? contactPerson;

  UpdateAgencyProfileScreen(
      {required this.id,
      required this.name,
      required this.code,
      required this.address,
      required this.email,
      required this.phone1,
      required this.phone2,
      required this.contactPerson,
      super.key});

  @override
  State<UpdateAgencyProfileScreen> createState() =>
      _UpdateAgencyProfileScreenState();
}

class _UpdateAgencyProfileScreenState extends State<UpdateAgencyProfileScreen> {
  TextEditingController codeController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  var isLoading = true.obs;
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

  final UpdateAgencyController updateAgencyController =
      Get.put(UpdateAgencyController());

  @override
  void initState() {
    setArgs();
    super.initState();
  }

  void setArgs() {
    setState(() {
      nameController = TextEditingController(text: "${widget.name}");
      codeController = TextEditingController(text: "${widget.code}");
      addressController = TextEditingController(text: "${widget.address}");
      emailController = TextEditingController(text: "${widget.email}");
      phone1Controller = TextEditingController(text: "${widget.phone1}");
      phone2Controller = TextEditingController(text: "${widget.phone2}");
      contactPersonController =
          TextEditingController(text: "${widget.contactPerson}");
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
        title: 'Update Agency',
      ),
      body: Obx(() {
        if (updateAgencyController.isLoading.value) {
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
                        controller: codeController,
                        requiredLabel: 'Code',
                        hint: 'Code',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Code";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: nameController,
                        requiredLabel: 'Name',
                        hint: 'Name',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: addressController,
                        requiredLabel: 'Address',
                        hint: 'Address',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Address";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: emailController,
                        requiredLabel: 'Email',
                        hint: '${widget.email}',
                        validator: (inputValue) {
                          // if (inputValue!.isEmpty) {
                          //   return "Enter First Name";
                          // }
                          // return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: phone1Controller,
                        requiredLabel: 'Phone1',
                        hint: 'Phone1',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Phone1";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: phone2Controller,
                        requiredLabel: 'Phone2',
                        hint: 'Phone2',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Phone2";
                          }
                          return null;
                        }),
                    0.03.ph,
                    Custom_textfield_required(
                        controller: contactPersonController,
                        requiredLabel: 'Contact Person',
                        hint: 'Contact Person',
                        validator: (inputValue) {
                          if (inputValue!.isEmpty) {
                            return "Enter Contact Person";
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
                            updateAgencyController.updateAgency(
                                widget.id,
                                nameController.text.trim(),
                                codeController.text.trim(),
                                addressController.text.trim(),
                                emailController.text.trim(),
                                phone1Controller.text.trim(),
                                phone2Controller.text.trim(),
                                contactPersonController.text.trim());
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
