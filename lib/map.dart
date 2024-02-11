// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class MapEssay extends StatefulWidget {
  const MapEssay({super.key});

  @override
  State<MapEssay> createState() => _MapEssayState();
}


List<List<String>> doctorsList = [
  [
    "A",
    "3 Bd Ambroise Brugière, 63100 Clermont-Ferrand, France",
    "Pediatrician"
  ],
  [
    "B",
    "Centre Commercial Casino Le Brézet, 63100 Clermont-Ferrand, France",
    "Internal Medicine"
  ],
  [
    "C",
    "6 Rue Nicolas Joseph Cugnot, 63100 Clermont-Ferrand, France",
    "Dermatologist"
  ],
];

MapController _mapController = MapController();
List<dynamic> c = <dynamic>[];
Marker? m;
List<Marker> markers = <Marker>[];
int mode = 0;
// Modify _location to accept a callback function
void _location(String address, Function(List<double>) onLocationFound) async {
  List<Location> locations = await locationFromAddress(address);
  if (locations.isNotEmpty) {
    double latitude = locations[0].latitude;
    double longitude = locations[0].longitude;
    onLocationFound(
        [latitude, longitude]); // Call the callback with coordinates
  } else {
    print("Unable to retrieve coordinates for the given address.");
    onLocationFound([]); // Call the callback with empty coordinates
  }
}

// Modify _buildMarkers to use the callback mechanism

_buildMarkers() {
  markers = <Marker>[];
  for (int i = 0; i < doctorsList.length; i++) {
    var address = doctorsList[i][1].toString();
    _location(address, (coordinates) {
      if (coordinates.isNotEmpty) {
        markers.add(Marker(
          point: LatLng(coordinates[0], coordinates[1]),
          builder: (context) {
            return Icon(
              Icons.medical_services,
            );
          },
        ));
        print(address);
      } else {
        print("Error retrieving coordinates for $address.");
      }
    });
  }
  return markers;
}


List _specificMark(String target) {
  for (int i = 0; i < doctorsList.length; i++) {
    var doctorName = doctorsList[i][0];
    if (doctorName == target) {
      var address = doctorsList[i][1].toString();
      _location(address, (coordinates) {
        if (coordinates.isNotEmpty) {
          c.add(coordinates[0]);
          c.add(coordinates[1]);
          m = Marker(
            point: LatLng(coordinates[0], coordinates[1]),
            builder: (context) {
              return Icon(
                Icons.medical_services,
                color: Colors.deepOrange,
              );
            },
          );
          markers.add(Marker(
            point: LatLng(coordinates[0], coordinates[1]),
            builder: (context) {
              return Icon(
                Icons.medical_services,
                color: Colors.deepOrange,
              );
            },
          ));
          print("$address " + coordinates.toString());
          c.add(markers);
          return c;
        } else {
          print("Error retrieving coordinates for $address.");
          // Return null explicitly when coordinates are empty
          return null;
        }
      });
      break;
    }
  }
  // Return null if the loop completes without finding a match
  return [];
}

List<Marker> _BuildSpecificMark() {
  List<Marker> specificMarkers = <Marker>[];
  print(m.toString());
  if (m != null) {
    specificMarkers.add(m!);
    return specificMarkers;
  } else {
    print("Error retrieving specific markers.");
    return specificMarkers;
  }
}

/*_location(String address) async {
  LatLng point = LatLng(35.29280246371011, -1.1240494389160105);
  List<Location> locations = await locationFromAddress(address);
  if (locations.isNotEmpty) {
    double latitude = locations[0].latitude;
    double longitude = locations[0].longitude;
    point.latitude = latitude;
    point.longitude = longitude;
    return [latitude, longitude];
  } else {
    print("Unable to retrieve coordinates for the given address.");
    return [];
  }
}

List<Marker> _buildMarkers()  {
  final markers = <Marker>[];
  for (int i = 0; i < doctorsList.length; i++) {
    var address = doctorsList[i][1].toString();
    List<double> coordinates = await _location(address);
    if (coordinates.isNotEmpty) {
      markers.add(Marker(
        point: LatLng(coordinates[0], coordinates[1]),
        builder: (context) {
          return Icon(
            Icons.pin,
          );
        },
      ));
      print(address);
    } else {
      print("Error retrieving coordinates for $address.");
    }
  }
  return markers;
}*/

TextEditingController _textController = TextEditingController();

class _MapEssayState extends State<MapEssay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(35.29280246371011, -1.1240494389160105),
          zoom: 18.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
              markers: mode == 0 ? _buildMarkers() : _BuildSpecificMark()),
        ],
      ),
      floatingActionButton: _buildFloatingActionButtons(),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 70,
        ),
        Container(
          color: Colors.white,
          margin: EdgeInsets.all(50),
          child: TextField(
            controller: _textController,
            onChanged: (value) {
              _textController.text = value;
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      mode = 1;
                      markers.clear();
                    });

                    try {
                      await _specificMark(_textController.text);

                      _mapController.move(
                        LatLng(c[0] ?? 0.0, c[1] ?? 0.0),
                        14,
                      );

                      setState(() {
                        markers = _BuildSpecificMark();
                      });

                      c.clear();
                    } catch (e) {
                      // Handle errors or display a snackbar
                      print("Error getting LatLng: $e");
                      // Show a snackbar or handle the error in a way that fits your app
                    }
                  },
                  child: Text("getSpecificPostion"),
                ),
                ElevatedButton(
                  child: Text("getAllPositions"),
                  onPressed: () {
                    setState(() {
                      mode = 0;
                      markers = _buildMarkers();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
