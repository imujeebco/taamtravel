import 'package:flutter/material.dart';
import 'package:travel_app/app/configs/app_size_config.dart';
import 'package:travel_app/app/utils/custom_widgets/common_text.dart';
import 'package:travel_app/app/utils/custom_widgets/custom_appbar.dart';

class CruisesScreen extends StatefulWidget {
  const CruisesScreen({super.key});

  @override
  State<CruisesScreen> createState() => _CruisesScreensState();
}

class _CruisesScreensState extends State<CruisesScreen> {
  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            CommonText(text: 'CruisesScreen'),
          ],
        ),
      ),
    );
  }
}
