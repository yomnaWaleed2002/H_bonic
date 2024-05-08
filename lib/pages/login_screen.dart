import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:h_bionic/pages/bottombar.dart';
import 'custom_container.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String? email;
String? password;
bool loding = false;
GlobalKey<FormState>? formKey = GlobalKey();

class _LoginScreenState extends State<LoginScreen> {
 
  bool isPasswordVisible = false;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ModalProgressHUD(
      inAsyncCall: loding,
      child: Scaffold(
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
                    child: Image.asset(
                        'images/H-Bionic Logo Design Icon-01 1-fotor-20231204194535.png',
                        fit: BoxFit.fill),
                  ),
                  Text(
                    'Login'.tr,
                    style:  TextStyle(
                        fontSize: 50, fontWeight: FontWeight.normal,color: isDark ? Colors.white : Colors.black,),
                  ),
                  Text(
                    "Please Login to continue".tr,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      validator: (data) {
                        if (data!.isEmpty) {
                          return ('field is required');
                        }
                      },
                      onChanged: (data) {
                        email = data;
                      },
                      //controller: emailController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          labelText: 'Email Address'.tr,
                          labelStyle:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                          hintText: 'Enter your email'.tr,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xFF459ED1),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: TextFormField(
                      onChanged: (data) {
                        password = data;
                      },
                     // controller: passwordController,
                      obscureText: isPasswordVisible ? false : true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Colors.grey,
                        ),
                        labelText: 'Password'.tr,
                        labelStyle:
                            const TextStyle(fontSize: 20, color: Colors.grey),
                        hintText: 'Enter your Password'.tr,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF459ED1),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                              print(isPasswordVisible);
                            });
                          },
                          icon: isPasswordVisible
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      validator: (data) {
                        if (data!.isEmpty) {
                          return 'field is required';
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isChecked ? true : false,
                          onChanged: (value) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          },
                          checkColor: Colors.white,
                          activeColor: Colors.blue,
                        ),
                        Text(
                          "Remember password".tr,
                          style:
                              const TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey!.currentState!.validate()) {
                          loding = true;
                          setState(() {});
                          try {
                            await login();
                            showsnackbar(context, 'success');
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (v) {
                              return Bottom_bar();
                            }));
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showsnackbar(
                                  context, 'No user found for that email');
                            } else if (e.code == 'wrong-password') {
                              showsnackbar(context,
                                  'Wrong password provided for that user');
                            } else {
                              showsnackbar(context,
                                  'An error occurred while signing in. Please try again later.');
                            }
                          } catch (e) {
                            showsnackbar(context,
                                'should enter email and pasworrd to continue');
                          }
                          ;
                          loding = false;
                          setState(() {});
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff469FD1),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Login".tr,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
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
                          const SizedBox(height: 90),
                          Text("Electronic Human Limbs".tr,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 24, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }

  void showsnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(25),
      behavior: SnackBarBehavior.floating,
    ));
  }

  Future<void> login() async {
    UserCredential user =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
