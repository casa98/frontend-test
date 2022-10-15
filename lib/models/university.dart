import 'dart:convert';

University universityFromJson(String str) =>
    University.fromJson(json.decode(str));

class University {
  University({
    required this.alphaTwoCode,
    required this.domains,
    required this.country,
    required this.stateProvince,
    required this.webPages,
    required this.name,
  });

  factory University.fromJson(Map<String, dynamic> json) => University(
        alphaTwoCode: json['alpha_two_code'],
        domains: List<String>.from(json['domains'].map((x) => x)),
        country: json['country'],
        stateProvince: json['state-province'],
        webPages: List<String>.from(json['web_pages'].map((x) => x)),
        name: json['name'],
      );

  String alphaTwoCode;
  List<String> domains;
  String country;
  dynamic stateProvince;
  List<String> webPages;
  String name;
}
