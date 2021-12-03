import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/authintication.dart';

class Forgerpassword extends StatefulWidget {
  const Forgerpassword({Key? key}) : super(key: key);

  @override
  _ForgerpasswordState createState() => _ForgerpasswordState();
}

class _ForgerpasswordState extends State<Forgerpassword> {
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.blue),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset(
              "img/forget.jpg",
              height: 200,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Forget Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
                "We have sent a password recovery instruction\n to your email"),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail_outline),
                      hintText: "Email Address",
                      focusColor: Colors.lightBlue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Provider.of<Authinitication>(context, listen: false)
                    .forgerpassword(context, emailcontroller.text);
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.lightBlue[300],
                    ),
                    child: const Center(
                      child: Text("Send",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
