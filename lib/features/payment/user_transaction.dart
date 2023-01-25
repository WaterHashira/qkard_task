import 'package:json_annotation/json_annotation.dart';

part 'user_transaction.g.dart';

@JsonSerializable()
class UserTransaction {
  @JsonKey(name: 'total_amount')
  double? totalAmount;

  @JsonKey(name: 'sub_total_amount')
  double? subTotalAmount;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'address_city')
  String? addressCity;

  @JsonKey(name: 'address_street')
  String? addressStreet;

  @JsonKey(name: 'address_zip_code')
  String? addressZipCode;

  @JsonKey(name: 'address_country')
  String? addressCountry;

  @JsonKey(name: 'address_state')
  String? addressState;

  @JsonKey(name: 'address_phone_number')
  String? addressPhoneNumber;

  UserTransaction(
      this.totalAmount,
      this.subTotalAmount,
      this.userName,
      this.addressCity,
      this.addressStreet,
      this.addressZipCode,
      this.addressCountry,
      this.addressState,
      this.addressPhoneNumber);

  factory UserTransaction.fromSnapshot(Map<String, dynamic> json) =>
      _$UserTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$UserTransactionToJson(this);
}
