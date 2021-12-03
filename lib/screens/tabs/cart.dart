import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/authintication.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Cart",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      bottomSheet: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("user")
                      .doc(Provider.of<Authinitication>(context, listen: false)
                          .getuserUid)
                      .collection("carts")
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.hasData) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total items:${snapshots.data!.docs.length}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\$${snapshots.data!.docs.length * 150 * count}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      );
                    } else {
                      return const Center();
                    }
                  }),
              MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: const Text(
                    "Checkout",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.black, msg: "Check your email");
                  })
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection("user")
                    .doc(Provider.of<Authinitication>(context, listen: false)
                        .getuserUid)
                    .collection("carts")
                    .snapshots(),
                builder: (_, snapshots) {
                  if (snapshots.hasData) {
                    final docs = snapshots.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return Stack(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 5,
                                child: SizedBox(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                height: 80,
                                                width: 80,
                                                imageUrl: data["image"]),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              data["productname"],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              "\$${count * 150}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.blue),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: SizedBox(
                                    child: Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                if (count > 1) {
                                                  count--;
                                                }
                                              });
                                            },
                                            child: const Text(
                                              "-",
                                              style: TextStyle(fontSize: 20),
                                            )),
                                        Text(
                                          "$count",
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                count++;
                                              });
                                            },
                                            child: const Text("+"))
                                      ],
                                    ),
                                  )),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection("user")
                                            .doc(Provider.of<Authinitication>(
                                                    context,
                                                    listen: false)
                                                .getuserUid)
                                            .collection("carts")
                                            .doc(data["productname"])
                                            .delete()
                                            .whenComplete(() {
                                          Fluttertoast.showToast(
                                              gravity: ToastGravity.CENTER,
                                              msg: "Items removed");
                                        });
                                      },
                                      icon: const Icon(Icons.close)))
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
