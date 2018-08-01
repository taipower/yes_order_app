import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/screens/thanks_screen.dart';

class DialogViewModel{
  final OrderItem orderList;
  final Function() onPaymentPress;
  final Function() onLoadChanged;
  final Function(OrderItem) onItemChanged;

  DialogViewModel({
    this.orderList,
    this.onPaymentPress,
    this.onLoadChanged,
    this.onItemChanged
  });
}

class PaymentDialog extends StatefulWidget{
  final List<ProductItem> cart;

  PaymentDialog(this.cart);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PaymentDialogState(cart);
  }
}

class PaymentDialogState extends State<PaymentDialog>{
  final List<ProductItem> cart;
  TextEditingController _textControllerName;
  TextEditingController _textControllerNumer;
  TextEditingController _textControllerExpire;
  TextEditingController _textControllerCVV;
  double totalPrice;
  String _bankName;
  String _cardNumber;
  String _date;
  String _cvv;
  bool _successful = false;
  DateTime dateTime;

  PaymentDialogState(this.cart);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerName = new TextEditingController();
    _textControllerNumer = new TextEditingController();
    _textControllerExpire = new TextEditingController();
    _textControllerCVV = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, DialogViewModel>(
        converter: (store){
          int number = 0;
          totalPrice = 0.0;
          cart.forEach((entry){
            number += entry.number;
            totalPrice += entry.price * double.parse(entry.number.toString());
          });

          dateTime = new DateTime.now();
          OrderItem activeItem = new OrderItem(dateTime, totalPrice, number);
          return new DialogViewModel(
            orderList: activeItem,
            onPaymentPress: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => new Dialog(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      new Container(
                        padding: new EdgeInsets.all(8.0),
                        color: Colors.blue[100],
                        child: new Center(
                          child: new Column(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("Payment Processing..."),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
              new Future.delayed(new Duration(seconds: 2), (){
                Navigator.of(context).pop();
                store.dispatch(new SetLoadAction('loadOrder'));
                _successful = _paymentProcess();

                if(!_successful){
                  _showAlertDialog();
                }else{
                  Navigator.of(context).pushReplacement(new MaterialPageRoute(
                      builder: (BuildContext context) => new ThanksScreen(cart)));
                  store.dispatch(new AddOrderItemAction(activeItem));
                }
              });
            },
            onLoadChanged: (){
              store.dispatch(new SetLoadAction('loadOrder'));
            },
            onItemChanged: (entry) =>
                store.dispatch(new UpdateActiveOrderItem(entry)),
          );
        },
        builder: (context, viewModel){
          return new Scaffold(
              appBar: _createAppBar(context, viewModel),
              body: new Column(
                children: [
                  new Text("Total Price : " + totalPrice.toString()),
                  new ListTile(
                    leading: new Icon(Icons.account_balance, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: 'Cardholder Name'
                      ),
                      controller: _textControllerName,
                      onChanged: (value){
                        _bankName = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.credit_card, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: 'Card Number'
                      ),
                      controller: _textControllerNumer,
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        _cardNumber = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.today, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: 'MM/YYYY'
                      ),
                      controller: _textControllerExpire,
                      keyboardType: TextInputType.datetime,
                      onChanged: (value){
                        _date = value;
                      },
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.dvr, color: Colors.grey[500]),
                    title: new TextField(
                      decoration: new InputDecoration(
                        hintText: 'CVV'
                      ),
                      controller: _textControllerCVV,
                      keyboardType: TextInputType.number,
                      onChanged: (value){
                        _cvv = value;
                      },
                    ),
                  )
                ],
              )
          );
        });
  }

  Widget _createAppBar(BuildContext context, DialogViewModel viewModel){
    TextStyle actionStyle =
        Theme
        .of(context)
        .textTheme
        .subhead
        .copyWith(color: Colors.white);
    Text title = const Text("Payment");
    List<Widget> actions = [];
    actions.add(new FlatButton(
        onPressed: viewModel.onPaymentPress,
        child: new Text(
          'Confirm',
          style: actionStyle,
        ),
    ));

    return new AppBar(
      title: title,
      actions: actions,
    );
  }

  _paymentProcess(){
      bool successful = false;

      if(_cardNumber == '4242-4242-4242-4242' || _cardNumber == '4242424242424242'){
        successful = true;
        return successful;
      }

      return successful;
  }

  void _showAlertDialog() async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text("Alert Dialog"),
            content: Text("Please chek your credit card."),
            actions: <Widget>[
              new FlatButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: new Text('OK'))
            ],
          );
        },
    );
  }
}