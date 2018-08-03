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
}