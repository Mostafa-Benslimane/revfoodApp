class Restaurant {
  String? uid;
  String? img;
  String? name;
  String? category;
  String? willaya;

  Restaurant({this.uid, this.img, this.name, this.category, this.willaya});

  // receiving data from server
  factory Restaurant.fromMap(map) {
    return Restaurant(
      uid: map['uid'],
      img: map['img'],
      name: map['Name'],
      category: map['Category'],
      willaya: map['Willaya'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'img': img,
      'Name': name,
      'Category': category,
    };
  }
}
