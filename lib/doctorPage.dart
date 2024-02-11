// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_map_essay/doctorsList.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';




class DoctorPage extends StatefulWidget {
  final Doctor doctor;

  const DoctorPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  var url =
      'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9jdG9yfGVufDB8fDB8fHww';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Card(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: NetworkImage(url),
                    ),
                  ),
                  Text(widget.doctor.name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(style:ButtonStyle(

                        ),
                            onPressed: () {
                              _makeMailTo('garroudjimohamedse@gmail.com');
                            },
                            icon: Icon(
                              Icons.email,

                            )),
                      ),
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              _makePhoneCall(widget.doctor.phoneNumber);
                            },
                            icon: Icon(
                              Icons.call,
                            )),
                      ),
                      CircleAvatar(
                        radius: 30,
                        child: IconButton(
                            onPressed: () {
                              _openGoogleMapsWithAddress();
                            },
                            icon: Icon(
                              Icons.location_city,

                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
                // flex: 2,
                child: Container(

                  // decoration: BoxDecoration(
                  //   color: Colors.blue,
                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)), // Adjust the radius as needed
                  // ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [

                  Container(
                      margin: EdgeInsets.only(top: 20,),
                      child: Text(" About me",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold))),

                Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                        "\n"
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                    ,style:TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                      wordSpacing: 2.0,
                      decorationThickness: 2.0,
                    ),),
                  )
              ],
            ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: '',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  Future<void> _makeMailTo(String mailAddress) async{
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    await launchUrl(launchUri);
  }
  _openGoogleMapsWithAddress() async{
    MapsLauncher.launchQuery("3 Bd Ambroise Brugière, 63100 Clermont-Ferrand, France");
    // MapsLauncher.launchCoordinates(37.4220041, -122.0862462);

  }


  }



