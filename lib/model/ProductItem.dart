import 'package:firebase_database/firebase_database.dart';
import 'package:quiver/core.dart';

class ProductItem{
  String key;
  DateTime dateTime;
  String name;
  double price;
  int number;

  ProductItem(this.dateTime, this.name, this.price, this.number);

  ProductItem.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      dateTime =
          new DateTime.fromMicrosecondsSinceEpoch(snapshot.value["date"]),
      name = snapshot.value["name"],
      price = snapshot.value["price"].toDouble(),
      number = snapshot.value["number"] as int;

  ProductItem.copy(ProductItem productItem)
    : key = productItem.key,
      dateTime = new DateTime.fromMillisecondsSinceEpoch(productItem.dateTime.millisecondsSinceEpoch),
      name = productItem.name,
      price = productItem.price,
      number = productItem.number;

  ProductItem._internal(this.key, this.dateTime, this.name, this.price, this.number);

  ProductItem copyWith(
    {String key, DateTime dateTime, String name, double price, int number}){
    return new ProductItem._internal(
        key ?? this.key,
        dateTime ?? this.dateTime,
        name ?? this.name,
        price ?? this.price,
        number ?? this.number
    );
  }

  toJson() {
    return {
      "name": name,
      "date": dateTime.millisecondsSinceEpoch,
      "price": price,
      "number": number
    };
  }

  @override
  int get hashCode => hash4(key, dateTime, name, price);

  @override
  bool operator ==(other) =>
        other is ProductItem &&
          key == other.key &&
          dateTime.millisecondsSinceEpoch == other.dateTime
            .millisecondsSinceEpoch &&
          name == other.name &&
          price == other.price &&
          number == other.number;
}