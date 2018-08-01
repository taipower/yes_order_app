import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/widgets/product_list_item.dart';
import 'package:yes_order_app/screens/payment_dialog.dart';

class DialogViewModel{
  final List<ProductItem> cartEntries;
  final Function() openPaymentDialog;

  DialogViewModel({
    this.cartEntries,
    this.openPaymentDialog
  });
}

class CartEntryDialog extends StatefulWidget{
  final List<ProductItem> cart;

  CartEntryDialog(this.cart);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new CartEntryDialogState(cart);
  }
}

class CartEntryDialogState extends State<CartEntryDialog>{
  double totalPrice;
  final List<ProductItem> cart;

  CartEntryDialogState(this.cart);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalPrice = 0.0;
    cart.forEach((entry){
      totalPrice += entry.price * double.parse(entry.number.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, DialogViewModel>(
        converter: (store){
          return new DialogViewModel(
            cartEntries: cart,
            openPaymentDialog: () {
              store.dispatch(new SetLoadAction('loadOrder'));
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context){
                    return new PaymentDialog(cart);
                  },
                fullscreenDialog: false,
              ));
            }
          );
        },
        builder: (context, viewModel){
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Cart"),
            ),
            body: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ListView.builder(
                    shrinkWrap: true,
                    itemCount: cart.length,
                    itemBuilder: (buildContext, index){
                      return new InkWell(
                          onTap: null,
                          child: new ProductListItem(cart[index]));
                    },
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text("Total Price : " + totalPrice.toString() + " Bath"),
                    ],
                  ),
                ],
            ),
            floatingActionButton: new FloatingActionButton(
              onPressed: () => viewModel.openPaymentDialog(),
              tooltip: 'Confirm Cart',
              child: new Text("OK")
            ),
          );
        });
  }

}