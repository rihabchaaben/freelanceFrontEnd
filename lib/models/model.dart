import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class RegisterRequest {
  final String username;
  final String password;

  RegisterRequest({required this.username, required this.password});

  /***  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
     // _$RegisterRequestFromJson(json);

  //Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
  
RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) {

  return RegisterRequest(
        password: json['password'] as String,
    username: json['username'] as String,
  );
}

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) => <String, dynamic>{
   'username': instance.username,
      'password': instance.password,
    };*/

}
