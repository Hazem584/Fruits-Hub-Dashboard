enum OrderStatusEnum { pending, accepted, shipped, cancelled, delivered }

extension OrderEnumExtension on OrderStatusEnum {
  String get displayName {
    switch (this) {
      case OrderStatusEnum.pending:
        return 'قيد الانتظار';
      case OrderStatusEnum.accepted:
        return 'مقبول';
      case OrderStatusEnum.shipped:
        return 'تم الشحن';
      case OrderStatusEnum.cancelled:
        return 'ملغي';
      case OrderStatusEnum.delivered:
        return 'تم التسليم';
    }
  }
}
