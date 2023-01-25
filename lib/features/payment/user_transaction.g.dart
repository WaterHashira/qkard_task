// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTransaction _$UserTransactionFromJson(Map<String, dynamic> json) =>
    UserTransaction(
      (json['total_amount'] as num?)?.toDouble(),
      (json['sub_total_amount'] as num?)?.toDouble(),
      json['user_name'] as String?,
      json['address_city'] as String?,
      json['address_street'] as String?,
      json['address_zip_code'] as String?,
      json['address_country'] as String?,
      json['address_state'] as String?,
      json['address_phone_number'] as String?,
    );

Map<String, dynamic> _$UserTransactionToJson(UserTransaction instance) =>
    <String, dynamic>{
      'total_amount': instance.totalAmount,
      'sub_total_amount': instance.subTotalAmount,
      'user_name': instance.userName,
      'address_city': instance.addressCity,
      'address_street': instance.addressStreet,
      'address_zip_code': instance.addressZipCode,
      'address_country': instance.addressCountry,
      'address_state': instance.addressState,
      'address_phone_number': instance.addressPhoneNumber,
    };
