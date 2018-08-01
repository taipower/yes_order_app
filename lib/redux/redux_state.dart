import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';

@immutable
class ReduxState{
  final List<OrderItem> orderList;
  final List<ProductItem> entries;
  final List<ProductItem> order;
  final String load;
  final ProductItemDialogReduxState productItemDialogState;
  final OrderItemDialogReduxState orderItemDialogState;
  final FirebaseState firebaseState;

  const ReduxState({
    this.firebaseState = const FirebaseState(),
    this.orderList = const[],
    this.entries = const [],
    this.order = const [],
    this.load = 'loadProduct',
    this.productItemDialogState = const ProductItemDialogReduxState(),
    this.orderItemDialogState = const OrderItemDialogReduxState()
  });

  ReduxState copyWith({
    FirebaseState firebaseState,
    List<OrderItem> orderList,
    List<ProductItem> entries,
    List<ProductItem> order,
    load,
    ProductItemDialogReduxState productEntryDialogState,
    OrderItemDialogReduxState orderItemDialogState
  }){
    return new ReduxState(
      firebaseState: firebaseState ?? this.firebaseState,
      orderList: orderList ?? this.orderList,
      entries: entries ?? this.entries,
      order: order ?? this.order,
      load: load ?? this.load,
      productItemDialogState: productEntryDialogState ?? this.productItemDialogState,
      orderItemDialogState: orderItemDialogState ?? this.orderItemDialogState);
  }
}

@immutable
class RemovedEntryState{
  final ProductItem lastRemovedEntry;
  final bool hasEntryBeenRemoved;

  const RemovedEntryState(
    {this.lastRemovedEntry, this.hasEntryBeenRemoved = false});

  RemovedEntryState copyWith({
    ProductItem lastRemovedEntry,
    bool hasEntryBeenRemoved}){
    return new RemovedEntryState(
      lastRemovedEntry: lastRemovedEntry ?? this.lastRemovedEntry,
      hasEntryBeenRemoved: hasEntryBeenRemoved ?? this.hasEntryBeenRemoved);
  }
}

@immutable
class ProductItemDialogReduxState {
  final bool isEditorMode;
  final ProductItem activeItem;

  const ProductItemDialogReduxState({this.isEditorMode, this.activeItem});

  ProductItemDialogReduxState copyWith({
    bool isEditMode,
    ProductItem activeItem,
  }){
    return new ProductItemDialogReduxState(
        isEditorMode: isEditMode ?? this.isEditorMode,
        activeItem: activeItem ?? this.activeItem);
  }
}

@immutable
class OrderItemDialogReduxState{
  final OrderItem activeItem;

  const OrderItemDialogReduxState({this.activeItem});

  OrderItemDialogReduxState copyWith({
    OrderItem activeItem
  }){
    return new OrderItemDialogReduxState(
      activeItem: activeItem ?? this.activeItem);
  }
}

@immutable
class FirebaseState{
  final FirebaseUser firebaseUser;
  final DatabaseReference mainReference;

  const FirebaseState({this.firebaseUser, this.mainReference});

  FirebaseState copyWith({
    FirebaseUser firebaseUser,
    DatabaseReference mainReference,
  }){
    return new FirebaseState(
      firebaseUser: firebaseUser ?? this.firebaseUser,
      mainReference: mainReference ?? this.mainReference);
  }
}

@immutable
class MainPageReduxState{
  final bool hasEntryBeenAdded;

  const MainPageReduxState({this.hasEntryBeenAdded = false});

  MainPageReduxState copyWith({bool hasEntryBeenAdded}){
    return new MainPageReduxState(
      hasEntryBeenAdded: hasEntryBeenAdded ?? this.hasEntryBeenAdded);
  }
}
