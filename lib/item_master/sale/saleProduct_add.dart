import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart' as realm;
import 'package:tr_app/item_master/product_realm.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';


final productSaleProvider = FutureProvider<List<ProductModel>>((ref) async{
  final realmInstance = realm.Realm(realm.Configuration.local([ProductModel.schema]));
  final products = realmInstance.all<ProductModel>().toList();
  return products;
});

class AddedProductsNotifier extends StateNotifier<List<ProductModel>> {
  AddedProductsNotifier() : super([]);

  void addProduct(ProductModel product) {
    state = [...state, product]; //Whenever you want to add a product to the list, you can call the addProduct method of the AddedProductsNotifier, and it will handle updating the state with the new product.
  }
}
final addedProductsProvider = StateNotifierProvider<AddedProductsNotifier, List<ProductModel>>((ref) => AddedProductsNotifier());

class SaleProductAdd extends ConsumerWidget {
  const SaleProductAdd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final saleProducts = ref.watch(productSaleProvider);
     TextEditingController itemNameController = TextEditingController();
     TextEditingController quantityController = TextEditingController();
     TextEditingController priceController = TextEditingController();
     
    
     double price = 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Add Item to sale', style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon:Icon(Icons.shopping_cart, color: Colors.orange,),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: Padding(
        padding:EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<ProductModel>>(
              future: ref.read(productSaleProvider.future),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }else {
                  return TypeAheadFormField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: itemNameController,
                  decoration: InputDecoration(
                    labelText: 'Item',
                    hintText: 'Item'
                  ),
                ),
                suggestionsCallback: (pattern) {
                  final filteredItems = saleProducts.value?.where((item) {
                    return item.itemName.contains(pattern);
                  }).toList() ?? [];
                  return filteredItems;
                },
                itemBuilder: (context, itemData) {
                  return ListTile(
                    title: Text(itemData.itemName),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  itemNameController.text = suggestion.itemName;
                },
              );
                }
              },
              
            ),
            
            TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                hintText: 'Quantity',
              ),
              onChanged: (quantity) {
                //update the 'price' whenever the 'quantity' changes..
                final quantityValue = double.tryParse(quantity) ?? 0.0;
                final productPrice = saleProducts.value
                  ?.where((item) => item.itemName == itemNameController.text)
                  .map((item) => item.price)
                  .first ?? 0.0;
                price = quantityValue * productPrice;
                priceController.text = price.toStringAsFixed(2);
              },
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
              readOnly: true,
            ),

            ElevatedButton(
              onPressed: () async{
                final selectedProduct = saleProducts.value?.firstWhere (
                  (item) => item.itemName == itemNameController.text,
                  
                );

                if (selectedProduct != null) {
                  //Update the priceController field.
                  priceController.text = price.toStringAsFixed(2);

                  //Add the selected product to the addedProducts state.
                  final AddedProductsNotifier = ref.read(addedProductsProvider.notifier);
                  AddedProductsNotifier.addProduct(selectedProduct);
                  
                }
                
              }, 
              child: Text('Save')
            ),

          ],
        ),
        ),
    );
  }
}