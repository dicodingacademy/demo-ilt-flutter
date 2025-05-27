import 'dart:convert';

class TourismResponse {
  final bool error;
  final String message;
  final Place place;
  TourismResponse({
    required this.error,
    required this.message,
    required this.place,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
      'message': message,
      'place': place.toMap(),
    };
  }

  factory TourismResponse.fromMap(Map<String, dynamic> map) {
    return TourismResponse(
      error: map['error'] as bool,
      message: map['message'] as String,
      place: Place.fromMap(map['place'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourismResponse.fromJson(String source) =>
      TourismResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Place {
  final int id;
  final String name;
  final String description;
  final String address;
  final int like;
  final String image;
  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.like,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'like': like,
      'image': image,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'].toInt() as int,
      name: map['name'] as String,
      description: map['description'] as String,
      address: map['address'] as String,
      like: map['like'].toInt() as int,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);
}
