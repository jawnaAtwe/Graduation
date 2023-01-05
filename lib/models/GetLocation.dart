enum Shade { orange, green }

class GetLocation {
  final String store_name;
  final double  latitude;
  final double longitude;
  final Shade shade;
  
factory GetLocation.fromJson(Map<String,dynamic> json) => GetLocation(
    store_name: json['store_name']  == null ? '' : json['store_name']as String,
    latitude: json['latitude']  == null ? 0 : json['latitude'] as double,
    longitude: json['longitude'] == null ? 0 : json['longitude'] as double,
    
  );
  
  GetLocation({
    required this.store_name,
    required this.latitude,
    required this.longitude,
    
    this.shade = Shade.green,
  });

  



 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_name'] = this.store_name;
     data['latitude'] = this.latitude;
     data['longitude'] = this.longitude;
     return data;
  }

}
