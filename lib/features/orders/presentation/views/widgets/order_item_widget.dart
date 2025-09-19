import 'package:flutter/material.dart';
import 'package:fruits_hub_dashboard/core/enums/order_enum.dart';
import 'package:fruits_hub_dashboard/features/orders/domain/entities/order_entity.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderEntity orderEntity;

  const OrderItemWidget({super.key, required this.orderEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Total Price and Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${orderEntity.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.green,
                  ),
                ),
                _buildStatusChip(orderEntity.status),
              ],
            ),
            const SizedBox(height: 12),

            // User ID with Icon
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'User: ${orderEntity.uId}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Shipping Address Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'عنوان الشحن',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${orderEntity.shippingAddress.name ?? 'غير محدد'}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${orderEntity.shippingAddress.phone ?? 'لا يوجد رقم'}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${orderEntity.shippingAddress.address ?? 'غير محدد'}, ${orderEntity.shippingAddress.city ?? ''}',
                    style: const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Payment Method with Icon
            Row(
              children: [
                const Icon(Icons.payment, size: 16, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'طريقة الدفع: ${_getPaymentMethodArabic(orderEntity.paymentMethod)}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Products Section Header
            Row(
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  size: 16,
                  color: Colors.green,
                ),
                const SizedBox(width: 8),
                Text(
                  'المنتجات (${orderEntity.orderProductModels.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Products List
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderEntity.orderProductModels.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 1, color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final product = orderEntity.orderProductModels[index];
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Product Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[50],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'الكمية: ${product.quantity}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Total Price
                        Column(
                          children: [
                            Text(
                              '\$${(product.price * product.quantity).toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Status Chip with Colors and Arabic Text
  Widget _buildStatusChip(OrderEnum? status) {
    final statusInfo = _getStatusInfo(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusInfo['color'],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusInfo['icon'], size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            statusInfo['text'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Get Status Information (Color, Icon, Text)
  Map<String, dynamic> _getStatusInfo(OrderEnum? status) {
    switch (status) {
      case OrderEnum.pending:
        return {
          'color': Colors.orange,
          'icon': Icons.access_time,
          'text': 'قيد الانتظار',
        };
      case OrderEnum.accepted:
        return {
          'color': Colors.blue,
          'icon': Icons.check_circle_outline,
          'text': 'مقبول',
        };
      case OrderEnum.shipped:
        return {
          'color': Colors.purple,
          'icon': Icons.local_shipping,
          'text': 'تم الشحن',
        };
      case OrderEnum.delivered:
        return {
          'color': Colors.green,
          'icon': Icons.done_all,
          'text': 'تم التسليم',
        };
      case OrderEnum.cancelled:
        return {'color': Colors.red, 'icon': Icons.cancel, 'text': 'ملغي'};
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.help_outline,
          'text': 'غير محدد',
        };
    }
  }

  // Convert Payment Method to Arabic
  String _getPaymentMethodArabic(String paymentMethod) {
    switch (paymentMethod.toLowerCase()) {
      case 'credit card':
      case 'creditcard':
        return 'بطاقة ائتمان';
      case 'cash':
        return 'نقداً';
      case 'paypal':
        return 'PayPal';
      case 'bank transfer':
        return 'تحويل بنكي';
      default:
        return paymentMethod;
    }
  }
}
