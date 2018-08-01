import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/widgets/product_list_item.dart';
import 'package:yes_order_app/screens/product_entry_dialog.dart';

@immutable
class SettingsPageViewModal{
  final List<ProductItem> entries;
  final Function() openAddItemDialog;

  SettingsPageViewModal({
    this.entries,
    this.openAddItemDialog
  });
}

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, SettingsPageViewModal>(
        converter: (store){
          return new SettingsPageViewModal(
            entries: store.state.entries,
            openAddItemDialog: () {
              store.dispatch(new OpenAddItemDialog());
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context){
                    return new ProductItemDialog();
                  },
                  fullscreenDialog: true,
              ));
            }
          );
        },
        builder: (context, viewModel){
            return new Scaffold(
              appBar: new AppBar(
                title: new Text("Settings"),
              ),
              body: new ListView.builder(
                  shrinkWrap: true,
                  itemCount: viewModel.entries.length,
                  itemBuilder: (buildContext, index){
                    return new InkWell(
                      onTap: null,
                      child: new ProductListItem(viewModel.entries[index]));
                  },
              ),
              floatingActionButton: new FloatingActionButton(
                onPressed: () => viewModel.openAddItemDialog(),
                tooltip: 'Add Product',
                child: new Icon(Icons.add),
              ),
            );
        }
    );
  }
}