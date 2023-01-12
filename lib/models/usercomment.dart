enum Shade { orange, green }

class usercomment {
  final String name;
  final String pic;
  final String message;
  final String date;
  final bool inCart;
  final Shade shade;
  
factory usercomment.fromJson(Map<String,dynamic> json) => usercomment(
    name: json['name']  == null ? '' : json['name']as String,
  pic: json['pic']  == null ? '' : json['pic']as String,
   message: json['message']  == null ? '' : json['message']as String,
  date: json['date']  == null ? '' : json['date']as String,
  );
  
  usercomment({
    required this.name,
    required this.pic,
    required this.message,
    required this.date,
   
    this.inCart = false,
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
     data['pic'] = this.pic;
        data['name'] = this.message;
     data['pic'] = this.date;
    

    return data;
  }

}
