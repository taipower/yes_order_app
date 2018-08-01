import 'package:flutter/material.dart';
import 'package:yes_order_app/model/OrderItem.dart';

class HistoryListItem extends StatelessWidget{
  final OrderItem orderItem;

  HistoryListItem(this.orderItem);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget titleScreen = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    orderItem.totalPrice.toString() + " Bath",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  orderItem.dateTime.year.toString() + "-"
                      + orderItem.dateTime.month.toString() + "-"
                      + orderItem.dateTime.day.toString() + " "
                      + orderItem.dateTime.hour.toString() + ":"
                      + orderItem.dateTime.minute.toString() + ":"
                      + orderItem.dateTime.second.toString(),
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            orderItem.number.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        ],
      ),
    );

    return titleScreen;
  }
}