import 'package:firebase_database/firebase_database.dart';
import 'package:quiver/core.dart';

class OrderItem{
  String key;
  DateTime dateTime;
  double totalPrice;
  int number;

  OrderItem(this.dateTime, this.totalPrice, this.number);

  OrderItem.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      dateTime =
          new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
      totalPrice = snapshot.value["totalPrice"].toDouble(),
      number = snapshot.value["number"] as int;

  OrderItem.copy(OrderItem orderItem)
    : key = orderItem.key,
      dateTime = new DateTime.fromMillisecondsSinceEpoch(orderItem.dateTime.millisecondsSinceEpoch),
      totalPrice = orderItem.totalPrice,
      number = orderItem.number;

  OrderItem._internal(this.key, this.dateTime, this.totalPrice, this.number);

  OrderItem copyWith(
    {String key, DateTime dateTime, double totalPrice, int number}){
    return new OrderItem._internal(
        key ?? this.key,
        dateTime ?? this.dateTime,
        totalPrice ?? this.totalPrice,
        number ?? this.number
    );
  }

  toJson(){
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "totalPrice": totalPrice,
      "number": number
    };
  }

  @override
  int get hashCode => hash4(key, dateTime, totalPrice, number);

  @override
  bool operator ==(other) =>
      other is OrderItem &&
        key == other.key &&
        dateTime.millisecondsSinceEpoch == other.dateTime
          .millisecondsSinceEpoch &&
        totalPrice == other.totalPrice &&
        number == other.number;
}