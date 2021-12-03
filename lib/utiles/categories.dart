import 'package:flutter/material.dart';
import 'package:shopping/screens/seeall.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: const [
          Items(
            image: "img/dress.png",
            name: "Dress",
          ),
          Items(
            image: "img/smartphone.png",
            name: "Smartphone",
          ),
          Items(
            image: "img/tshirt.png",
            name: "T-shirt",
          ),
          Items(
            image: "img/shopping-bag.png",
            name: "Bags",
          ),
          SizedBox(
            width: 10,
          ),
          Items(
            image: "img/sneakers.png",
            name: "Shoes",
          )
        ],
      ),
    );
  }
}

class Items extends StatelessWidget {
  final String? name;
  final String? image;

  const Items({Key? key, @required this.name, @required this.image})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        height: 60,
        width: 80,
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Seeall()));
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  image!,
                  fit: BoxFit.cover,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            Text(name!)
          ],
        ),
      ),
    );
  }
}
