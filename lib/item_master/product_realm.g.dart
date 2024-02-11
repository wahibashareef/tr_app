// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_realm.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class ProductModel extends _ProductModel
    with RealmEntity, RealmObjectBase, RealmObject {
  ProductModel(
    ObjectId id,
    String itemName,
    String category,
    double price,
    double tax,
    int quantity,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'itemName', itemName);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'tax', tax);
    RealmObjectBase.set(this, 'quantity', quantity);
  }

  ProductModel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get itemName =>
      RealmObjectBase.get<String>(this, 'itemName') as String;
  @override
  set itemName(String value) => RealmObjectBase.set(this, 'itemName', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => RealmObjectBase.set(this, 'price', value);

  @override
  double get tax => RealmObjectBase.get<double>(this, 'tax') as double;
  @override
  set tax(double value) => RealmObjectBase.set(this, 'tax', value);

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  Stream<RealmObjectChanges<ProductModel>> get changes =>
      RealmObjectBase.getChanges<ProductModel>(this);

  @override
  ProductModel freeze() => RealmObjectBase.freezeObject<ProductModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProductModel._);
    return const SchemaObject(
        ObjectType.realmObject, ProductModel, 'ProductModel', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('itemName', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('price', RealmPropertyType.double),
      SchemaProperty('tax', RealmPropertyType.double),
      SchemaProperty('quantity', RealmPropertyType.int),
    ]);
  }
}

class CustomerModel extends _CustomerModel
    with RealmEntity, RealmObjectBase, RealmObject {
  CustomerModel(
    ObjectId customerId,
    String customerName,
    String customerAddress,
    String phone,
  ) {
    RealmObjectBase.set(this, 'customerId', customerId);
    RealmObjectBase.set(this, 'customerName', customerName);
    RealmObjectBase.set(this, 'customerAddress', customerAddress);
    RealmObjectBase.set(this, 'phone', phone);
  }

  CustomerModel._();

  @override
  ObjectId get customerId =>
      RealmObjectBase.get<ObjectId>(this, 'customerId') as ObjectId;
  @override
  set customerId(ObjectId value) =>
      RealmObjectBase.set(this, 'customerId', value);

  @override
  String get customerName =>
      RealmObjectBase.get<String>(this, 'customerName') as String;
  @override
  set customerName(String value) =>
      RealmObjectBase.set(this, 'customerName', value);

  @override
  String get customerAddress =>
      RealmObjectBase.get<String>(this, 'customerAddress') as String;
  @override
  set customerAddress(String value) =>
      RealmObjectBase.set(this, 'customerAddress', value);

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => RealmObjectBase.set(this, 'phone', value);

  @override
  Stream<RealmObjectChanges<CustomerModel>> get changes =>
      RealmObjectBase.getChanges<CustomerModel>(this);

  @override
  CustomerModel freeze() => RealmObjectBase.freezeObject<CustomerModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(CustomerModel._);
    return const SchemaObject(
        ObjectType.realmObject, CustomerModel, 'CustomerModel', [
      SchemaProperty('customerId', RealmPropertyType.objectid,
          primaryKey: true),
      SchemaProperty('customerName', RealmPropertyType.string),
      SchemaProperty('customerAddress', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
    ]);
  }
}
