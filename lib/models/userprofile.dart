enum Shade { orange, green }
class Userprofile {
  final String username;
  final int userpass;
  final String phone;
  final String email;
  final String place;


factory Userprofile.fromJson(Map<String,dynamic> json) => Userprofile(
    username: json['username']  == null ? '' : json['username']as String,
    userpass: json['userpass'] == null ? 0 : json['userpass'] as int,
    phone: json['phone']  == null ? '' : json['phone']as String,
    email: json['email']  == null ? '' : json['email']as String,
    place: json['place']  == null ? '' : json['place']as String,
   
  );
  Userprofile({
   required this.username,
   required this.userpass,
    required this.phone,
    required this.email,
    required this.place,
  });

//  factory Userprofile.fromJson(Map<String, dynamic> json) {
//     return Userprofile(
      
//       username: json['username'],
//       userpass: json['userpass'] as int,
//       phone: json['phone'],
//       email: json['email'],
//       place: json['place'],
//     );
//   }





}
