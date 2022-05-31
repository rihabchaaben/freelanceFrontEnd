class Metadata {
  String accessToken;
  Metadata({
    required this.accessToken,
  });
  factory Metadata.fromJson(Map<String, dynamic> parsedJson) {
    return Metadata(
      accessToken: parsedJson['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };
}
