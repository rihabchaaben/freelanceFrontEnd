import 'package:freelance/models/offerModel.dart';
import 'package:freelance/services/offerService.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({Key? key}) : super(key: key);

  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  late final TextEditingController _nameController;
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;
  late final TextEditingController _fAdressController;
  late final TextEditingController _phoneController;
  late final TextEditingController _imageController;
  late final TextEditingController _rolesController;
  final DioClient _dioClient = DioClient();

  bool isCreating = false;

  @override
  void initState() {
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _fAdressController = TextEditingController();
    _imageController = TextEditingController();
    _rolesController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Enter username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(hintText: 'Enter password'),
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(hintText: 'Enter email'),
          ),
          TextField(
            controller: _imageController,
            decoration: InputDecoration(hintText: 'Enter image path'),
          ),
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(hintText: 'Enter phone'),
          ),
          TextField(
            controller: _rolesController,
            decoration: InputDecoration(hintText: 'Enter role'),
          ),
          TextField(
            controller: _fAdressController,
            decoration: InputDecoration(hintText: 'Enter your adress'),
          ),
          SizedBox(height: 16.0),
          isCreating
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isCreating = true;
                    });

                    if (_nameController.text != '' &&
                        _passwordController.text != '') {
                      UserInfo userInfo = UserInfo(
                        username: _nameController.text,
                        password: _passwordController.text,
                        email: _emailController.text,
                        fAdress: _fAdressController.text,
                        image: _imageController.text,
                        roles: _rolesController.text,
                        phone: int.parse(_phoneController.text),
                      );

                      UserInfo? retrievedUser =
                          await _dioClient.createUser(userInfo: userInfo);

                      if (retrievedUser != null) {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('ID: ${retrievedUser.id}'),
                                    Text('Name: ${retrievedUser.username}'),
                                    Text('password: ${retrievedUser.password}'),
                                    Text(
                                      'role: ${retrievedUser.roles}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    setState(() {
                      isCreating = false;
                    });
                  },
                  child: Text(
                    'Create user',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
        ],
      ),
    );
  }
}
