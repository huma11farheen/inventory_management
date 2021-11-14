import 'dart:convert';

import 'package:http/http.dart';
import 'package:inventory_management/data/repositories/account_repository.dart';
import 'package:inventory_management/ui/list_details/supplier_page/controller/supplier_controller/supplier_model.dart';

class SupplierRepository {
  Future<List<SupplierModel>> fetchSuppliers() async {
    final token = await const AccountRepository().getToken();

    final suppliers = await get(
      Uri.parse('http://65.1.236.26:8000/supplier/'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Token $token',
      },
    );

    final supplierList = (json.decode(suppliers.body) as List)
        .map((dynamic e) => SupplierModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return supplierList;
  }

  Future<void> addSuppliers() async {
    final token = await const AccountRepository().getToken();

    await post(Uri.parse('http://65.1.236.26:8000/add_supplier/'), headers: {
      'Authorization': 'Token $token',
    }, body: {
      'supplier_name': 'bless',
      'phone_no': '2147483646',
      'address': 'bleh',
      'description': "{}"
    });
  }
}
