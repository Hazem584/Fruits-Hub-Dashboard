import 'package:fruits_hub_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? city;
  final String? addressDetails;

  ShippingAddressModel({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.city,
    this.addressDetails,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModel(
        name: json['name']?.toString(),
        phone: json['phone']?.toString(),
        email: json['email']?.toString(),
        address: json['address']?.toString(),
        city: json['city']?.toString(),
        addressDetails: json['addressDetails']?.toString(),
      );

  Map<String, dynamic> toJson() => {
    'name': name ?? '',
    'phone': phone ?? '',
    'email': email ?? '',
    'address': address ?? '',
    'city': city ?? '',
    'addressDetails': addressDetails ?? '',
  };

  // ✅ تحديث toEntity مع معالجة null values
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity.fromNullable(
      name: name,
      phone: phone,
      email: email,
      address: address,
      city: city,
      addressDetails: addressDetails,
    );
  }

  // Copy with method
  ShippingAddressModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? addressDetails,
  }) {
    return ShippingAddressModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      addressDetails: addressDetails ?? this.addressDetails,
    );
  }
}
