import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_bionic/pages/bottombar.dart';
import 'custom_container.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState>? formKey;
    TextEditingController? emailController;
    TextEditingController? passwordController;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  child: Image.asset('images/H-Bionic Logo Design Icon-01 1-fotor-20231204194535.png', fit: BoxFit.fill),
                ),
                 Text(
                  'Login'.tr,
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.normal),
                ),
                 Text(
                  "Please Login to continue".tr,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration:  InputDecoration(
                      labelText: 'Email Address'.tr,
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      hintText: 'Enter your email'.tr,
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration:  InputDecoration(
                      labelText: 'Password'.tr,
                      labelStyle: TextStyle(fontSize: 20, color: Colors.grey),
                      hintText: 'Enter your Password'.tr,
                      icon: Icon(
                        Icons.lock_outlined,
                        color: Colors.grey,
                      ),
                      suffixIcon:
                          Icon(Icons.visibility_outlined, color: Colors.grey),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (value) {},
                        checkColor: Colors.white,
                        activeColor: Colors.grey,
                      ),
                       Text(
                        "Remember password".tr,
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (v) {
                        return Bottom_bar();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff469FD1),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child:  Text(
                      "Login".tr,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
               
                ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: const Color.fromARGB(255, 67, 159, 210),
                    child: Column(
                      children: [
                        SizedBox(height: 90),
                        Text("Electronic Human Limbs".tr,
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 24, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}



