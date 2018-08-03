import 'package:flutter_test/flutter_test.dart';

import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/untils/utils.dart';

void main() {
    group('$Utils', () {
        List<ProductItem> listProduct = new List();
        ProductItem item = new ProductItem(new DateTime.now(),'test 1',98.0,10);
        item.key = '1';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 2', 34.75,30);
        item.key = '2';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 3', 56.0, 100);
        item.key = '3';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 4', 45.0, 74);
        item.key = '4';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 5', 67.0, 85);
        item.key = '5';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 6', 32.0, 7);
        item.key = '6';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 7', 76.25, 35);
        item.key = '7';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 8', 765.0, 234);
        item.key = '8';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 9', 376.0, 157);
        item.key = '9';
        listProduct.add(item);
        item = new ProductItem(new DateTime.now(), 'test 10', 546.50, 43);
        item.key = '10';
        listProduct.add(item);

        List<ProductItem> cart = new List();
        ProductItem cutoffItem = new ProductItem(new DateTime.now(), 'test 4', 45.0, 20);
        cutoffItem.key = '4';
        cart.add(cutoffItem);
        cutoffItem = new ProductItem(new DateTime.now(), 'test 6', 32.0, 2);
        cutoffItem.key = '6';
        cart.add(cutoffItem);
        cutoffItem = new ProductItem(new DateTime.now(), 'test 9', 376.0, 100);
        cutoffItem.key = '9';
        cart.add(cutoffItem);

        test('test checkStock', (){
            expect(Utils.checkStock(10, '1', listProduct), true);
            expect(Utils.checkStock(35, '7', listProduct), true);
            expect(Utils.checkStock(200, '9', listProduct), false);
            expect(Utils.checkStock(54, '10', listProduct), false);
        });

        test('test compute total price', (){
          expect(Utils.computeTotalPrice(cart), 38564.0);
        });

        test('test cutoffStock', (){
           List<ProductItem> productTest = new List();
           productTest = Utils.cutoffStock(cart, listProduct);
           expect(productTest[0].number, 10);
           expect(productTest[1].number, 30);
           expect(productTest[2].number, 100);
           expect(productTest[3].number, 54);
           expect(productTest[4].number, 85);
           expect(productTest[5].number, 5);
           expect(productTest[6].number, 35);
           expect(productTest[7].number, 234);
           expect(productTest[8].number, 57);
           expect(productTest[9].number, 43);
        });

        test('test Payment Process', (){
            expect(Utils.paymentProcess('4242-4242-4242-4242'), true);
            expect(Utils.paymentProcess('4232-4242-2222-4242'), false);
            expect(Utils.paymentProcess('4242424242424242'), true);
        });
    });
}
