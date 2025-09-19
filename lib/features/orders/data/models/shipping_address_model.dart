import 'package:fruits_hub_dashboard/features/orders/domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? city;
  String? addressDetails;

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
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        address: json['address'],
        city: json['city'],
        addressDetails: json['addressDetails'],
      );
  toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
    'address': address,
    'city': city,
    'addressDetails': addressDetails,
  };
  ShippingAddressEntity toEntity() {
    return ShippingAddressEntity(
      name: name,
      phone: phone,
      email: email,
      address: address,
      city: city,
      addressDetails: addressDetails,
    );
  }
}
