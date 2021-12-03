import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping/screens/details.dart';
import 'package:shopping/screens/search.dart';

class Seeall extends StatefulWidget {
  const Seeall({Key? key}) : super(key: key);

  @override
  _SeeallState createState() => _SeeallState();
}

class _SeeallState extends State<Seeall> {
  navigatordetailspage(BuildContext context, DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Detailspage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.blue),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Searchpage()));
                },
                icon: const Icon(Icons.search))
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.blue,
            isScrollable: true,
            tabs: [
              Tab(
                text: "Related",
              ),
              Tab(
                text: "Best seller",
              ),
              Tab(
                text: "Newest",
              ),
              Tab(
                text: "Price",
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.hasData) {
                      final docs = snapshots.data!.docs;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            shrinkWrap: true,
                            itemCount: docs.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 6, crossAxisCount: 2),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              height: 120,
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
                            }),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
