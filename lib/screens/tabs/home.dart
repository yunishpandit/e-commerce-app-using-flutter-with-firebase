import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/details.dart';
import 'package:shopping/screens/search.dart';
import 'package:shopping/screens/seeall.dart';
import 'package:shopping/services/firebaseoperation.dart';
import 'package:shopping/utiles/categories.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var activeindex = 0;
  navigatordetailspage(BuildContext context, DocumentSnapshot post) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Detailspage(post: post)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          ],
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
                      return Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: docs.length,
                              itemBuilder: (BuildContext context, int i,
                                  int pageViewIndex) {
                                final data = docs[i].data();
                                return Container(
                                  height: 100,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            data["imageurl"],
                                          )),
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey[350]),
                                );
                              },
                              options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      activeindex = index;
                                    });
                                  },
                                  initialPage: 0,
                                  autoPlay: true,
                                  viewportFraction: 0.9,
                                  aspectRatio: 2.2,
                                  enlargeCenterPage: true)),
                          const SizedBox(
                            height: 20,
                          ),
                          AnimatedSmoothIndicator(
                              curve: Curves.easeInOutQuint,
                              activeIndex: activeindex,
                              count: docs.length)
                        ],
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                    }
                  }),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See all",
                          style: TextStyle(color: Colors.black54),
                        )),
                  ],
                ),
              ),
              const Categories(),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Top of the week",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Seeall()));
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(color: Colors.black54),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.hasData) {
                      final docs = snapshots.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return InkWell(
                            onTap: () {
                              navigatordetailspage(context, docs[i]);
                            },
                            child: SizedBox(
                              height: 200,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 150,
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
                                                onPressed: () {
                                                  Provider.of<Firebaseoperation>(
                                                          context,
                                                          listen: false)
                                                      .favoriteitems(
                                                          context,
                                                          {
                                                            "productname":
                                                                data["name"],
                                                            "imageurl":
                                                                data["imageurl"]
                                                          },
                                                          data["name"])
                                                      .whenComplete(() {
                                                    Fluttertoast.showToast(
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        msg:
                                                            "${data["name"]} added to favorite");
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey,
                                                ))),
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
                                    const Text("Star:4.5")
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: docs.length,
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Seeall()));
                        },
                        child: const Text(
                          "See all",
                          style: TextStyle(color: Colors.black54),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection("products")
                      .snapshots(),
                  builder: (_, snapshots) {
                    if (snapshots.hasData) {
                      final docs = snapshots.data!.docs;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return InkWell(
                            onTap: () {
                              navigatordetailspage(context, docs[i]);
                            },
                            child: SizedBox(
                              height: 200,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          height: 150,
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
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.grey,
                                                ))),
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
                                    const Text("Star:4.5")
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: docs.length,
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
