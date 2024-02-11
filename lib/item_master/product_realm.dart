import 'package:realm/realm.dart';


part 'product_realm.g.dart';

@RealmModel()
class _ProductModel {
  @PrimaryKey()
  late ObjectId id;

  late String itemName;
  late String category;
  late double price;
  late double tax;
  late int quantity;
}

@RealmModel()
class _CustomerModel {
  @PrimaryKey()
  late ObjectId customerId;

  late String customerName;
  late String customerAddress;
  late String phone;
}

