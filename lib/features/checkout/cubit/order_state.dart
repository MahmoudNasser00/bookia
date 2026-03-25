abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {}

class CheckoutLoading extends OrderState {}

class CheckoutLoaded extends OrderState {}

class PlaceOrderLoading extends OrderState {}

class OrderPlaced extends OrderState {}

class OrderHistoryLoaded extends OrderState {
  final List orders;

  OrderHistoryLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;

  OrderError(this.message);
}
