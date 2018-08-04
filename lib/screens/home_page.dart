import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/screens/product_page.dart';
import 'package:yes_order_app/screens/history_page.dart';
import 'package:yes_order_app/screens/settings_screen.dart';
import 'package:yes_order_app/screens/cart_entry_dialog.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';
import 'package:yes_order_app/untils/utils.dart';

class HomePageViewModel{
  final List<ProductItem> order;
  final List<OrderItem> orderList;
  final Function(String) onLoadChanged;

  HomePageViewModel({
    this.order,
    this.orderList,
    this.onLoadChanged
  });
}

class HomePage extends StatefulWidget{
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState(){
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new StoreConnector<ReduxState, HomePageViewModel>(
      converter: (store){
        return new HomePageViewModel(
            order: store.state.order,
            orderList: store.state.orderList,
            onLoadChanged: (load){
              store.dispatch(new SetLoadAction(load));
            }
        );
      },
      builder: (context, viewModel){
        return new Scaffold(
          body: new NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled){
              return <Widget>[
                new SliverAppBar(
                  title: new Text(widget.title),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: new TabBar(
                    tabs: <Tab>[
                      new Tab(
                        key: new Key('ProductTab'),
                        text: "Product",
                      ),
                      new Tab(
                        key: new Key("HistoryTab"),
                        text: "History",
                      ),
                    ],
                    controller: _tabController,
                  ),
                  actions: _buildMenuActions(context,viewModel),
                )
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                new ProductPage(),
                new HistoryPage(),
              ],
              controller: _tabController,
            ),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: () => _openCartDialog(context, viewModel),
            child: new Icon(Icons.add_shopping_cart),
          ),
        );
      },
    );
  }

  List<Widget> _buildMenuActions(BuildContext context, HomePageViewModel viewModel){
    List<Widget> actions = [
      new IconButton(
          icon: new Icon(Icons.settings),
          onPressed: () => _openSettingsPage(context,viewModel)),
    ];

    return actions;
  }

  _openSettingsPage(BuildContext context, HomePageViewModel viewModel) async{
    String load = 'loadProduct';
    viewModel.onLoadChanged(load);
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new SettingsPage();
      },
    ));
  }

  _openCartDialog(BuildContext context, HomePageViewModel viewModel) async{
    List<ProductItem> cart = new List();
    viewModel.order.forEach((entry){
      if(entry.number > 0){
        cart.add(entry);
      }
    });

    if(cart.length > 0){
      String load = "loadOrder";
      viewModel.onLoadChanged(load);
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context){
          return new CartEntryDialog(cart);
        },
      ));
    }else{
        Utils.showAlertDialog(context, "Alert Dialog", "Please choose your product!", "OK");
    }
  }
}