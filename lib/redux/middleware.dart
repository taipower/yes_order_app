import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:redux/redux.dart';
import 'package:yes_order_app/redux/actions.dart';
import 'package:yes_order_app/redux/redux_state.dart';

middleware(Store<ReduxState> store, action, NextDispatcher next){
  print(action.runtimeType);
  if(action is InitAction){
    _handleInitAction(store);
  }else if(action is AddItemAction){
    _handleAddItemAction(store, action);
  }else if(action is EditItemAction){
    _handleEditItemAction(store, action);
  }else if(action is RemoveItemAction){
    _handleRemoveItemAction(store, action);
  }else if(action is AddOrderItemAction){
    _handleAddOrderItemAction(store, action);
  }else if(action is SetLoadAction){
    _handleSetLoadAction(action, store);
  }
  next(action);
  if(action is UserLoadedAction){
    _handleUserLoadedAction(store);
  }
}

_handleAddItemAction(Store<ReduxState> store, AddItemAction action){
  String load = store.state.load;
  print("LOAD _handleAddItemAction : " + load);
  print("Check mainReference : " + store.state.firebaseState.mainReference.toString());
  if(load == 'loadProduct'){
    store.state.firebaseState.mainReference
        .push()
        .set(action.productItem.toJson());
  }
}

_handleAddOrderItemAction(Store<ReduxState> store, AddOrderItemAction action){
  String load = store.state.load;
  if(load == 'loadOrder'){
    store.state.firebaseState.mainReference
        .push()
        .set(action.orderItem.toJson());
  }
}

_handleUserLoadedAction(Store<ReduxState> store){
  String load = store.state.load;
  if(load == 'loadProduct'){
    store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("product")
      ..onChildAdded
          .listen((event) => store.dispatch(new OnAddedAction(event)))
      ..onChildChanged
          .listen((event) => store.dispatch(new OnChangeAction(event)))
      ..onChildRemoved
          .listen((event) => store.dispatch(new OnRemovedAction(event)))
    )
    );
  }else if(load == 'loadOrder'){
    store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("order")
      ..onChildAdded
          .listen((event) => store.dispatch(new OnAddedOrderAction(event)))));
  }
}

_handleInitAction(Store<ReduxState> store){
  if(store.state.firebaseState.firebaseUser == null){
    FirebaseAuth.instance.currentUser().then((user){
      if(user != null){
        store.dispatch(new UserLoadedAction(user));
      }else{
        FirebaseAuth.instance
            .signInAnonymously()
            .then((user) => store.dispatch(new UserLoadedAction(user)));
      }
    });
  }
}

_handleEditItemAction(Store<ReduxState> store, EditItemAction action){
  String load = store.state.load;
  if(load == 'loadProduct'){
    store.state.firebaseState.mainReference
        .child(action.productItem.key)
        .set(action.productItem.toJson());
  }
}

_handleRemoveItemAction(Store<ReduxState> store, RemoveItemAction action){
  String load = store.state.load;
  if(load == 'loadProduct'){
    store.state.firebaseState.mainReference
        .child(action.productItem.key)
        .remove();
  }
}

_handleSetLoadAction(SetLoadAction action, Store<ReduxState> store){
  store.dispatch(new OnLoadChangedAction(action.load));

  String load = store.state.load;
  if(load == 'loadProduct'){
    store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("product")));
  }else if(load == 'loadOrder'){
    store.dispatch(new AddDatabaseReferenceAction(FirebaseDatabase.instance
        .reference()
        .child(store.state.firebaseState.firebaseUser.uid)
        .child("order")));
  }
}