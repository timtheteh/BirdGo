import 'locations.dart';

class Message {
  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;

  Message(this.address, this.id, this.image, this.lat, this.lng, this.name,
      this.phone, this.region);

  Message.fromJson(Map<dynamic, dynamic> json)
      : address = json['address'] as String,
        id = json['id'] as String,
        image = json['image'] as String,
        lat = (json['lat'] as num).toDouble(),
        lng = (json['lng'] as num).toDouble(),
        name = json['name'] as String,
        phone = json['phone'] as String,
        region = json['region'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'address': address,
        'id': id,
        'image': image,
        'lat': lat,
        'lng': lng,
        'name': name,
        'phone': phone,
        'region': region,
      };
}
