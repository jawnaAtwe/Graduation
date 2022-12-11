enum Shade { orange, green }

class user {
  final String username;
  final String userpass;
  final String email;
  final String place;
  final int phone;
 
  
factory user.fromJson(Map<String,dynamic> json) => user(
    username: json['username']  == null ? '' : json['username']as String,
    userpass: json['userpass']  == null ? '' : json['userpass']as String,
    email: json['email']  == null ? '' : json['email']as String,
    place: json['place']  == null ? '' : json['place']as String,
    phone: json['phone']  == null ? 0 : json['phone'] as int,
   
  );
  
  user({
    required this.username,
    required this.userpass,
    required this.email,
    required this.place,
    required this.phone ,
   
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['marketName'] = this.username;
     data['productName'] = this.userpass;
     data['manufacturing'] = this.email;
   data['place'] = this.place;
     data['phone'] = this.phone;

    return data;
  }

}
