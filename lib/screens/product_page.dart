import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/widgets/product_list_item.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:yes_order_app/untils/utils.dart';

class _ProductPageViewModel{
  final List<ProductItem> entries;
  final List<ProductItem> order;
  final Function(ProductItem) onItemChanged;
  final Function() onLoadChanged;

  _ProductPageViewModel({
    this.entries,
    this.order,
    this.onItemChanged,
    this.onLoadChanged
  });
}

class ProductPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, _ProductPageViewModel>(
      converter: (store){
        return new _ProductPageViewModel(
          entries: store.state.entries,
          order: store.state.order,
          onItemChanged: (entry) =>
            store.dispatch(new UpdateActiveProductItem(entry)),
          onLoadChanged: (){
            store.dispatch(new SetLoadAction('loadProduct'));
          }
        );
      },
      builder: (context, viewModel){
        return new Scaffold(
          body: new ListView.builder(
            shrinkWrap: true,
            itemCount: viewModel.order.length,
            itemBuilder: (buildContext, index){
              return new InkWell(
                  onTap: () => _showOrderPicker(context, viewModel,
                      viewModel.order[index]),
                  child: new ProductListItem(viewModel.order[index]));
            },
          ),
        );
      },
    );
  }

  _showOrderPicker(BuildContext context, _ProductPageViewModel viewModel,
      ProductItem orderItem){
    showDialog<int>(
        context: context,
      builder: (context) =>
          new NumberPickerDialog.integer(
              minValue: 0,
              maxValue: 99,
              initialIntegerValue: 0,
              title: new Text("Enter your order"),
          ),
    ).then((int value){
      if(value != null){
        bool successful = false;

        successful = Utils.checkStock(value, orderItem.key, viewModel.entries);

        if(successful){
          viewModel.onItemChanged(orderItem..number = value);
        }else{
            Utils.showAlertDialog(context, "Alert Dialog",
                "Sorry our product less than your need!", "OK");
        }
      }
    });
  }
}