import 'package:flutter/material.dart';
import 'package:yes_order_app/model/ProductItem.dart';

class Utils{
  static bool checkStock(int value, String key, List<ProductItem> entries){
    bool successful = false;

    entries.forEach((entry){
      if(key == entry.key){
        if(value <= entry.number){
          successful = true;
        }
      }
    });

    return successful;
  }

  static List<ProductItem> cutoffStock(List<ProductItem> cart, List<ProductItem> listProduct){
    List<ProductItem> cutoffProduct = new List();

    listProduct.forEach((entry){
      cart.forEach((chartEntry){
        if(entry.key == chartEntry.key){
          entry.number = entry.number - chartEntry.number;
        }
      });
    });

    listProduct.forEach((cutoff){
      cutoffProduct.add(cutoff);
    });

    return cutoffProduct;
  }

  static bool paymentProcess(String cardNumber){
    bool successful = false;

    if(cardNumber == '4242-4242-4242-4242' || cardNumber == '4242424242424242'){
      successful = true;
    }

    return successful;
  }

  static double computeTotalPrice(List<ProductItem> listProduct){
    double totalPrice = 0.0;

    listProduct.forEach((entry){
      totalPrice += entry.price * double.parse(entry.number.toString());
    });

    return totalPrice;
  }

  static void showAlertDialog(BuildContext context, String title,
      String message, String titleButton) async{
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: new Text(titleButton))
          ],
        );
      },
    );
  }

  static bool validateCreditCard(String cardhloderName, String cardNumber,
      String expire, String cvv){
    bool successful = false;

    if(!(cardhloderName.isEmpty || cardNumber.isEmpty || expire.isEmpty || cvv.isEmpty)){
      if(cardNumber.trim().length < 16 || cvv.trim().length < 3){
        successful = false;
      }else{
        if(checkDateFormat(expire)){
          successful = paymentProcess(cardNumber);
        }else{
          successful = false;
        }
      }
    }

    return successful;
  }

  static bool checkDateFormat(String expire){
    bool successful = false;

    if(expire.contains('/')){
      successful = true;
    }

    return successful;
  }
}