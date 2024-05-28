// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_outline_button.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield_required.dart';
import 'package:travel_app/airline/booking_history/view/my_bookings_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:travel_app/airline/home_bottom_nav/views/payment_method.dart';

import '../../../app/configs/app_border_radius.dart';
import '../../../app/configs/app_colors.dart';
import '../../../app/data/data_controller.dart';

class PassengerDetailsScreen extends StatefulWidget {
  String searchID;
  String flightID;
  String paymentID;
  //
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  String traveller;
  int? adultCount;
  int? childCount;
  int? infantCount;
  String cabinClass;
  String fare;
  String tax;
  String total;
  //
  int? child1age;
  int? child2age;
  int? child3age;
  int? child4age;
  //
  int? infant1age;
  int? infant2age;
  int? infant3age;
  int? infant4age;
  //

  PassengerDetailsScreen({
    super.key,
    required this.searchID,
    required this.flightID,
    required this.paymentID,
    //
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    //
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    //
    required this.traveller,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    required this.cabinClass,
    required this.fare,
    required this.tax,
    required this.total,
    //
    required this.child1age,
    required this.child2age,
    required this.child3age,
    required this.child4age,
    //
    required this.infant1age,
    required this.infant2age,
    required this.infant3age,
    required this.infant4age,
    //
  });

  @override
  State<PassengerDetailsScreen> createState() => _PassengerDetailsScreenState();
}

class _PassengerDetailsScreenState extends State<PassengerDetailsScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController passportExpiryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  //
  TextEditingController adult2Controller = TextEditingController();
  TextEditingController adult2surnameController = TextEditingController();
  TextEditingController adult2natController = TextEditingController();
  TextEditingController adult2yearController = TextEditingController();
  TextEditingController adult2passController = TextEditingController();
  TextEditingController adult2passExpController = TextEditingController();
  TextEditingController adult3Controller = TextEditingController();
  TextEditingController adult3surnameController = TextEditingController();
  TextEditingController adult3natController = TextEditingController();
  TextEditingController adult3yearController = TextEditingController();
  TextEditingController adult3passController = TextEditingController();
  TextEditingController adult3passExpController = TextEditingController();
  TextEditingController adult4Controller = TextEditingController();
  TextEditingController adult4surnameController = TextEditingController();
  TextEditingController adult4natController = TextEditingController();
  TextEditingController adult4yearController = TextEditingController();
  TextEditingController adult4passController = TextEditingController();
  TextEditingController adult4passExpController = TextEditingController();
  //
  TextEditingController child1Controller = TextEditingController();
  TextEditingController child1surnameController = TextEditingController();
  TextEditingController child1yearController = TextEditingController();
  TextEditingController child1natController = TextEditingController();
  TextEditingController child1passController = TextEditingController();
  TextEditingController child1passExpController = TextEditingController();
  TextEditingController child2Controller = TextEditingController();
  TextEditingController child2surnameController = TextEditingController();
  TextEditingController child2natController = TextEditingController();
  TextEditingController child2yearController = TextEditingController();
  TextEditingController child2passController = TextEditingController();
  TextEditingController child2passExpController = TextEditingController();
  TextEditingController child3Controller = TextEditingController();
  TextEditingController child3surnameController = TextEditingController();
  TextEditingController child3natController = TextEditingController();
  TextEditingController child3yearController = TextEditingController();
  TextEditingController child3passController = TextEditingController();
  TextEditingController child3passExpController = TextEditingController();
  TextEditingController child4Controller = TextEditingController();
  TextEditingController child4surnameController = TextEditingController();
  TextEditingController child4natController = TextEditingController();
  TextEditingController child4yearController = TextEditingController();
  TextEditingController child4passController = TextEditingController();
  TextEditingController child4passExpController = TextEditingController();
  //
  TextEditingController infant1Controller = TextEditingController();
  TextEditingController infant1surnameController = TextEditingController();
  TextEditingController infant1natController = TextEditingController();
  TextEditingController infant1yearController = TextEditingController();
  TextEditingController infant1passController = TextEditingController();
  TextEditingController infant1passExpController = TextEditingController();
  TextEditingController infant2Controller = TextEditingController();
  TextEditingController infant2surnameController = TextEditingController();
  TextEditingController infant2natController = TextEditingController();
  TextEditingController infant2yearController = TextEditingController();
  TextEditingController infant2passController = TextEditingController();
  TextEditingController infant2passExpController = TextEditingController();
  TextEditingController infant3Controller = TextEditingController();
  TextEditingController infant3surnameController = TextEditingController();
  TextEditingController infant3natController = TextEditingController();
  TextEditingController infant3yearController = TextEditingController();
  TextEditingController infant3passController = TextEditingController();
  TextEditingController infant3passExpController = TextEditingController();
  TextEditingController infant4Controller = TextEditingController();
  TextEditingController infant4surnameController = TextEditingController();
  TextEditingController infant4natController = TextEditingController();
  TextEditingController infant4yearController = TextEditingController();
  TextEditingController infant4passController = TextEditingController();
  TextEditingController infant4passExpController = TextEditingController();
  final DataController dataController = Get.put(DataController());
  DateTime _selectedDate = DateTime.now();
  String? requestedAge = "";
  String phoneNumber = '';
  String phoneCode = '+1';
  String countryCode = 'US';
  PhoneNumber number = PhoneNumber(isoCode: 'US');
  bool isValidForm = false;
  final _formkey = GlobalKey<FormState>();

  String? _selectedTitle = "Mr";
  String? _selectedCountry;
  final Map<String, String> titleMap = {
    'Mr': 'MISTER',
    'Mrs': 'MISTER',
    'Ms': 'MISTER',
    // 'Sir': 'MISTER',
  };

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      DatePickerMode initialDatePickerMode,
      bool isPass) async {
    final DateTime today = DateTime.now();
    final DateTime eighteenYearsAgo = DateTime(today.year - 18, 12, 31);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPass == false ? eighteenYearsAgo : DateTime.now(),
      firstDate: DateTime(1901),
      lastDate: isPass == false ? eighteenYearsAgo : DateTime(2101),
      initialDatePickerMode: initialDatePickerMode,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DatePickerMode == DatePickerMode.year
            ? "${picked.year}"
            : initialDatePickerMode == DatePickerEntryMode.calendar
                ? "${picked.month}"
                : "${picked.day}";
        if (isPass == false) {
          _updateTextControllers();
        } else {
          _updatePassExpTextControllers();
        }
      });
    }
  }

  Future<void> _selectPassportDate(
      BuildContext context,
      TextEditingController controller,
      DatePickerMode initialDatePickerMode,
      bool isPass) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialDatePickerMode: initialDatePickerMode,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DatePickerMode == DatePickerMode.year
            ? "${picked.year}"
            : initialDatePickerMode == DatePickerEntryMode.calendar
                ? "${picked.month}"
                : "${picked.day}";
        if (isPass == false) {
          _updateTextControllers();
        } else {
          _updatePassExpTextControllers();
        }
      });
    }
  }

//Other Passengers Date of Birth
  Future<void> _selectDOB(
    BuildContext context,
    TextEditingController controller,
    DatePickerMode initialDatePickerMode,
    String type,
    int? requiredAge,
  ) async {
    try {
      final DateTime today = DateTime.now();
      final DateTime eighteenYearsAgo = DateTime(today.year - 18, 12, 31);
      DateTime age =
          DateTime.now().subtract(Duration(days: requiredAge! * 365));
      int ageInitial = age.year - 1;
      int ageFinal = age.year + 1;

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: ageInitial == 0 ? eighteenYearsAgo : age,
        firstDate: ageInitial == 0
            ? DateTime(1901)
            : DateTime.parse('$ageInitial-01-01 01:39:59.409476'),
        lastDate: ageInitial == 0
            ? eighteenYearsAgo
            : DateTime.parse('$ageFinal-01-01 01:39:59.409476'),
        initialDatePickerMode: initialDatePickerMode,
      );

      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          controller.text = DatePickerMode == DatePickerMode.year
              ? "${picked.year}"
              : initialDatePickerMode == DatePickerEntryMode.calendar
                  ? "${picked.month}"
                  : "${picked.day}";
          switch (type) {
            case "child1":
              // child1yearController.text =
              //     "${picked.year}-${getMonthAbbreviation(picked.montha)}-${picked.day.toString().padLeft(2, '0')}";
              child1yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "child2":
              child2yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "child3":
              child3yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "child4":
              child4yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "infant1":
              infant1yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "infant2":
              infant2yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "infant3":
              infant3yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "infant4":
              infant4yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "adult2":
              adult2yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "adult3":
              adult3yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            case "adult4":
              adult4yearController.text =
                  "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
              break;
            default:
              print("Unexpected type value: $type");
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _selectExp(
      BuildContext context,
      TextEditingController controller,
      DatePickerMode initialDatePickerMode,
      String type) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      initialDatePickerMode: initialDatePickerMode,
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = DatePickerMode == DatePickerMode.year
            ? "${picked.year}"
            : initialDatePickerMode == DatePickerEntryMode.calendar
                ? "${picked.month}"
                : "${picked.day}";
        switch (type) {
          case "child1":
            child1passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "child2":
            child2passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "child3":
            child3passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "child4":
            child4passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "infant1":
            infant1passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "infant2":
            infant2passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "infant3":
            infant3passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "infant4":
            infant4passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "adult2":
            adult2passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "adult3":
            adult3passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          case "adult4":
            adult4passExpController.text =
                "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
            break;
          default:
            print("Unexpected type value: $type");
        }
      });
    }
  }

  String getMonthAbbreviation(int month) {
    final List<String> monthAbbreviations = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    if (month >= 1 && month <= 12) {
      return monthAbbreviations[month - 1];
    } else {
      return '';
    }
  }

  void _updateTextControllers() {
    yearController.text = "${_selectedDate.year}";
    monthController.text = getMonthAbbreviation(_selectedDate.month);
    // monthController.text = "${_selectedDate.month.toString().padLeft(2, '0')}";
    dayController.text = "${_selectedDate.day.toString().padLeft(2, '0')}";
  }

  void _updatePassExpTextControllers() {
    passportExpiryController.text =
        "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";
  }

  void init() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataController.loadMyData();
    });
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Passenger Details',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                      text: 'Primary Passenger',
                      weight: FontWeight.w600,
                      fontSize: 15.0),
                  0.03.ph,
                  // Custom_textfield_required(
                  //     controller: titleController,
                  //     requiredLabel: 'Title',
                  //     hint: 'Mr',
                  //     validator: (inputValue) {
                  //       if (inputValue!.isEmpty) {
                  //         return "Enter Title";
                  //       }
                  //       return null;
                  //     }),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Title",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: w,
                    height: 35,
                    child: DropdownButton(
                      isDense: true,
                      isExpanded: true,
                      icon: Icon(Icons.arrow_drop_down),
                      value: _selectedTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 44.0),
                      underline: Container(
                        height: 0.7, // Specify the underline height
                        color: Colors.black26, // Specify the underline color
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTitle = newValue;
                        });
                      },
                      items: titleMap.keys
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: CommonText(
                                text: value, weight: FontWeight.w500));
                      }).toList(),
                    ),
                  ),

                  // CommonText(text: "Title: ${titleMap[_selectedTitle!]}"),
                  0.03.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Custom_textfield_required(
                            controller: firstNameController,
                            requiredLabel: 'First Name',
                            hint: 'Enter First Name',
                            validator: (inputValue) {
                              if (inputValue!.isEmpty) {
                                return "Enter First Name";
                              }
                              return null;
                            }),
                      ),
                      Expanded(
                          child: Custom_textfield_required(
                              controller: lastNameController,
                              requiredLabel: 'Last Name',
                              hint: 'Enter Last Name',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Last Name";
                                }
                                return null;
                              })),
                    ],
                  ),
                  0.03.ph,
                  LeftAignHeading(title: "Date of Birth"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: CustomTextField(
                              onTap: () {
                                _selectDate(context, yearController,
                                    DatePickerMode.year, false);
                              },
                              labelText: "Year",
                              textEditingController: yearController,
                              readOnly: true,
                              hintText: 'Year',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Year";
                                }
                                return null;
                              })),
                      Expanded(
                          child: CustomTextField(
                              onTap: () {
                                _selectDate(context, yearController,
                                    DatePickerMode.year, false);
                              },
                              labelText: "Month",
                              readOnly: true,
                              textEditingController: monthController,
                              hintText: 'Month',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Month";
                                }
                                return null;
                              })),
                      Expanded(
                          child: CustomTextField(
                              onTap: () {
                                _selectDate(context, yearController,
                                    DatePickerMode.year, false);
                              },
                              labelText: "Day",
                              readOnly: true,
                              textEditingController: dayController,
                              hintText: 'Day',
                              validator: (inputValue) {
                                if (inputValue!.isEmpty) {
                                  return "Enter Day";
                                }
                                return null;
                              })),
                    ],
                  ),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Nationality",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      textEditingController: nationalityController,
                      hintText: 'Enter Nationality',
                      readOnly: true,
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: false,
                          onSelect: (Country country) {
                            setState(() {
                              _selectedCountry =
                                  "${country.flagEmoji}   ${country.name}";
                              nationalityController.text =
                                  _selectedCountry.toString();
                              number =
                                  PhoneNumber(isoCode: country.countryCode);
                            });
                          },
                        );
                      },
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Nationality";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Custom_textfield_required(
                      controller: passportController,
                      // keyboardType: TextInputType.number,
                      requiredLabel: 'Passport Number',
                      hint: 'Enter Passport',
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Passport Number";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Passport Expiry",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomTextField(
                      onTap: () {
                        _selectPassportDate(context, passportExpiryController,
                            DatePickerMode.year, true);
                      },
                      readOnly: true,
                      textEditingController: passportExpiryController,
                      // labelText: 'Passport Expiry',
                      hintText: 'Enter Expiry',
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Passport Expiry";
                        }
                        return null;
                      }),

                  0.05.ph,
                  CommonText(
                      text: 'Contact Information',
                      weight: FontWeight.w600,
                      fontSize: 15.0),
                  0.03.ph,
                  Custom_textfield_required(
                      // readOnly: true,
                      controller: emailController,
                      requiredLabel: 'Email',
                      hint: 'someone@example.com',
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      }),
                  0.03.ph,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Phone Number",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        setState(() {
                          phoneNumber = numberController.text;
                          phoneCode = number.dialCode!;
                          countryCode = number.isoCode!;
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                          trailingSpace: false,
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useEmoji: true),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.disabled,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      initialValue: number,
                      textFieldController: numberController,
                      formatInput: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      inputBorder: UnderlineInputBorder(),
                      inputDecoration: InputDecoration(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_rounded),
                        hintText: "Enter Number Here",
                        hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                        border: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: AppBorderRadius.circularBorderNormal,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onSaved: (PhoneNumber? number) {
                        if (number != null) {
                          print('On Saved: $number');
                          phoneNumber = number.phoneNumber!;
                          phoneCode = number.dialCode!;
                          countryCode = number.isoCode!;
                        }
                      },
                      validator: (inputValue) {
                        if (inputValue!.isEmpty) {
                          return "Enter Phone Number";
                        }
                        return null;
                      }),
                  Divider(
                    thickness: 2,
                  ),
                  widget.childCount != 0 ||
                          widget.infantCount != 0 ||
                          widget.adultCount! > 1
                      ? Column(
                          children: [
                            0.05.ph,
                            CommonText(
                                text: 'Other Passengers',
                                weight: FontWeight.w600,
                                fontSize: 15.0),
                            0.03.ph,
                          ],
                        )
                      : Container(),

                  widget.adultCount == 2 || widget.adultCount! > 2
                      ? Column(
                          children: [
                            widget.adultCount == 2 || widget.adultCount! > 2
                                ? passengerForm(
                                    context,
                                    "Adult #2",
                                    "adult2",
                                    adult2Controller,
                                    adult2surnameController,
                                    adult2yearController,
                                    adult2natController,
                                    adult2passController,
                                    adult2passExpController,
                                    DateTime.now().year)
                                : Container(),
                            widget.adultCount == 3 || widget.adultCount! > 3
                                ? passengerForm(
                                    context,
                                    "Adult #3",
                                    "adult3",
                                    adult3Controller,
                                    adult3surnameController,
                                    adult3yearController,
                                    adult3natController,
                                    adult3passController,
                                    adult3passExpController,
                                    DateTime.now().year)
                                : Container(),
                            widget.adultCount == 4
                                ? passengerForm(
                                    context,
                                    "Adult #4",
                                    "adult4",
                                    adult4Controller,
                                    adult4surnameController,
                                    adult4yearController,
                                    adult4natController,
                                    adult4passController,
                                    adult4passExpController,
                                    DateTime.now().year)
                                : Container()
                          ],
                        )
                      : Container(),
                  widget.childCount == 1 || widget.childCount! > 1
                      ? Column(
                          children: [
                            0.02.ph,
                            Divider(
                              thickness: 2,
                            ),
                            0.02.ph,
                            passengerForm(
                              context,
                              "Child #1",
                              "child1",
                              child1Controller,
                              child1surnameController,
                              child1yearController,
                              child1natController,
                              child1passController,
                              child1passExpController,
                              widget.child1age,
                            ),
                            widget.childCount == 2 || widget.childCount! > 2
                                ? passengerForm(
                                    context,
                                    "Child #2",
                                    "child2",
                                    child2Controller,
                                    child2surnameController,
                                    child2yearController,
                                    child2natController,
                                    child2passController,
                                    child2passExpController,
                                    widget.child2age,
                                  )
                                : Container(),
                            widget.childCount == 3 || widget.childCount! > 3
                                ? passengerForm(
                                    context,
                                    "Child #3",
                                    "child3",
                                    child3Controller,
                                    child3surnameController,
                                    child3yearController,
                                    child3natController,
                                    child3passController,
                                    child3passExpController,
                                    widget.child3age,
                                  )
                                : Container(),
                            widget.childCount == 4
                                ? passengerForm(
                                    context,
                                    "Child #4",
                                    "child4",
                                    child4Controller,
                                    child4surnameController,
                                    child4yearController,
                                    child4natController,
                                    child4passController,
                                    child4passExpController,
                                    widget.child4age,
                                  )
                                : Container()
                          ],
                        )
                      : Container(),
                  widget.infantCount == 1 || widget.infantCount! > 1
                      ? Column(
                          children: [
                            0.02.ph,
                            Divider(
                              thickness: 2,
                            ),
                            0.02.ph,
                            passengerForm(
                              context,
                              "Infant #1",
                              "infant1",
                              infant1Controller,
                              infant1surnameController,
                              infant1yearController,
                              infant1natController,
                              infant1passController,
                              infant1passExpController,
                              widget.infant1age,
                            ),
                            widget.infantCount == 2 || widget.infantCount! > 2
                                ? passengerForm(
                                    context,
                                    "Infant #2",
                                    "infant2",
                                    infant2Controller,
                                    infant2surnameController,
                                    infant2yearController,
                                    infant2natController,
                                    infant2passController,
                                    infant2passExpController,
                                    widget.infant2age,
                                  )
                                : Container(),
                            widget.infantCount == 3 || widget.infantCount! > 3
                                ? passengerForm(
                                    context,
                                    "Infant #3",
                                    "infant3",
                                    infant3Controller,
                                    infant3surnameController,
                                    infant3yearController,
                                    infant3natController,
                                    infant3passController,
                                    infant3passExpController,
                                    widget.infant3age,
                                  )
                                : Container(),
                            widget.infantCount == 4
                                ? passengerForm(
                                    context,
                                    "Infant #4",
                                    "infant4",
                                    infant4Controller,
                                    infant4surnameController,
                                    infant4yearController,
                                    infant4natController,
                                    infant4passController,
                                    infant4passExpController,
                                    widget.infant4age,
                                  )
                                : Container()
                          ],
                        )
                      : Container(),
                  0.05.ph,
                  CommonText(
                      text: 'Flight Summary',
                      weight: FontWeight.w600,
                      fontSize: 15.0),
                  0.03.ph,
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: FlightSummary(
              fare: widget.fare,
              tax: widget.tax,
              total: widget.total,
              traveller: widget.traveller,
              cabinClass: widget.cabinClass,
              searchID: widget.searchID,
              flightID: widget.flightID,
              departFlight: widget.departFlight,
              arriveFlight: widget.arriveFlight,
              departFromDate1: widget.departFromDate1,
              departFromTime1: widget.departFromTime1,
              departFromCode1: widget.departFromCode1,
              departFromDate2: widget.departFromDate2,
              departFromTime2: widget.departFromTime2,
              departFromCode2: widget.departFromCode2,
              arriveToDate1: widget.arriveToDate1,
              arriveToTime1: widget.arriveToTime1,
              arriveToCode1: widget.arriveToCode1,
              arriveToDate2: widget.arriveToDate2,
              arriveToCode2: widget.arriveToCode2,
              arriveToTime2: widget.arriveToTime2,
              adultCount: widget.adultCount,
              childCount: widget.childCount,
              infantCount: widget.infantCount,
            ),
          ),
          0.03.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomOutlineButton(
                  width: 150,
                  text: "Back",
                  onPress: () {
                    Get.back();
                  }),
              CustomButton(
                  width: 150,
                  text: "Confirm",
                  onPress: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        isValidForm = true;
                        // Get.to(() => PaymentDetailsScreen(
                        Get.to(() => PaymentMethodScreen(
                              title: "${titleMap[_selectedTitle!]}",
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dob:
                                  "${yearController.text}-${_selectedDate.month.toString().padLeft(2, '0')}-${dayController.text}",
                              nationality: nationalityController.text,
                              email: dataController.myEmail.value,
                              passNumber: passportController.text,
                              passExp: passportExpiryController.text,
                              phoneCode: phoneCode,
                              phone: phoneNumber,
                              countryCode: countryCode,
                              fare: widget.fare.toString(),
                              tax: widget.tax.toString(),
                              total: widget.total.toString(),
                              traveller: widget.traveller,
                              cabinClass: widget.cabinClass,
                              searchID: widget.searchID,
                              flightID: widget.flightID,
                              departFlight: widget.departFlight,
                              arriveFlight: widget.arriveFlight,
                              departFromDate1: widget.departFromDate1,
                              departFromTime1: widget.departFromTime1,
                              departFromCode1: widget.departFromCode1,
                              departFromDate2: widget.departFromDate2,
                              departFromTime2: widget.departFromTime2,
                              departFromCode2: widget.departFromCode2,
                              arriveToDate1: widget.arriveToDate1,
                              arriveToTime1: widget.arriveToTime1,
                              arriveToCode1: widget.arriveToCode1,
                              arriveToDate2: widget.arriveToDate2,
                              arriveToCode2: widget.arriveToCode2,
                              arriveToTime2: widget.arriveToTime2,
                              adultCount: widget.adultCount,
                              childCount: widget.childCount,
                              infantCount: widget.infantCount,
                              //
                              adult2name: adult2Controller.text,
                              adult2Lname: adult2surnameController.text,
                              adult2dob: adult2yearController.text,
                              adult2pass: adult2passController.text,
                              adult2passExp: adult2passExpController.text,
                              adult3name: adult3Controller.text,
                              adult3Lname: adult3surnameController.text,
                              adult3dob: adult3yearController.text,
                              adult3pass: adult3passController.text,
                              adult3passExp: adult3passExpController.text,
                              adult4name: adult4Controller.text,
                              adult4Lname: adult4surnameController.text,
                              adult4dob: adult4yearController.text,
                              adult4pass: adult4passController.text,
                              adult4passExp: adult4passController.text,
                              //
                              child1name: child1Controller.text,
                              child1Lname: child1surnameController.text,
                              child1dob: child1yearController.text,
                              child1pass: child1passController.text,
                              child1passExp: child1passExpController.text,
                              child2name: child2Controller.text,
                              child2Lname: child2surnameController.text,
                              child2dob: child2yearController.text,
                              child2pass: child2passController.text,
                              child2passExp: child2passExpController.text,
                              child3name: child3Controller.text,
                              child3Lname: child3surnameController.text,
                              child3dob: child3yearController.text,
                              child3pass: child3passController.text,
                              child3passExp: child3passExpController.text,
                              child4name: child4Controller.text,
                              child4Lname: child4surnameController.text,
                              child4dob: child4yearController.text,
                              child4pass: child4passController.text,
                              child4passExp: child4passExpController.text,
                              //
                              infant1name: infant1Controller.text,
                              infant1Lname: infant1surnameController.text,
                              infant1dob: infant1yearController.text,
                              infant1pass: infant1passController.text,
                              infant1passExp: infant1passExpController.text,
                              infant2name: infant2Controller.text,
                              infant2Lname: infant2surnameController.text,
                              infant2dob: infant2yearController.text,
                              infant2pass: infant2passController.text,
                              infant2passExp: infant2passExpController.text,
                              infant3name: infant3Controller.text,
                              infant3Lname: infant3surnameController.text,
                              infant3dob: infant3yearController.text,
                              infant3pass: infant3passController.text,
                              infant3passExp: infant3passExpController.text,
                              infant4name: infant4Controller.text,
                              infant4Lname: infant4surnameController.text,
                              infant4dob: infant4yearController.text,
                              infant4pass: infant4passController.text,
                              infant4passExp: infant4passExpController.text,
                            ));
                      });
                    } else {
                      setState(() {
                        isValidForm = false;
                      });
                    }
                  }),
            ],
          ),
          0.03.ph,
        ],
      ),
    );
  }

  Container passengerForm(
    BuildContext context,
    String title,
    String type,
    TextEditingController ncontroller,
    TextEditingController scontroller,
    TextEditingController DOBcontroller,
    TextEditingController Natcontroller,
    TextEditingController passController,
    TextEditingController passExpController,
    int? age,
  ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.appColorPrimary.withOpacity(0.5), width: 1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: '$title', weight: FontWeight.w600, fontSize: 13.0),
          0.03.ph,
          Custom_textfield_required(
              controller: ncontroller,
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
              controller: scontroller,
              requiredLabel: 'Last Name',
              hint: 'Last Name',
              validator: (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter Last Name";
                }
                return null;
              }),
          0.03.ph,
          LeftAignHeading(title: "Date of Birth"),
          CustomTextField(
              onTap: () {
                _selectDOB(
                    context, DOBcontroller, DatePickerMode.year, "$type", age);
              },
              labelText: "",
              textEditingController: DOBcontroller,
              readOnly: true,
              hintText: 'Year-Month-Day',
              validator: (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter Year";
                }
                return null;
              }),
          0.03.ph,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Nationality",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          CustomTextField(
              textEditingController: Natcontroller,
              hintText: 'Enter Nationality',
              readOnly: true,
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    setState(() {
                      _selectedCountry =
                          "${country.flagEmoji}   ${country.name}";
                      Natcontroller.text = _selectedCountry.toString();
                      number = PhoneNumber(isoCode: country.countryCode);
                    });
                  },
                );
              },
              validator: (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter Nationality";
                }
                return null;
              }),
          0.03.ph,
          Custom_textfield_required(
              controller: passController,
              requiredLabel: 'Passport Number',
              hint: 'Enter Passport',
              validator: (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter Passport Number";
                }
                return null;
              }),
          0.03.ph,
          LeftAignHeading(title: "Passport Expiry"),
          CustomTextField(
              onTap: () {
                _selectExp(
                    context, passExpController, DatePickerMode.year, "$type");
              },
              readOnly: true,
              textEditingController: passExpController,
              hintText: 'Enter Expiry',
              validator: (inputValue) {
                if (inputValue!.isEmpty) {
                  return "Enter Passport Expiry";
                }
                return null;
              }),
        ],
      ),
    );
  }
}

class LeftAignHeading extends StatelessWidget {
  String? title;
  LeftAignHeading({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class FlightSummary extends StatefulWidget {
  String searchID;
  String flightID;
//
  String departFromDate1;
  String departFromTime1;
  String departFromCode1;
  String departFlight;
  String arriveToDate1;
  String arriveToTime1;
  String arriveToCode1;
  //
  String arriveFlight;
  String departFromDate2;
  String departFromTime2;
  String departFromCode2;
  String arriveToDate2;
  String arriveToTime2;
  String arriveToCode2;
  //
  String traveller;
  String cabinClass;
  String fare;
  String tax;
  String total;
  int? adultCount;
  int? childCount;
  int? infantCount;

  FlightSummary({
    super.key,
    required this.flightID,
    required this.searchID,
    required this.departFlight,
    required this.departFromDate1,
    required this.departFromTime1,
    required this.departFromCode1,
    required this.arriveToDate1,
    required this.arriveToTime1,
    required this.arriveToCode1,
    required this.arriveFlight,
    required this.departFromDate2,
    required this.departFromTime2,
    required this.departFromCode2,
    required this.arriveToDate2,
    required this.arriveToTime2,
    required this.arriveToCode2,
    required this.traveller,
    required this.cabinClass,
    required this.fare,
    required this.tax,
    required this.total,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
  });

  @override
  State<FlightSummary> createState() => _FlightSummaryState();
}

class _FlightSummaryState extends State<FlightSummary> {
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      dashPattern: [10, 8],
      strokeWidth: 1,
      color: AppColors.appColorPrimary,
      child: Container(
        padding: EdgeInsets.fromLTRB(15.0, 15, 15, 30),
        margin: const EdgeInsets.all(20.0),
        // height: h * 0.43,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1st  FROM TO ------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FromToFlightWidget(
                  date: widget.departFromDate1,
                  time: widget.departFromTime1,
                  city: widget.departFromCode1,
                ),
                Column(
                  children: [
                    CommonText(
                      text: widget.departFlight,
                      fontSize: 12.0,
                    ),
                    0.01.ph,
                    Icon(
                      FontAwesomeIcons.plane,
                      color: AppColors.appColorPrimary,
                      size: 20.0,
                    ),
                    0.01.ph,
                    CommonText(
                      text: 'Outbound',
                      fontSize: 8.0,
                    )
                  ],
                ),
                FromToFlightWidget(
                  date: widget.arriveToDate1,
                  time: widget.arriveToTime1,
                  city: widget.arriveToCode1,
                ),
              ],
            ),
            0.02.ph,
            Divider(),
            0.02.ph,
            widget.arriveFlight != ""
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FromToFlightWidget(
                        date: widget.arriveToDate2,
                        time: widget.arriveToTime2,
                        city: widget.arriveToCode2,
                      ),
                      Column(
                        children: [
                          CommonText(
                            text: widget.arriveFlight,
                            fontSize: 12.0,
                          ),
                          0.01.ph,
                          RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              FontAwesomeIcons.plane,
                              color: AppColors.appColorPrimary,
                              size: 20.0,
                            ),
                          ),
                          0.01.ph,
                          CommonText(
                            text: 'Inbound',
                            fontSize: 8.0,
                          )
                        ],
                      ),
                      FromToFlightWidget(
                        date: widget.departFromDate2,
                        time: widget.departFromTime2,
                        city: widget.departFromCode2,
                      ),
                    ],
                  )
                : Container(),
            0.04.ph,
            CommonText(
              text: 'Fare Information',
              weight: FontWeight.w600,
            ),
            0.02.ph,
            CommonText(
              text: "Adult x${widget.adultCount}",
              fontSize: 11,
            ),
            0.02.ph,
            widget.childCount! < 1
                ? SizedBox.shrink()
                : Column(
                    children: [
                      CommonText(
                        text: "Child x${widget.childCount}",
                        fontSize: 11,
                      ),
                      0.02.ph,
                    ],
                  ),

            widget.infantCount! < 1
                ? SizedBox.shrink()
                : Column(
                    children: [
                      CommonText(
                        text: "Infant x${widget.infantCount}",
                        fontSize: 11,
                      ),
                      0.02.ph,
                    ],
                  ),
            CommonText(
              text: widget.cabinClass,
              fontSize: 11,
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Fare',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$${widget.fare}',
                  fontSize: 11,
                ),
              ],
            ),
            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Taxes and Fees',
                  fontSize: 11,
                ),
                CommonText(
                  text: '\$${widget.tax}',
                  fontSize: 11,
                ),
              ],
            ),

            0.02.ph,
            Divider(color: Colors.black),

            0.02.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: 'Total Charges',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
                CommonText(
                  text: '\$${widget.total}',
                  fontSize: 11,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
