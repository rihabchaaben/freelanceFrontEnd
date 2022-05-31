class Customer {
  int? id;
  String? email;
  String? username;
  String? fAdress;
  String? password;
  int? phoneNum;
  String? roles;
  String? image;
  Customer({
    this.id,
    this.email,
    this.fAdress,
    this.image,
    this.password,
    this.phoneNum,
    this.roles,
    this.username,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
      username: json["username"],
      password: json["password"],
      phoneNum: json["phoneNum"],
      image: json["image"],
      roles: json["roles"],
      id: json["id"],
      fAdress: json["fAdress"],
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "email": email,
        "fAdress": fAdress,
        "roles": roles,
        "image": image,
        "phoneNum": phoneNum,
        "password": password,
        "username": username,

        // 'id': id,
      };
}
