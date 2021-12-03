import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/authintication.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverhight = 200;
  bool isopened = false;

  @override
  Widget build(BuildContext context) {
    final top = coverhight - 20;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(Provider.of<Authinitication>(context, listen: false)
                  .getuserUid)
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: coverhight,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage("img/images.png"),
                              ),
                              Text(
                                snapshots.data!.get("username"),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                snapshots.data!.get("useremail"),
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                            top: top,
                            child: InkWell(
                              onTap: () {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                elevation: 4.0,
                                child: SizedBox(
                                  height: 120,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(Icons.person,
                                                      color: Colors.blue),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                  ),
                                                  const Text("Account"),
                                                ],
                                              ),
                                              const Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 20,
                                                color: Colors.grey,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(
                                                    Icons.location_on_outlined,
                                                    color: Colors.blue),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                ),
                                                const Text("Address"),
                                              ],
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 20,
                                              color: Colors.grey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.shopping_bag_outlined,
                                          color: Colors.blue),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const Text("My Order"),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        const Icon(Icons.payment_outlined,
                                            color: Colors.blue),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                        const Text("Payment Methods"),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.notifications,
                                          color: Colors.blue),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const Text("Notificatios"),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.dark_mode_outlined,
                                          color: Colors.blue),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                      ),
                                      const Text("Dark Mode"),
                                    ],
                                  ),
                                  Switch(
                                      value: isopened,
                                      onChanged: (value) {
                                        setState(() {
                                          isopened = value;
                                        });
                                      })
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: const Text(
                                              "Are you sure to logout?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Provider.of<Authinitication>(
                                                          context,
                                                          listen: false)
                                                      .logout(context);
                                                },
                                                child: Text("Yes")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("NO"))
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.logout,
                                            color: Colors.blue),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                        ),
                                        const Text("Logout"),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 20,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
