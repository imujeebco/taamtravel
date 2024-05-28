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

class RoomDetailsScreen extends StatefulWidget {
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

  RoomDetailsScreen({
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
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network('https://cdn5.travelconline.com/unsafe/fit-in/2000x0/filters:quality(75):format(webp)/https%3A%2F%2Fi.travelapi.com%2Flodging%2F91000000%2F90120000%2F90113500%2F90113432%2F0ee5b7ff_z.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
              SizedBox(height: 8),
              Text(
                'Accommodation in Nairobi',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'US\$41',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(US\$82 Total price)',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Confirm',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(width: 8),
                  Text('2 Adults'),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text('26 May 2024 - 31 May 2024'),
                ],
              ),
              SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: Text('Change your trip'),
              ),
              SizedBox(height: 16),
              Container(
                color: Colors.green[100],
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.add),
                        SizedBox(height: 8),
                        Text('Add Activity'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.directions_car),
                        SizedBox(height: 8),
                        Text('Add Transfer'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Red Buffalo House Hotel',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                        Icon(Icons.star, color: Colors.orange),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.bed),
                        SizedBox(width: 8),
                        Text('1 Standard double room'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.restaurant),
                        SizedBox(width: 8),
                        Text('ROOM ONLY'),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'With a stay at Red Buffalo House Hotel in Nairobi, '
                          'you\'ll be 1.1 mi (1.8 km) from Nairobi National Park '
                          'and 8 mi (12.8 km) from Karen Blixen Museum. '
                          'This guesthouse is 9.7 mi (15.5 km) from United Nations '
                          'Office at Nairobi and 12 mi (19.4 km) from Thika Road Mall.'
                          'Take in the views from a garden and make use of amenities '
                          'such as complimentary wireless internet access...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    TextButton(
                      onPressed: () {},
                      child: Text('See details'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              ConfirmTripCard(),
            ],
          ),
        ),
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

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ConfirmTripCard(),
//           ),
//         ),
//       ),
//     );
//   }
// }

class ConfirmTripCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'CONFIRM TRIP:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.credit_card, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Total price',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'US\$34',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    'US\$17 Per person',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.save),
              label: Text('Save'),
              style: ElevatedButton.styleFrom(
                primary: Colors.grey[200],
                onPrimary: Colors.black,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: Text('Confirm'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}