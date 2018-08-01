import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:yes_order_app/model/ProductItem.dart';
import 'package:yes_order_app/model/OrderItem.dart';

class UserLoadedAction{
  final FirebaseUser firebaseUser;

  UserLoadedAction(this.firebaseUser);
}

class OrderLoadedAction{
  final FirebaseUser firebaseUser;

  OrderLoadedAction(this.firebaseUser);
}

class AddDatabaseReferenceAction{
  final DatabaseReference databaseReference;

  AddDatabaseReferenceAction(this.databaseReference);
}

class OnAddedAction{
  final Event event;

  OnAddedAction(this.event);
}

class OnAddedOrderAction{
  final Event event;

  OnAddedOrderAction(this.event);
}

class InitAction{}

class AcceptEntryAddedAction{}

class AcceptEntryRemovalAction{}

class OnRemovedAction{
  final Event event;

  OnRemovedAction(this.event);
}

class UpdateActiveProductItem{
  final ProductItem productItem;

  UpdateActiveProductItem(this.productItem);
}

class UpdateActiveOrderItem{
  final OrderItem orderItem;

  UpdateActiveOrderItem(this.orderItem);
}

class OnChangeAction{
  final Event event;

  OnChangeAction(this.event);
}

class OpenAddItemDialog{

}

class OpenAddOrderDialog{

}

class OpenEditItemDialog{
  final ProductItem productItem;

  OpenEditItemDialog(this.productItem);
}

class AddItemAction{
  final ProductItem productItem;

  AddItemAction(this.productItem);
}

class AddOrderItemAction{
  final OrderItem orderItem;

  AddOrderItemAction(this.orderItem);
}

class RemoveItemAction{
  final ProductItem productItem;

  RemoveItemAction(this.productItem);
}

class EditItemAction{
  final ProductItem productItem;

  EditItemAction(this.productItem);
}

class OnComputeTotalPriceAction{
  final double totalPrice;

  OnComputeTotalPriceAction(this.totalPrice);
}

class SetTotalPriceAction{
  final double totalPrice;

  SetTotalPriceAction(this.totalPrice);
}

class SetLoadAction{
  final String load;

  SetLoadAction(this.load);
}

class OnLoadChangedAction{
  final String load;

  OnLoadChangedAction(this.load);
}