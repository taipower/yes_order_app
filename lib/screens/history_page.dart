import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/OrderItem.dart';
import 'package:yes_order_app/widgets/history_list_item.dart';

@immutable
class HistoryPageViewModel{
  final List<OrderItem> orderList;
  final Function() loadOrder;

  HistoryPageViewModel({
    this.orderList,
    this.loadOrder
  });
}

class HistoryPage extends StatelessWidget{
  HistoryPage({Key key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, HistoryPageViewModel>(
        converter: (store){
          return new HistoryPageViewModel(
            orderList: store.state.orderList,
            loadOrder: (){
              store.dispatch(new SetLoadAction('loadOrder'));
              store.dispatch(new InitAction());
              store.dispatch(new UserLoadedAction(store.state.firebaseState.firebaseUser));
            }
          );
        },
        builder: (context, viewModel){
          return new Scaffold(
            body: new ListView.builder(
                    shrinkWrap: true,
                    itemCount: viewModel.orderList.length,
                    itemBuilder: (buildContext, index){
                      return new InkWell(
                          onTap: null,
                          child: new HistoryListItem(viewModel.orderList[index]));
                    },
                  ),
          );
        });
  }

}