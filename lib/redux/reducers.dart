import 'package:firebase_database/firebase_database.dart';
import 'package:yes_order_app/redux/redux_state.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';

ReduxState reduce(ReduxState state, action){
  List<OrderItem> orderList = _reduceItemOrder(state, action);
  List<ProductItem> entries = _reduceEntries(state, action);
  List<ProductItem> order = _reduceEntriesOrder(state, action);
  String load = _reduceLoad(state, action);
  ProductItemDialogReduxState productItemDialogReduxState =
    _reduceProductItemDialogState(state,action);
  OrderItemDialogReduxState orderItemDialogReduxState =
    _reduceOrderItemDialogState(state, action);
  FirebaseState firebaseState = _reduceFirebaseState(state, action);

  return new ReduxState(
    orderList: orderList,
    entries: entries,
    order: order,
    load: load,
    productItemDialogState: productItemDialogReduxState,
    orderItemDialogState: orderItemDialogReduxState,
    firebaseState: firebaseState,
  );
}

FirebaseState _reduceFirebaseState(ReduxState reduxState, action){
  FirebaseState newState = reduxState.firebaseState;
  if(action is InitAction){
    FirebaseDatabase.instance.setPersistenceEnabled(true);
  }else if(action is UserLoadedAction){
    newState = newState.copyWith(firebaseUser: action.firebaseUser);
  }else if(action is AddDatabaseReferenceAction){
    newState = newState.copyWith(mainReference: action.databaseReference);
  }
  return newState;
}

ProductItemDialogReduxState _reduceProductItemDialogState(ReduxState reduxState, action){
  ProductItemDialogReduxState newState = reduxState.productItemDialogState;
  if(action is UpdateActiveProductItem){
    newState = newState.copyWith(
      activeItem: new ProductItem.copy(action.productItem));
  }else if(action is OpenAddItemDialog){
    newState = newState.copyWith(
      activeItem: new ProductItem(
          new DateTime.now(),
          '' ,
          0.0,
          0),
      isEditMode: false);
  }else if(action is OpenEditItemDialog){
    newState =
        newState.copyWith(activeItem: action.productItem, isEditMode: true);
  }
  return newState;
}

OrderItemDialogReduxState _reduceOrderItemDialogState(ReduxState reduxState, action){
  OrderItemDialogReduxState newState = reduxState.orderItemDialogState;
  if(action is UpdateActiveOrderItem){
    newState = newState.copyWith(
        activeItem: new OrderItem.copy(action.orderItem));
  }else if(action is OpenAddOrderDialog){
    newState = newState.copyWith(
      activeItem: new OrderItem(new DateTime.now(),0.0,0));
  }
  return newState;
}

List<ProductItem> _reduceEntries(ReduxState state, action){
  List<ProductItem> entries = new List.from(state.entries);
  String load = state.load;
  if(load == 'loadProduct'){
    if(action is OnAddedAction){
      entries
        ..add(new ProductItem.fromSnapshot(action.event.snapshot))
        ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
    }else if(action is OnChangeAction){
      ProductItem newValue = new ProductItem.fromSnapshot(action.event.snapshot);
      ProductItem oldValue =
      entries.singleWhere((entry) => entry.key == newValue.key);
      entries
        ..[entries.indexOf(oldValue)] = newValue
        ..sort((we1,we2) => we2.dateTime.compareTo(we1.dateTime));
    }else if(action is OnRemovedAction){
      ProductItem removedEntry = state.entries
          .singleWhere((entry) => entry.key == action.event.snapshot.key);
      entries
        ..remove(removedEntry)
        ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
    }
  }

  return entries;
}

List<OrderItem> _reduceItemOrder(ReduxState state, action){
  List<OrderItem> entries = new List.from(state.orderList);
  String load = state.load;
  if(load == 'loadOrder'){
    if(action is OnAddedOrderAction){
      entries
        ..add(new OrderItem.fromSnapshot(action.event.snapshot))
        ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
    }
  }
  return entries;
}

List<ProductItem> _reduceEntriesOrder(ReduxState state, action){
  List<ProductItem> order = new List.from(state.order);
  String load = state.load;
  if(load == 'loadProduct'){
    if(action is OnAddedAction){
      order
        ..add(new ProductItem.fromSnapshot(action.event.snapshot))
        ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
      order.forEach((entry){
        entry.number = 0;
      });
    }else if(action is OnChangeAction){
      ProductItem newValue = new ProductItem.fromSnapshot(action.event.snapshot);
      ProductItem oldValue =
      order.singleWhere((entry) => entry.key == newValue.key);
      order
        ..[order.indexOf(oldValue)] = newValue
        ..sort((we1,we2) => we2.dateTime.compareTo(we1.dateTime));
    }else if(action is OnRemovedAction){
      ProductItem removedEntry = state.entries
          .singleWhere((entry) => entry.key == action.event.snapshot.key);
      order
        ..remove(removedEntry)
        ..sort((we1, we2) => we2.dateTime.compareTo(we1.dateTime));
    }
  }
  return order;
}

String _reduceLoad(ReduxState reduxState, action){
  String load = reduxState.load;
  if(action is OnLoadChangedAction){
    load = action.load;
  }
  return load;
}
