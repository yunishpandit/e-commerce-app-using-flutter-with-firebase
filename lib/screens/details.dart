import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/firebaseoperation.dart';

class Detailspage extends StatefulWidget {
  final DocumentSnapshot post;

  const Detailspage({Key? key, required this.post}) : super(key: key);

  @override
  _DetailspageState createState() => _DetailspageState();
}

class _DetailspageState extends State<Detailspage> {
  bool isliked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomSheet: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: MaterialButton(
              height: 50,
              minWidth: 100,
              color: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.shopping_cart),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add to cart")
                ],
              ),
              onPressed: () {
                Provider.of<Firebaseoperation>(context, listen: false)
                    .cartitems(
                        context,
                        {
                          "productname": widget.post["name"],
                          "image": widget.post["imageurl"],
                        },
                        widget.post["name"])
                    .whenComplete(() {
                  Fluttertoast.showToast(
                      gravity: ToastGravity.CENTER,
                      msg: "${widget.post["name"]} added to cart");
                });
              })),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: MediaQuery.of(context).size.width,
              child: CachedNetworkImage(
                imageUrl: widget.post["imageurl"],
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.post["name"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  LikeButton(
                    circleColor:
                        const CircleColor(start: Colors.red, end: Colors.red),
                    size: 30,
                    onTap: (isliked) async {
                      this.isliked = !isliked;
                      Provider.of<Firebaseoperation>(context, listen: false)
                          .favoriteitems(
                              context,
                              {
                                "productname": widget.post["name"],
                                "imageurl": widget.post["imageurl"]
                              },
                              widget.post["name"])
                          .whenComplete(() {
                        Fluttertoast.showToast(
                            gravity: ToastGravity.CENTER,
                            msg: "${widget.post["name"]} added to favorite");
                      });
                      return !isliked;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: const [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "121 reviews",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "\$150",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ad eveniet neque eius, animi quam voluptatum, nihil voluptatibus quisquam ullam, autem similique earum dolore consequuntur velit alias ea necessitatibus rem ipsa."),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Reviews",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text("See all"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
