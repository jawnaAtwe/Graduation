enum Shade { orange, green }

class market {
  final String AdminName;
  final String city;

  final bool inCart;
  final Shade shade;
  
factory market.fromJson(Map<String,dynamic> json) => market(
    AdminName: json['AdminName']  == null ? '' : json['AdminName']as String,
  city: json['city']  == null ? '' : json['city']as String,
   
  );
  
  market({
    required this.AdminName,
    required this.city,
   
    this.inCart = false,
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminName'] = this.AdminName;
     data['city'] = this.city;
    

    return data;
  }

}
