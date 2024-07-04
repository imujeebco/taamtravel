import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AccommodationsPage extends StatefulWidget {
  @override
  _AccommodationsPageState createState() => _AccommodationsPageState();
}

class _AccommodationsPageState extends State<AccommodationsPage> {
  late GoogleMapController mapController;
  final LatLng _initialPosition = LatLng(25.276987, 55.296249); // Dubai coordinates
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1,021 Accommodations in Dubai'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text('(738 Hotels - 283 Houses and Apartments)'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            onMapCreated: _onMapCreated,
            markers: _createMarkers(),
          ),
          // Positioned(
          //   bottom: 16,
          //   left: 16,
          //   right: 16,
          //   child: AccommodationDetailsCard(),
          // ),
          Positioned(
            bottom: 16,
            left: 16,
            child: FiltersButton(),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return {
      Marker(
        markerId: MarkerId('exampleMarker'),
        position: _initialPosition,
        infoWindow: InfoWindow(
          title: 'Example Accommodation',
          snippet: 'US\$34 per night',
        ),
      ),
    };
  }
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
            Image.network(
              'https://via.placeholder.com/150',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
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