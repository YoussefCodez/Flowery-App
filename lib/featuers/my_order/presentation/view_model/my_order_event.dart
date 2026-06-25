sealed class MyOrderEvent {}

class GetMyOrdersData extends MyOrderEvent {}

class GetActiveOrders extends MyOrderEvent {}

class GetCompletedOrders extends MyOrderEvent {}