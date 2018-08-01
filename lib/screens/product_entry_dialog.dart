import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/model/ProductItem.dart';

class DialogViewModel{
  final ProductItem productItem;
  final bool isEditMode;
  final Function(ProductItem) onItemChanged;
  final Function() onDeletePressed;
  final Function() onSavePressed;
  final Function() onLoadChhanged;

  DialogViewModel({
    this.productItem,
    this.isEditMode,
    this.onItemChanged,
    this.onDeletePressed,
    this.onSavePressed,
    this.onLoadChhanged
  });
}

class ProductItemDialog extends StatefulWidget{
  @override
  State<ProductItemDialog> createState() {
    // TODO: implement createState
    return new ProductItemDialogState();
  }
}

class ProductItemDialogState extends State<ProductItemDialog>{
  TextEditingController _textControllerName;
  TextEditingController _textControllerPrice;
  TextEditingController _textControllerNumber;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textControllerName = new TextEditingController();
    _textControllerPrice = new TextEditingController();
    _textControllerNumber = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, DialogViewModel>(
      converter: (store){
        ProductItem activeItem =
            store.state.productItemDialogState.activeItem;
        return new DialogViewModel(
          productItem: activeItem,
          isEditMode: store.state.productItemDialogState.isEditorMode,
          onItemChanged: (entry) =>
              store.dispatch(new UpdateActiveProductItem(entry)),
          onDeletePressed: (){
            store.dispatch(new RemoveItemAction(activeItem));
            Navigator.of(context).pop();
          },
          onSavePressed: () {
            if(store.state.productItemDialogState.isEditorMode){
              store.dispatch(new EditItemAction(activeItem));
            }else{
              store.dispatch(new AddItemAction(activeItem));
            }
            Navigator.of(context).pop();
          },
          onLoadChhanged: (){
            store.dispatch(new SetLoadAction('loadProduct'));
          }
          );
      },
      builder: (context, viewModel){
        return new Scaffold(
          appBar: _createAppBar(context, viewModel),
          body: new Column(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.title, color: Colors.grey[500]),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Product Name',
                  ),
                  controller: _textControllerName,
                  onChanged: (value){
                    viewModel
                      .onItemChanged(viewModel.productItem..name = value);
                  },
                ),
              ),
              new ListTile(
                leading: new Icon(Icons.attach_money, color: Colors.grey[500]),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Price',
                  ),
                  controller: _textControllerPrice,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    viewModel
                      .onItemChanged(viewModel.productItem..price = double.parse(value));
                  },
                ),
              ),
              new ListTile(
                leading: new Icon(Icons.content_paste, color: Colors.grey[500]),
                title: new TextField(
                  decoration: new InputDecoration(
                    hintText: 'Number',
                  ),
                  controller: _textControllerNumber,
                  keyboardType: TextInputType.number,
                  onChanged: (value){
                    viewModel
                      .onItemChanged(viewModel.productItem..number = int.parse(value));
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _createAppBar(BuildContext context, DialogViewModel viewModel){
    TextStyle actionStyle =
        Theme
          .of(context)
          .textTheme
          .subhead
          .copyWith(color: Colors.white);
    Text title = viewModel.isEditMode
      ? const Text("Edit Product")
      : const Text("New Product");
    List<Widget> actions = [];
    if(viewModel.isEditMode){
      actions.add(
        new FlatButton(
            onPressed: viewModel.onDeletePressed,
            child: new Text(
              'DELLETE',
              style: actionStyle,
            ),
        ),
      );
    }
    actions.add(new FlatButton(
        onPressed: viewModel.onSavePressed,
        child: new Text(
          'SAVE',
          style: actionStyle,
        ),
    ));

    return new AppBar(
      title: title,
      actions: actions,
    );
  }
}