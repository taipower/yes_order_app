import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:meta/meta.dart';
import 'package:yes_order_app/model/ProductItem.dart';

@immutable
class ThanksScreenViewModel{
  final List<ProductItem> entries;
  final Function() onLoadChanged;
  final Function() onComplete;

  ThanksScreenViewModel({
    this.entries,
    this.onLoadChanged,
    this.onComplete
  });
}

class ThanksScreen extends StatelessWidget{
  bool _updateProduct = true;
  final List<ProductItem> cart;

  ThanksScreen(this.cart);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, ThanksScreenViewModel>(
        converter: (store){
          if(_updateProduct){
            store.state.entries.forEach((entry){
              cart.forEach((chartEntry){
                if(entry.key == chartEntry.key){
                  entry.number = entry.number - chartEntry.number;
                }
              });
            });
          }
          return new ThanksScreenViewModel(
              onLoadChanged: (){
                store.dispatch(new SetLoadAction('loadProduct'));
              },
              onComplete: (){
                store.dispatch(new SetLoadAction('loadProduct'));
                Navigator.of(context).pop();
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
                  new Text("Yes Order Thank You."),
                  SizedBox(height: 10.0),
                  new RaisedButton(
                    padding: const EdgeInsets.all(8.0),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: viewModel.onComplete,
                    child: Text("OK"),
                  ),
                ],
              ),
            ),
          );
        } );
  }
}