import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:travel_app/app/configs/app_colors.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_textfield.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  TextEditingController pnrnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15.0),
                width: 125,
                height: 125,
                child: Center(
                  child: QrImageView(
                    padding: EdgeInsets.zero,
                    // ignore: deprecated_member_use
                    foregroundColor: AppColors.appColorBlack,
                    data: '12Sh321',
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ),
            const CommonText(
              text: 'QR Check-Ins',
              weight: FontWeight.bold,
              fontSize: 22.0,
            ),
            const CommonText(
              text: 'Click on QR Code to Scan',
              // weight: FontWeight.bold,
              fontSize: 16.0,
            ),

            // TEXT FIELD ------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Row(
                      children: [
                        CommonText(
                          text: 'PNRN',
                          weight: FontWeight.bold,
                        ),
                        CommonText(
                          text: '*',
                          color: Colors.red,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                  ),
                  CustomTextField(
                    textEditingController: pnrnController,
                    hintText: 'Please Enter PNRN',
                    // labelText: 'PNRN',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
