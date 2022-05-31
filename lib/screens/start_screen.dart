import 'package:freelance/models/login_model.dart';
import 'package:freelance/screens/signUpGo.dart';
import 'package:freelance/style/colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../style/style.dart';
import '../../style/text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:sign_button/sign_button.dart';

import '../models/userModel.dart';
import '../services/authService.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;

  // ignore: unused_field
  late Text _errorMessage;
  late String _username;
  late String _password;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool checkedValue = true;
  bool isLoginOpen = false;
  final DioClient _dioClient = DioClient();

  bool isCreating = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  final _formKeyLogin = GlobalKey<FormState>();
  final _formKeyRegister = GlobalKey<FormState>();
  // ignore: unnecessary_new

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      welcomeTitle,
                      style: titleStyle,
                    ),

                    // ignore: prefer_const_constructors
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20, 10, 150, 0),
                child: Text(
                  'Sign In',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(20, 10, 450, 0),
                child: Column(
                  children: const [
                    Text(
                      'Hi there ! Nice to see you again ',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                //  padding: const EdgeInsets.fromLTRB(20, 10, 300, 0),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.70,
                      width: MediaQuery.of(context).size.width,
                      color: bgColor,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40.0,
                            horizontal: 40.0,
                          ),
                          child: Form(
                            key: _formKeyLogin,
                            child: Column(
                              children: [
                                buildEmailInput(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                buildPasswordInput(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                buildLoginButton(),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                const Text(
                                  'Or use one of your profiles',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 182, 175, 175),
                                  ),
                                ),
                                buildBottomSocialMedia(),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                buildBottomMessage(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildEmailInput() {
    return TextFormField(
      controller: _nameController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        labelText: 'username',
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
      onChanged: (val) {
        //  validateEmail(val);
      },
      style: const TextStyle(),
    );
  }

  buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      onChanged: (value) {
        setState(() {
          _password = value;
        });
      },
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

  buildLoginButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 48.0,
        bottom: 28.0,
      ),
      child: ElevatedButton(
        style: startBtnStyle,
        onPressed: () async {
          setState(() {
            isCreating = true;
          });
          if (_nameController.text != '' && _passwordController.text != '') {
            UserModel userModel = UserModel(
              username: _nameController.text,
              password: _passwordController.text,
            );

            UserModel? retrievedUser =
                await _dioClient.loginUser(userInfo: userModel);
          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 64.0,
          ),
          child: Text(
            'signIn',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 48.0,
        bottom: 28.0,
      ),
      child: ElevatedButton(
        style: startBtnStyle,
        onPressed: () async {
          setState(() {
            isCreating = true;
          });

          await _dioClient.logoutUser();
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 64.0,
          ),
          child: Text(
            'signIn',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  buildBottomSocialMedia() {
    return Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 0.0,
          right: 0.0,
          left: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInButton(
                buttonType: ButtonType.linkedin,
                btnText: "linkedin",
                width: 125,

                // ignore: prefer_const_constructors
                shape: RoundedRectangleBorder(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.horizontal()),
                //  width: 100,
                buttonSize: ButtonSize.small, // small(default), medium, large
                onPressed: () {
                  print('click');
                }),
            Text('          '),
            SignInButton(
                buttonType: ButtonType.facebook,
                btnText: "facebook",
                btnColor: Color.fromARGB(255, 21, 78, 124),
                buttonSize: ButtonSize.small,
                shape: RoundedRectangleBorder(
                    // ignore: prefer_const_constructors
                    borderRadius: BorderRadius.horizontal()),
                width: 125,
                // small(default), medium, large
                onPressed: () {
                  print('click');
                }),
          ],
        ));
  }

  buildBottomMessage() {
    return RichText(
      text: TextSpan(
        text: (" forgot password?                             "),

        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Color.fromARGB(255, 182, 175, 175),
        ),

        // ignore: prefer_const_constructors

        children: <TextSpan>[
          TextSpan(
            text: 'Sign Up',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                //fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 240, 67, 67)),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(
                    () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const Signup();
                      }));
                    },
                  ),
          ),
        ],
      ),
    );
  }

  buildBottomMessagev2() {
    return RichText(
      text: TextSpan(
        text: 'Already have an account?  ',
        style: const TextStyle(fontFamily: 'Montserrat', color: Colors.white),
        children: <TextSpan>[
          TextSpan(
            text: 'Sign In',
            style: const TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.white),
            recognizer: TapGestureRecognizer()
              ..onTap = () => setState(() {
                    isLoginOpen = !isLoginOpen;
                  }),
          ),
        ],
      ),
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
}
