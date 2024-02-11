import 'package:flutter/material.dart';
import 'package:flutter_map_essay/doctorPage.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}
class Doctor {
  final String name;
  final String address;  final String phoneNumber;



  Doctor( {required this.phoneNumber,required this.name, required this.address});
}
class _DoctorsListState extends State<DoctorsList> {
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. John Doe',
      address: '"3 Bd Ambroise Brugière, 63100 Clermont-Ferrand, France"',
      phoneNumber: '555-1234',
    ),
    Doctor(
      name: 'Dr. Jane Smith',
      address: "100 Rue de l'Ermitage, 18130 Dun-sur-Auron, France",
      phoneNumber: '555-5678',
    ),
    Doctor(
      name: 'Dr. Robert Johnson',
      address: 'Rte de Bussy, 18130 Dun-sur-Auron, France',
      phoneNumber: '555-9876',
    ),
    Doctor(
      name: 'Dr. Susan Lee',
      address: "camp de l'air, Le Camp, 18130 Dun-sur-Auron, France",
      phoneNumber: '555-1111',
    ),
    Doctor(
      name: 'Dr. Michael Anderson',
      address: 'La Civette, 4 Pl. Jacques Chartier, 18130 Dun-sur-Auron, France',
      phoneNumber: '555-2222',
    ),
    Doctor(
      name: 'Dr. Emily Davis',
      address: '10 Rue des Ponts, 18130 Dun-sur-Auron, France',
      phoneNumber: '555-3333',
    ),
    Doctor(
      name: 'Dr. Christopher White',
      address: 'Rte de Levet, 18130 Dun-sur-Auron, France',
      phoneNumber: '555-4444',
    ),
    Doctor(
      name: 'Dr. Linda Wilson',
      address: '7 Rue de la Croix de Pierre, 18130 Dun-sur-Auron, France',
      phoneNumber: '555-5555',
    ),
    Doctor(
      name: 'Dr. James Taylor',
      address: '177 Rue de Versailles, 78150 Le Chesnay-Rocquencourt, France',
      phoneNumber: '555-6666',
    ),
    Doctor(
      name: 'Dr. Karen Brown',
      address: '104 Bd Raymond Poincaré, 92380 Garches, France',
      phoneNumber: '555-7777',
    ),
    Doctor(
      name: 'Dr. Richard Miller',
      address: '40 Rue Worth, 92150 Suresnes, France',
      phoneNumber: '555-8888',
    ),
    Doctor(
      name: 'Dr. Mary Johnson',
      address: '2 Rte des Tribunes, 75016 Paris, France',
      phoneNumber: '555-9999',
    ),
    Doctor(
      name: 'Dr. William Adams',
      address: 'Champ de Mars, 5 Av. Anatole France, 75007 Paris, France',
      phoneNumber: '555-0000',
    ),
    Doctor(
      name: 'Dr. Jennifer Robinson',
      address: '1 Av. du Colonel Henri Rol-Tanguy, 75014 Paris, France',
      phoneNumber: '555-1235',
    ),
    Doctor(
      name: 'Dr. Charles Davis',
      address: '77 Rue de Varenne, 75007 Paris, France',
      phoneNumber: '555-6789',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Doctors list")),
      body: ListView.builder(itemCount: doctors.length, itemBuilder: (context, index) {
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


