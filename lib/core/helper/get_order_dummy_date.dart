import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_product_entity.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

OrderEntity getOrderDummyDate() {
  return OrderEntity(
    status: OrderEnum.pending,
    totalPrice: 250.0,
    uId: "user_12345",
    shippingAddress: ShippingAddressEntity(
      name: "Hazem Mohammed",
      phone: "+201234567890",
      email: "hazem@example.com",
      address: "123 Main Street",
      city: "Cairo",
      addressDetails: "Apartment 5, Floor 3",
    ),
    orderProductModels: [
      OrderProductEntity(
        name: "Apple",
        code: "APL001",
        imageUrl:
            "https://images.unsplash.com/photo-1579338559194-a162d19bf842", // Mango
        quantity: 2,
        price: 20.0,
      ),
      OrderProductEntity(
        name: "Banana",
        code: "BNA002",
        imageUrl:
            "https://images.unsplash.com/photo-1579338559194-a162d19bf842", // Mango
        quantity: 5,
        price: 10.0,
      ),
      OrderProductEntity(
        name: "Mango",
        code: "MNG003",
        imageUrl:
            "https://images.unsplash.com/photo-1579338559194-a162d19bf842", // Mango
        quantity: 3,
        price: 30.0,
      ),
    ],
    paymentMethod: "Cash on Delivery",
  );
}
