import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/screens/loginservices/forgetpassword.dart';
import 'package:shopping/screens/loginservices/register.dart';
import 'package:shopping/services/authintication.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontrolller = TextEditingController();
  bool isvisiable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 35,
            ),
            Image.asset(
              "img/logo.png",
              height: 80,
              width: 80,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Welcome Back",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Sign in to continue",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 25,
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
            Center(
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  controller: passwordcontrolller,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Forgerpassword()));
                      },
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<Authinitication>(context, listen: false)
                    .loginaccount(context, emailcontroller.text,
                        passwordcontrolller.text);
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
                      child: Text("Sign in",
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text('or Log in with'),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset("google.png"),
                          Text("Google"),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    hoverColor: Colors.white,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.circular(18)),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Image.asset("img/facebook.png"),
                            Text(
                              "Facebook",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Registerpage()));
                    },
                    child: const Text("Register"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
