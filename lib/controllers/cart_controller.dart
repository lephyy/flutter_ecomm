import 'package:get/get.dart';
import '../models/shop_item.dart';

class CartController extends GetxController {
  var cartItems = <ShopItem>[].obs;

  void addToCart(ShopItem item) {
    int index = cartItems.indexWhere((e) => e.id == item.id);
    if (index != -1) {
      cartItems[index].quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
    cartItems.refresh();
  }

  void removeFromCart(ShopItem item) {
    cartItems.removeWhere((element) => element.id == item.id);
    cartItems.refresh();
  }

  void clearCart() {
    cartItems.clear();
  }

  void updateItemQuantity(ShopItem item, int newQuantity) {
    int index = cartItems.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      cartItems[index].quantity = newQuantity;
      cartItems.refresh(); // notify observers that the list changed
    }
  }

  int get itemCount => cartItems.length;
}