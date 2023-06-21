import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:revfood/mainPage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:app_settings/app_settings.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LocationState();
}

List<String> wilaya = ['Mostaganem', 'Oran', 'Alger', 'Mascara'];

class _LocationState extends State<Location> {
  String? dropdownValue;
  String? _currentAddress;
  Position? _currentPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header loc icon and script
            Container(
              margin: const EdgeInsets.only(top: 78),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 40),
                  Text(
                    'Location',
                    style: TextStyle(fontSize: 30, fontFamily: 'poppins'),
                  ),
                ],
              ),
            ),
            // Animation
            Container(
              margin: const EdgeInsets.only(left: 15, top: 50),
              height: 300,
              child: Lottie.asset('assets/animation/Location.json'),
            ),
            // Choosing Location
            const Align(
              alignment: Alignment.centerLeft, // Aligns the text to the left
              child: Padding(
                padding: EdgeInsets.only(left: 40, top: 20),
                child: Text(
                  'Choose A Location :',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
                hint: const Text(
                  'Select Location Here',
                  style: TextStyle(color: Colors.grey),
                ),
                onChanged: (String? value) {
                  setState(() {
                    if (value != '') dropdownValue = value;
                  });
                },
                items: [
                  ...wilaya.map(
                    (value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  ),
                ],
              ),
            ),
            //Button to Go To MainPage Page
            Container(
              margin: const EdgeInsets.only(top: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (dropdownValue == 'Mostaganem') {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }

                  if (_currentAddress == 'Mostaganem') {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                  if (dropdownValue == 'Oran') {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                  if (dropdownValue == 'Alger') {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                  if (dropdownValue == 'Mascara') {
                    Navigator.push(
                      this.context,
                      MaterialPageRoute(builder: (context) => const MainPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    elevation: 3,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color(0xffb22222)),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
              ),
            ),
            //Use GPS
            const Align(
              alignment: Alignment.centerLeft, // Aligns the text to the left
              child: Padding(
                padding: EdgeInsets.only(left: 40, top: 20),
                child: Text(
                  'Use Your current Location :',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            //Button to get location
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                onPressed: () {
                  _getCurrentPosition();
                },
                style: ElevatedButton.styleFrom(
                    elevation: 6,
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255)),
                child: const Text(
                  'Find My Location',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 40, top: 20),
                child: Text(
                  "Location :  ${_currentAddress ?? ""} ",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enable Location Services'),
          content: const Text(
              'Location services are disabled. Do you want to enable them?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                AppSettings.openLocationSettings();
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
          ],
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      String? administrativeArea = place.administrativeArea;

      if (administrativeArea == "Mostaganem Province") {
        administrativeArea = "Mostaganem";
      }

      setState(() {
        _currentAddress = administrativeArea;
      });
    }).catchError((e) {
      debugPrint(e);
    });
    dropdownValue = _currentAddress;
    Fluttertoast.showToast(
      msg: 'Location set to $_currentAddress',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: const Color.fromARGB(178, 0, 0, 0),
      textColor: Colors.white,
    );
  }
}
