import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/details.dart';
import 'package:shopping/services/authintication.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  navigartordetails(DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Detailspage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("user")
                      .doc(Provider.of<Authinitication>(context, listen: false)
                          .getuserUid)
                      .collection("favoriteitems")
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
                              onTap: () {},
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
                                          Positioned(
                                              right: 0,
                                              top: 0,
                                              child: IconButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("user")
                                                        .doc(Provider.of<
                                                                    Authinitication>(
                                                                context,
                                                                listen: false)
                                                            .getuserUid)
                                                        .collection(
                                                            "favoriteitems")
                                                        .doc(
                                                            data["productname"])
                                                        .delete()
                                                        .whenComplete(() {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "${data["productname"]} removed");
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                  ))),
                                        ],
                                      ),
                                      Text(
                                        data["productname"],
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
