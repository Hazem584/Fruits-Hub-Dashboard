class ShippingAddressEntity {
  final String name;
  final String phone;
  final String email;
  final String address;
  final String city;
  final String addressDetails;

  ShippingAddressEntity({
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.city,
    required this.addressDetails,
  });

  // Constructor للحالات التي قد تحتوي على null
  factory ShippingAddressEntity.fromNullable({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? addressDetails,
  }) {
    return ShippingAddressEntity(
      name: name ?? '',
      phone: phone ?? '',
      email: email ?? '',
      address: address ?? '',
      city: city ?? '',
      addressDetails: addressDetails ?? '',
    );
  }

  // Copy with method
  ShippingAddressEntity copyWith({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? city,
    String? addressDetails,
  }) {
    return ShippingAddressEntity(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      city: city ?? this.city,
      addressDetails: addressDetails ?? this.addressDetails,
    );
  }
}
