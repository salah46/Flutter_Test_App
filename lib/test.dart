import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  late dynamic test = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Essay'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("Notifications")
              .orderBy("createAt", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Failed to fetch messages'),
              );
            }

            if (snapshot.hasData) {
              var file1 = snapshot.data!.docs;
              if (file1.isEmpty) {
                return Text("");
              }
              var reslut = file1.first.data();

              return Center(
                child: Text(reslut.values.toString()),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
