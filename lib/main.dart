import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/middleware.dart';
import 'package:yes_order_app/redux/reducers.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/screens/main_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final Store<ReduxState> store = new Store<ReduxState>(reduce,
      initialState: new ReduxState(
          orderList: [],
          entries: [],
          order: [],
          load: 'loadProduct',
          firebaseState: new FirebaseState(),
          productItemDialogState: new ProductItemDialogReduxState(),
          orderItemDialogState: new OrderItemDialogReduxState()),
      middleware: [middleware].toList());

  @override
  Widget build(BuildContext context) {
    store.dispatch(new InitAction());
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        title: "Yes Order",
        theme: new ThemeData(
          primarySwatch: Colors.green,
        ),
        home:
        new MainPage(title: "Yes Order"),
      ),
    );
  }
}
