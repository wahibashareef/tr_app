
import 'package:flutter/material.dart';

class ProductPageState {
  ProductPageState({
    this.itemName = 'Item Name',
    this.price = 0.0, 
    this.category = 'Category',
    this.tax = 0.0,
    this.quantity = 0,
    required this.itemNameController,
    required this.priceController,
    required this.categoryController,
    required this.taxController,
    required this.quantityController,
  });

  String itemName;
  double price; 
  String category;
  double tax;
  int quantity;
  TextEditingController itemNameController;
  TextEditingController priceController;
  TextEditingController categoryController;
  TextEditingController taxController;
  TextEditingController quantityController;

  ProductPageState copyWith({
    int? id,
    String? itemName,
    double? price,
    String? category,
    double? tax,
    int? quantity,
    TextEditingController? itemNameController,
    TextEditingController? priceController,
    TextEditingController? categoryController,
    TextEditingController? taxController,
    TextEditingController? quantityController,  
  }) {
    return ProductPageState(
      itemNameController: itemNameController ?? this.itemNameController, 
      priceController: priceController ?? this.priceController, 
      categoryController: categoryController ?? this.categoryController, 
      taxController: taxController ?? this.taxController, 
      quantityController: quantityController ?? this.quantityController,
      itemName: itemName ?? this.itemName,
      price: price ?? this.price, 
      category: category ?? this.category,
      tax: tax ?? this.tax,
      quantity: quantity ?? this.quantity,
    );
  }
}