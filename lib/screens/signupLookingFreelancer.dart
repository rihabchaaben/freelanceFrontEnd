import 'package:freelance/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:freelance/services/marketplaceService.dart';
import 'package:freelance/style/colors.dart';
import 'package:freelance/style/style.dart';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
// ignore: unused_import
import 'package:freelance/style/text.dart';
import 'package:email_validator/email_validator.dart';
// ignore: unused_import
import 'package:group_radio_button/group_radio_button.dart';

import '../models/customer.dart';
import '../services/authService.dart';
import 'freelancerdashboard.dart';
import 'marketplaceUi.dart';

class SignUpLooking extends StatefulWidget {
  const SignUpLooking({Key? key}) : super(key: key);

  @override
  State<SignUpLooking> createState() => _SignUpLookingState();
}

class _SignUpLookingState extends State<SignUpLooking> {
  late Text _errorMessage;
  late String _password;

  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _fAdressController;
  late final TextEditingController _phoneController;
  // late final TextEditingController _imageController;
  late final TextEditingController _rolesController;
  final DioClient _dioClient = DioClient();

  bool isCreating = false;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fAdressController = TextEditingController();
    // _imageController = TextEditingController();
    _rolesController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  String _singleValue = "Text alignment right";

  bool isChecked = false;
  String? _dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30.0,
                      bottom: 2.0,
                      left: 0.0,
                      right: 550.0,
                    ),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 5, 5, 5),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    //  padding: const EdgeInsets.fromLTRB(20, 10, 300, 0),
                    child: Column(children: [
                      Container(
                          height: MediaQuery.of(context).size.height * 0.95,
                          width: MediaQuery.of(context).size.width,
                          color: bgColor,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 20.0,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    // Add TextFormFields and ElevatedButton here.
                                    buildUsernameInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildAdressInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildPhoneInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildEmailInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildPasswordInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),

                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      child: CheckboxListTile(
                                        activeColor:
                                            Color.fromARGB(255, 240, 67, 67),
                                        checkColor: Colors.white,
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        title: RichText(
                                          text: TextSpan(
                                            text: 'I agree to the ',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text:
                                                      'the terms of services ',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 240, 67, 67),
                                                    fontSize: 14,
                                                  )),
                                              TextSpan(
                                                  text: 'and ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                              TextSpan(
                                                  text: 'privacy policy ',
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 240, 67, 67),
                                                    fontSize: 14,
                                                  )),
                                            ],
                                          ),
                                        ),

                                        value: timeDilation != 1.0,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            timeDilation = value! ? 10.0 : 1.0;
                                          });
                                        },
                                        //  secondary: const Icon(Icons.hourglass_empty),
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 10.0,
                                    ),

                                    ElevatedButton(
                                        style: startBtnStyle,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 20.0,
                                            horizontal: 80.0,
                                          ),
                                          child: Text(
                                            'Sign Up',
                                            style: startBtnTextStyle,
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(builder:
                                                  (BuildContext context) {
                                            return MarketplaceFreelancers();
                                          }));
                                          setState(() {
                                            isCreating = true;
                                          });

                                          if (_usernameController.text != '' &&
                                              _passwordController.text != '') {
                                            Customer customer = Customer(
                                              username:
                                                  _usernameController.text,
                                              password:
                                                  _passwordController.text,
                                              email: _emailController.text,
                                              fAdress: _fAdressController.text,
                                              image: 'empty ',
                                              roles: 'customer',
                                              phoneNum: int.parse(
                                                  _phoneController.text),
                                            );

                                            Customer? retrievedUser =
                                                await _dioClient
                                                    .customerRegister(
                                                        customer: customer);
                                          }
                                        }),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    buildBottomMessage(),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ]),
                  ),
                ]))));
  }

  buildEmailInput() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'Email',
        hintText: 'Please enter your email',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
      ),
      controller: _emailController,
      onChanged: (val) {},
      style: const TextStyle(),
    );
  }

  void validateEmail(String val) async {
    if (val.isEmpty) {
      setState(() {
        // ignore: prefer_const_constructors
        _errorMessage = Text('Email can not be empty', style: textmessageError);
      });
    } else if (!EmailValidator.validate(val, true)) {
      setState(() {
        _errorMessage = Text('Invalid Email Address', style: textmessageError);
      });
    } else {
      setState(() {
        _errorMessage = Text('', style: textmessageError);
      });
    }
  }

  buildUsernameInput() {
    return TextFormField(
      controller: _usernameController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Fullname',
        hintText: 'Please enter your fullname',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildPhoneInput() {
    return TextFormField(
      controller: _phoneController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Mobile Phone',
        hintText: 'Please enter your phone number',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildAdressInput() {
    return TextFormField(
      controller: _fAdressController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your adress';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: 'Please enter your adress',
        hintStyle: TextStyle(
            fontSize: 12.0, color: Color.fromARGB(255, 180, 174, 174)),
        focusColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        fillColor: Colors.white,
        labelText: 'Adress',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
      onSaved: (val) => _password = val!,
      obscureText: _obscureText,
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        focusColor: Colors.white,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 175, 172, 172)),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Color.fromARGB(255, 88, 87, 87),
          ),
        ),
        fillColor: Color.fromARGB(255, 88, 87, 87),
        labelText: 'Password',
        labelStyle: const TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  buildBottomMessage() {
    return RichText(
      text: TextSpan(
        text: (" have an account ?    "),

        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color.fromARGB(255, 182, 175, 175),
        ),

        // ignore: prefer_const_constructors

        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 67, 67)),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(
                    () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const StartScreen();
                      }));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
