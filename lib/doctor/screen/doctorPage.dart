// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../model/doctor.dart';

class DoctorPage extends StatefulWidget {
  final Doctor doctor;
  final String url;

  const DoctorPage(  {Key? key, required this.doctor, required this.url}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
        elevation: 0,
        shape: Border.all(color:Colors.blue, width: 0),

      ),
      body: Column(

        children: [
          Expanded(

            child: ClipPath(
              clipper:MyClipper() ,
              child: Container(
                decoration: BoxDecoration(color:Colors.blue,),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    Container(

                      child: CircleAvatar(
                        radius: 120,
                        backgroundImage: NetworkImage(widget.url),
                      ),
                    ),
                    Text(
                      widget.doctor.name,
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(

                              style: ButtonStyle(),
                              onPressed: () {
                                _makeMailTo('garroudjimohamedse@gmail.com');
                              },
                              icon: Icon(
                                color:Colors.white,
                                Icons.mail,
                              )),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                          color: Colors.white,
                              onPressed: () {
                                _makePhoneCall(widget.doctor.phoneNumber);
                              },
                              icon: Icon(
                                Icons.call,
                              )),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                _makeSms(widget.doctor.phoneNumber);
                              },
                              icon: Icon(
                                Icons.sms,
                              )),
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              color: Colors.white,
                              onPressed: () {
                                _openGoogleMapsWithAddress(widget.doctor.address);
                              },
                              icon: Icon(
                                Icons.map_sharp,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              // flex: 2,
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)), // Adjust the radius as needed
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: 20,
                    ),
                    child: Text(" About me",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold))),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "\n"
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                      wordSpacing: 2.0,
                      decorationThickness: 2.0,
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {

    final url = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makeMailTo(String mailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailAddress,

    );
    await launchUrl(launchUri);

  }

  _openGoogleMapsWithAddress(String address) async {
    MapsLauncher.launchQuery(address);
    // MapsLauncher.launchCoordinates(37.4220041, -122.0862462);
  }

  Future<void> _makeSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height - 60, size.width, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }}
