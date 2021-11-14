// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'supplier_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SupplierModel _$_$_SupplierModelFromJson(Map json) {
  return _$_SupplierModel(
    supplierName: json['supplier_name'] as String,
    phoneNumber: json['phone_no'] as int,
    address: json['address'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$_$_SupplierModelToJson(_$_SupplierModel instance) =>
    <String, dynamic>{
      'supplier_name': instance.supplierName,
      'phone_no': instance.phoneNumber,
      'address': instance.address,
      'description': instance.description,
    };
