import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_essay/labs_results/model/labs_results_model.dart';

class LabsResluts extends StatefulWidget {
  const LabsResluts({Key? key}) : super(key: key);

  @override
  State<LabsResluts> createState() => _LabsReslutsState();
}

class _LabsReslutsState extends State<LabsResluts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labs Results'),
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

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            var documents = snapshot.data!.docs;

            return GridView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                var result = documents[index].data();
                LabsReslutsModel labsReslutsModel =
                    LabsReslutsModel(body: result["B1"], head: result["H1"]);
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const Placeholder();
                    },
                  )),
                  child: Card(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          height: 100,
                          child: Image.network(
                              fit: BoxFit.cover,
                              "https://vectorstate.com/stock-photo-preview/106686752/ist_15344_366246.jpg")),
                      Text(
                        labsReslutsModel.head,
                        style: Theme.of(context).textTheme.headlineSmall,
                      )
                    ],
                  )),
                );
                // You can customize the ListTile as needed
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            );
          },
        ),
      ),
    );
  }
}

