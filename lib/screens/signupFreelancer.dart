import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:freelance/screens/start_screen.dart';
// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/rendering.dart';
import 'package:freelance/style/colors.dart';
import 'package:freelance/style/style.dart';
// ignore: unused_import
import 'package:freelance/style/text.dart';
import 'package:email_validator/email_validator.dart';
// ignore: unused_import
import 'package:group_radio_button/group_radio_button.dart';

import 'freelancerdashboard.dart';
// ignore: import_of_legacy_library_into_null_safe

class SignUpFreelancer extends StatefulWidget {
  const SignUpFreelancer({Key? key}) : super(key: key);

  @override
  State<SignUpFreelancer> createState() => _SignUpFreelancerState();
}

class _SignUpFreelancerState extends State<SignUpFreelancer> {
  // FreelancerModel freelancer;
  late List data;
  late String _mySelection;
  late Text _errorMessage;
  TextEditingController usernameInput = TextEditingController();
  TextEditingController userPasswordInput = TextEditingController();
  TextEditingController adressInput = TextEditingController();
  TextEditingController priceInput = TextEditingController();
  TextEditingController aboutMeInput = TextEditingController();
  TextEditingController phoneInput = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late String _username;
  late String _aboutMe;
  late String _phone;
  late String _password;
  late String _adress;
  late String _price;
  File? imageFile;

  bool _obscureText = true;
  bool _obscureText2 = true;
  final _formKey = GlobalKey<FormState>();
  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";
  List<String> _status = ["Session", "hour"];
  bool isChecked = false;
  String? _dropdownvalue;
  // var subcategories = List<SubcategoryModel>.generate(200, (index) => null);
  @override
  void initState() {
    _getStateList();
    super.initState();
  }

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

                                    buildEmailInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildPasswordInput(),
                                    const SizedBox(
                                      height: 5.0,
                                    ),

                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          RadioGroup<String>.builder(
                                            direction: Axis.horizontal,
                                            groupValue: _verticalGroupValue,
                                            horizontalAlignment:
                                                MainAxisAlignment.spaceAround,
                                            onChanged: (value) => setState(() {
                                              _verticalGroupValue = value!;
                                            }),
                                            items: _status,
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 240, 67, 67),
                                            ),
                                            itemBuilder: (item) =>
                                                RadioButtonBuilder(
                                              item,
                                            ),
                                          ),
                                        ]),
                                    buildPriceInput(),

                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Category        ',
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 240, 67, 67),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid,
                                                width: 0.80),
                                          ),
                                          child: DropdownButton<String>(
                                            value: _myState,
                                            iconSize: 30,
                                            icon: (null),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16,
                                            ),
                                            hint: Text('Select category'),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                _myState = newValue;
                                                _getStateList();
                                                print(_myState);
                                              });
                                            },
                                            items: statesList?.map((item) {
                                                  return new DropdownMenuItem(
                                                    child:
                                                        new Text(item['name']),
                                                    value:
                                                        item['id'].toString(),
                                                  );
                                                }).toList() ??
                                                [],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // value: _dropdownValues.first,

                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    buildaboutMeInput(),
                                    const SizedBox(
                                      height: 10.0,
                                    ),
                                    /** const Text('your picture        ',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 240, 67, 67),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        )),*/
                                    /**   RaisedButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        _getFromGallery();
                                      },
                                      child:
                                          Text("pick your picture from gallery",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 240, 67, 67),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              )),
                                    ),*/
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
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return const Freelancerdashboard();
                                        }));
                                      },
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
                                    ),
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

  List? statesList;
  String? _myState;
  late Response response;
  Dio dio = Dio();

  String baseUrrl = 'http://localhost:8080/api/auth/subcategories';

  Future<String> _getStateList() async {
    Response response = await dio.get(baseUrrl);
    var data = json.decode(response.data);

//      print(data);
    setState(() {
      statesList = data['Subcategory'];
    });
    return 'sucess';
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
      controller: usernameInput,
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

  buildAdressInput() {
    return TextFormField(
      controller: adressInput,
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
      controller: userPasswordInput,
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

  buildPriceInput() {
    return TextFormField(
      controller: priceInput,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your price';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: 'Please enter your hour/session price ',
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
        labelText: '',
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 240, 67, 67),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  final List<String> _dropdownValues = [
    "It Enginner",
    "Front end developper",
    "Three",
    "Four",
    "Five"
  ];
  _getFromGallery() async {
    // ignore: deprecated_member_use
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  buildaboutMeInput() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      minLines: 1,
      maxLines: 5,
      controller: aboutMeInput,
      onChanged: (val) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'about you!';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromARGB(255, 10, 10, 10),
        fontWeight: FontWeight.w600,
      ),
      decoration: const InputDecoration(
        hintText: '',
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
        labelText: 'About Me',
        labelStyle: TextStyle(
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
