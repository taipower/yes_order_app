import 'package:flutter/material.dart';
import 'package:yes_order_app/model/ProductItem.dart';

class ProductListItem extends StatelessWidget{
  final ProductItem productItem;

  ProductListItem(this.productItem);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget titleSection = Container(
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
                    productItem.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  productItem.price.toString() + " Bath",
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            productItem.number.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            ),
          ),
        ],
      ),
    );

    return titleSection;
  }
}