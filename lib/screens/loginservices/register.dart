import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/services/authintication.dart';
import 'package:shopping/services/firebaseoperation.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({Key? key}) : super(key: key);

  @override
  _RegisterpageState createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  bool isvisiable = true;
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
              height: 50,
            ),
            const Text(
              "Let's Get Started",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Create a new account",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: name,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outline),
                      hintText: "Full name",
                      focusColor: Colors.lightBlue,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: email,
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
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: password,
                  obscureText: isvisiable,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isvisiable = !isvisiable;
                            });
                          },
                          icon: isvisiable
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off)),
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Provider.of<Authinitication>(context, listen: false)
                    .createaccount(context, email.text, password.text)
                    .whenComplete(() {
                  Provider.of<Firebaseoperation>(context, listen: false)
                      .createuser(context, {
                    "useruid":
                        Provider.of<Authinitication>(context, listen: false)
                            .getuserUid,
                    "username": name.text,
                    "useremail": email.text,
                  });
                });
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
                      child: Text("Sign up",
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
