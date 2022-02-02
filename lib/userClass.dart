
class UserInfo{
  int id;
  String name;
  String username;
  String email;
  String phone;
  String address;
  String website;
  String companyName;
  String companyCatchPhrase;
  String companyBs;


  UserInfo({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
    required this.website,
    required this.companyName,
    required this.companyCatchPhrase,
    required this.companyBs,
  });


  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      address: (json['address']['suite']+', '+json['address']['street']+', '+
          json['address']['city']+', '+json['address']['zipcode']) as String,
      website: json['website'] as String,
      companyName: json['company']['name'] as String,
      companyCatchPhrase: json['company']['catchPhrase'] as String,
      companyBs: json['company']['bs'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'username': username,
    'email': email,
    'phone': phone,
    'address': address,
    'website': website,
    'companyName': companyName,
    'companyCatchPhrase': companyCatchPhrase,
    'companyBs': companyBs,
  };

}

