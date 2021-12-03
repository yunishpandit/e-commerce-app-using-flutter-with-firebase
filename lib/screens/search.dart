import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/screens/details.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({Key? key}) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController controller = TextEditingController();
  String _issearch = "";

  navigatordetailspage(BuildContext context, DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Detailspage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: controller,
                onSubmitted: (value) {
                  setState(() {
                    _issearch = value;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controller.clear(),
                        icon: const Icon(Icons.clear)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Search here"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: _issearch.isEmpty
                    ? FirebaseFirestore.instance
                        .collection("products")
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection("products")
                        .where("name", isEqualTo: _issearch)
                        .snapshots(),
                builder: (_, snapshots) {
                  if (snapshots.hasData) {
                    final docs = snapshots.data!.docs;
                    return GridView.builder(
                        shrinkWrap: true,
                        itemCount: docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 4, crossAxisCount: 2),
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return InkWell(
                            onTap: () {
                              navigatordetailspage(context, docs[i]);
                            },
                            child: SizedBox(
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 130,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      data["imageurl"]),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data["name"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "\$150",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    // const Text("Star:4.5")
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
