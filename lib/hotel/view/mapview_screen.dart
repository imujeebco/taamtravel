import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:typed_data';

import 'package:travel_app/app/configs/app_colors.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class AccommodationsPage extends StatefulWidget {
  @override
  _AccommodationsPageState createState() => _AccommodationsPageState();
}

class _AccommodationsPageState extends State<AccommodationsPage> {
  GoogleMapController? mapController;
  final LatLng _center =
  const LatLng(2.0469, 45.3182); // Coordinates of Mogadishu
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
    List<Map<String, dynamic>> locations = [
      {"lat": 2.0469, "lng": 45.3182, "price": "120"}, // Central Mogadishu
      {
        "lat": 2.0580,
        "lng": 45.3042,
        "price": "240"
      }, // Near the Mogadishu Stadium
      {
        "lat": 2.0349,
        "lng": 45.3438,
        "price": "130"
      }, // Close to Mogadishu University
      {
        "lat": 2.0402,
        "lng": 45.3273,
        "price": "210"
      }, // Aden Adde International Airport
      {"lat": 2.0350, "lng": 45.3375, "price": "500"}, // Liido Beach
      {"lat": 2.0312, "lng": 45.3443, "price": "100"}, // Banadir Hospital
      {"lat": 2.0492, "lng": 45.3044, "price": "70"}, // Mogadishu Lighthouse
      {"lat": 2.0641, "lng": 45.3267, "price": "80"}, // The Village Restaurant
      {"lat": 2.0429, "lng": 45.3316, "price": "250"}, // Mogadishu Mall
      {"lat": 2.0329, "lng": 45.3154, "price": "100"}, // Peace Hotel
      {"lat": 2.0550, "lng": 45.3187, "price": "50"}, // Taleh Park
      {"lat": 2.0434, "lng": 45.3412, "price": "123"}, // Jazeera Beach
      {
        "lat": 2.0287,
        "lng": 45.3184,
        "price": "135"
      }, // Somali National Theatre
    ];

    for (int i = 0; i < locations.length; i++) {
      var location = locations[i];
      final image = await createCustomMarkerImage(location['price']);
      final bytes = await getImageBytes(image);

      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId('marker-${location['price']}'),
            position: LatLng(location['lat'], location['lng']),
            icon: BitmapDescriptor.fromBytes(bytes),
            infoWindow: InfoWindow(
              onTap: () {

              },
              title:
              'Marker ${i + 1}', // Using index + 1 for user-friendly numbering
              snippet:
              'Price: \$${location['price']} at Lat: ${location['lat']}, Lng: ${location['lng']}',
            ),
          ),
        );
      });
    }
  }

  bool _mapInteractionEnabled = true;
  Future<void> _onAddMarkers() async {
    final image = await createCustomMarkerImage("Your Text Here");
    final bytes = await getImageBytes(image);
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(45.521563, -122.677433),
          icon: BitmapDescriptor.fromBytes(bytes),
          infoWindow: InfoWindow(
            title: 'Marker 1',
            snippet: 'This is a snippet for Marker 1',
          ),
        ),
      );

      _markers.add(
        Marker(
          markerId: MarkerId('id-2'),
          position: LatLng(45.525, -122.67),
          icon: BitmapDescriptor.fromBytes(bytes),
          infoWindow: InfoWindow(
            title: 'Marker 2',
            snippet: 'This is a snippet for Marker 2',
          ),
        ),
      );

      // Add more markers if needed
    });
  }

  Future<ui.Image> createCustomMarkerImage(String price) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint();
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    final double width = 100; // Reduced width
    final double height = 80; // Reduced height

    // Draw the pin shape
    paint.color = AppColors.appColorPrimary; // Main color of the pin
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(width / 2, 30), radius: 30)); // Smaller head of the pin
    path.moveTo(width / 2 - 15, 55);
    path.lineTo(width / 2, height); // Tail of the pin
    path.lineTo(width / 2 + 15, 55);
    path.close();
    canvas.drawPath(path, paint);

    // Outline
    paint
      ..color = AppColors.appColorPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3; // Smaller stroke width
    canvas.drawPath(path, paint);

    // Draw the price text
    paint.style = PaintingStyle.fill;
    textPainter.text = TextSpan(
      text: "\$" + price,
      style: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold), // Smaller font size
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(width * 0.5 - textPainter.width * 0.5,
            25)); // Adjusted text position for smaller head

    final ui.Image markerAsImage = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    return markerAsImage;
  }

  Future<Uint8List> getImageBytes(ui.Image image) async {
    final ByteData? byteData =
    await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    await Permission.location.request();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Demo'),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        height: 300,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onVerticalDragUpdate: (_) {},
          child: AbsorbPointer(
            absorbing: !_mapInteractionEnabled,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers,
              myLocationEnabled: true,
              gestureRecognizers: <Factory<
                  OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  // Set<Marker> _createMarkers() {
  //   return {
  //     Marker(
  //       markerId: MarkerId('exampleMarker'),
  //       position: _initialPosition,
  //       infoWindow: InfoWindow(
  //         title: 'Example Accommodation',
  //         snippet: 'US\$34 per night',
  //       ),
  //     ),
  //   };
  // }
}

class AccommodationDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Image.network(
            //   'https://via.placeholder.com/150',
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Roda Links Al Nasr',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('⭐ 4.0'),
                  SizedBox(height: 8),
                  Text('Nice'),
                  SizedBox(height: 8),
                  Text('1 Classic Double or Twin'),
                  SizedBox(height: 8),
                  Text('ROOM ONLY'),
                ],
              ),
            ),
            Text(
              'US\$34',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.filter_list),
      label: Text('Filters'),
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}