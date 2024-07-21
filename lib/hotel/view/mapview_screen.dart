import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:travel_app/hotel/view/Hotel_tabs/search_hotel_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/booking_request.dart';
import 'hotel_details.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: AccommodationScreen(),
//     );
//   }
// }

class AccommodationScreen extends StatefulWidget {

  List<Hotels>? hotels;
  Hotels? _selectedHotel;
  Map dataMap;
  String Id;

  AccommodationScreen(this.hotels, this.dataMap, this.Id);

  @override
  _AccommodationScreenState createState() => _AccommodationScreenState();
}

class _AccommodationScreenState extends State<AccommodationScreen> {
  bool _showCard = false;
  Hotels? _selectedHotel;
  Set<Marker> _markers = {};
  LatLng? _coordinates;

  @override
  void initState() {
    super.initState();

    String jsonString = jsonEncode(widget.dataMap);

    var bookingRequest = BookingRequest.fromJson(json.decode(jsonString));

    _getCoordinates(bookingRequest.destination ?? '');

    //var h = widget.hotels;
  }

  Future<void> _getCoordinates(String address) async {
    final String apiKey = 'AIzaSyDthz0NKdaynPtzwSKYuHcLWkdIFHGC7kg';
    final String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          _coordinates = LatLng(location['lat'], location['lng']);
          //'Latitude: ${location['lat']}, Longitude: ${location['lng']}';
          _setCustomMarkers();
        });
      } else {
        setState(() {
          _coordinates = null;
        });
      }
    } else {
      setState(() {
        //_coordinates = 'Failed to fetch coordinates';
      });
    }
  }

  Future<void> _setCustomMarkers() async {
    Set<Marker> markers = {};
    for (var hotel in widget.hotels!) {
      final BitmapDescriptor markerIcon = await _createCustomMarker(
        hotel,
        hotel.selected ?? false ? Colors.green : Colors.white,
      );

      String? latitudeString = hotel.latitude; // Example value from your data source
      String? longitudeString = hotel.longitude; // Example value from your data source

      double? latitude = latitudeString != null ? double.tryParse(latitudeString) : null;
      double? longitude = longitudeString != null ? double.tryParse(longitudeString) : null;

      if (latitude != null && longitude != null) {
        final marker = Marker(
          markerId: MarkerId(hotel.id.toString()), // Ensure you have a unique ID
          position: LatLng(latitude, longitude), // Ensure you have the latitude and longitude
          icon: markerIcon,
          onTap: () {
            setState(() {
              _selectedHotel = hotel;

              widget.hotels?.forEach((element) {
                element.selected = false;
              });
              hotel.selected = true;
              _showCard = true;
              _setCustomMarkers();
            });
          },
        );
        markers.add(marker);
      } else {
        // Handle the case where the conversion fails
        print("Invalid latitude or longitude");
      }

    }

    setState(() {
      _markers = markers;
    });
  }

  // Future<void> _setCustomMarkers() async {
  //   final selectedMarker = await _createCustomMarker('298', Colors.green);
  //   final unselectedMarker = await _createCustomMarker('298', Colors.white);
  //
  //   setState(() {
  //     _markers = {
  //       Marker(
  //         markerId: MarkerId('1'),
  //         position: LatLng(25.276987, 55.296249),
  //         icon: _selectedMarkerId == MarkerId('1') ? selectedMarker : unselectedMarker,
  //         onTap: () {
  //           setState(() {
  //             _selectedMarkerId = MarkerId('1');
  //             _showCard = true;
  //             _setCustomMarkers();
  //           });
  //         },
  //       ),
  //       // Add other markers here
  //     };
  //   });
  // }

  Future<BitmapDescriptor> _createCustomMarker(Hotels hotel, Color color) async {
    final ui.Image markerImage = await createCustomMarkerImage(hotel, color);
    final ByteData? byteData = await markerImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List uint8List = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<ui.Image> createCustomMarkerImage(Hotels hotel, Color color) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint();
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw the price text to measure its width
    textPainter.text = TextSpan(
      text: '${hotel.currency} ' + hotel.totalAmount.toString(),
      style: TextStyle(
        fontSize: 18,
        color: color == Colors.white ? Colors.black : Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();

    final double textWidth = textPainter.width;
    final double textHeight = textPainter.height;

    // Calculate width and height based on text size
    final double padding = 10;
    final double cornerRadius = 10;
    final double width = textWidth + 2 * padding; // Add padding on both sides
    final double height = textHeight + 2 * padding + 20; // Add padding and space for the tail

    // Draw the pin shape
    paint.color = color; // Main color of the pin
    Path path = Path();
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, width, textHeight + 2 * padding), Radius.circular(cornerRadius))); // Rectangle with rounded corners
    path.moveTo(width / 2 - 10, textHeight + 2 * padding);
    path.lineTo(width / 2, height);
    path.lineTo(width / 2 + 10, textHeight + 2 * padding);
    path.close();
    canvas.drawPath(path, paint);

    // Outline
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2; // Stroke width for the outline
    canvas.drawPath(path, paint);

    // Draw the price text
    paint.style = PaintingStyle.fill;
    textPainter.paint(canvas, Offset(padding, padding)); // Add padding around the text

    final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
    return markerAsImage;
  }

  // Future<ui.Image> createCustomMarkerImage(String price, Color color) async {
  //   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  //   final Canvas canvas = Canvas(pictureRecorder);
  //   final Paint paint = Paint();
  //   final TextPainter textPainter = TextPainter(
  //     textDirection: TextDirection.ltr,
  //   );
  //
  //   // Draw the price text to measure its width
  //   textPainter.text = TextSpan(
  //     text: "US\$" + price,
  //     style: TextStyle(
  //       fontSize: 18,
  //       color: Colors.white,
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  //   textPainter.layout();
  //
  //   final double textWidth = textPainter.width;
  //   final double textHeight = textPainter.height;
  //
  //   // Calculate width and height based on text size
  //   final double width = textWidth + 20; // Add padding
  //   final double height = textHeight + 50; // Add padding and space for the tail
  //
  //   // Draw the pin shape
  //   paint.color = color; // Main color of the pin
  //   Path path = Path();
  //   path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, width, textHeight + 20), Radius.circular(10))); // Rectangle with rounded corners
  //   path.moveTo(width / 2 - 10, textHeight + 20);
  //   path.lineTo(width / 2, height);
  //   path.lineTo(width / 2 + 10, textHeight + 20);
  //   path.close();
  //   canvas.drawPath(path, paint);
  //
  //   // Outline
  //   paint
  //     ..color = Colors.black
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 3; // Smaller stroke width
  //   canvas.drawPath(path, paint);
  //
  //   // Draw the price text
  //   paint.style = PaintingStyle.fill;
  //   textPainter.paint(canvas, Offset((width - textWidth) / 2, 10)); // Center the text
  //
  //   final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
  //   return markerAsImage;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Accommodations',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '(${widget.hotels?.length} Hotels)',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: _coordinates == null ? Center(
        child: CircularProgressIndicator(),
      ) : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _coordinates!,
              zoom: 12,
            ),
            markers: _markers,
          ),
          if (_showCard)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: AccommodationCard(onClose: () {
                setState(() {
                  _showCard = false;
                  _selectedHotel = null;
                  _setCustomMarkers();
                });
              }, hotel: _selectedHotel!, dataMap: widget.dataMap, Id: widget.Id,),
            ),
          // Positioned(
          //   bottom: 80,
          //   left: 20,
          //   child: FloatingActionButton(
          //     onPressed: () {},
          //     child: Icon(Icons.filter_list),
          //     backgroundColor: Colors.green,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AccommodationCard extends StatelessWidget {
  final VoidCallback onClose;
  final Hotels hotel;
  Map dataMap;
  String Id;

  AccommodationCard({required this.onClose,required this.hotel,required this.dataMap,required this.Id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(() => HotelDetailsScreen(dataMap: dataMap , hotel: hotel,searchId: Id,
        ));
      },
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 15.0),
                    child: Text(
                      hotel.hotelName ?? '',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // Set the maximum number of lines you want
                      overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: onClose,
                ),
              ],
            ),
            ListTile(
              leading: Image.network(
                '${hotel.imageUrls?[0]}',
                // width: 100,
                // height: 100,
                fit: BoxFit.cover,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${hotel.address ?? ''}'),
                  Row(
                    children: [
                      Icon(Icons.bed_sharp),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          hotel.room ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          maxLines: 2, // Set the maximum number of lines you want
                          overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                        ),
                      ),
                    ],
                  ),
                  Text('${hotel.currency ?? ''} ${hotel.totalAmount.toString()}'),
                ],
              ),
              // trailing: IconButton(
              //   icon: Icon(Icons.favorite_border),
              //   onPressed: () {},
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
