import '../controllers/cart_controller.dart';

double calculateCartSubtotal(CartController cartController) {
  return cartController.cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
