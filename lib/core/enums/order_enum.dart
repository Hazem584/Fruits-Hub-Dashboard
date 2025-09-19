enum OrderEnum { pending, accepted, shipped, cancelled, delivered }

extension OrderEnumExtension on OrderEnum {
  String get displayName {
    switch (this) {
      case OrderEnum.pending:
        return 'قيد الانتظار';
      case OrderEnum.accepted:
        return 'مقبول';
      case OrderEnum.shipped:
        return 'تم الشحن';
      case OrderEnum.cancelled:
        return 'ملغي';
      case OrderEnum.delivered:
        return 'تم التسليم';
    }
  }
}
