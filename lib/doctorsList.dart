import 'package:flutter/material.dart';
import 'package:flutter_map_essay/doctorPage.dart';

import 'doctor.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {


  @override
  Widget build(BuildContext context) {
    List<Doctor> doctors = Doctor.doctors;
    return Scaffold(
      appBar: AppBar(title:const Text("Doctors list")),
      body: ListView.builder(itemCount:doctors.length, itemBuilder: (context, index) {
        var doctor = doctors[index];
        var url ='https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9jdG9yfGVufDB8fDB8fHww';

        return Card(
          child: ListTile(
            leading:  CircleAvatar(
              radius:50,
                backgroundImage:  NetworkImage(url)),
            title: Text(doctor.name),
            subtitle: Text(doctor.address),
            onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DoctorPage(doctor: doctor);
                },));
            },
          ),
        );
      },),
    );
  }
}


