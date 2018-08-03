import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';
import 'package:yes_order_app/screens/home_page.dart';

class MainPageViewModel{
  final List<ProductItem> order;
  final List<OrderItem> orderList;
  final Function onEnterToShopping;

  MainPageViewModel({
    this.order,
    this.orderList,
    this.onEnterToShopping
  });
}

class MainPage extends StatefulWidget{
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<MainPage> createState(){
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>
  with SingleTickerProviderStateMixin{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, MainPageViewModel>(
        converter: (store){
          return new MainPageViewModel(
            order: store.state.order,
            orderList: store.state.orderList,
            onEnterToShopping: (){
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context){
                    return new HomePage(title: "Yes Order",);
                  },
              ));
              store.dispatch(new SetLoadAction('loadOrder'));
              store.dispatch(new UserLoadedAction(store.state.firebaseState.firebaseUser));
            }
          );
        },
        builder: (context, viewModel){
          return new Scaffold(
            appBar: AppBar(
              title: Text("Yes Order"),
            ),
            body: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Enter to shopping"),
                  SizedBox(height: 10.0),
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: viewModel.onEnterToShopping,
                    child: Text("ENTER"),
                  ),
                ],
              ),
            ),
          );
        },
    );
  }
}