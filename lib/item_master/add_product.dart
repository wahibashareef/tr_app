import 'package:realm/realm.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:tr_app/item_master/product_realm.dart';
import 'package:tr_app/item_master/sample_dropdown.dart';
import 'package:tr_app/item_master/view_product.dart';


final productProvider = StateProvider<ProductModel>((ref) {
  final product = ProductModel(ObjectId(),'','',0.0,0.0,0);
  product.id = ObjectId();
  product.itemName = '';
  product.category =  '';
  product.price =  0.0; 
  product.tax = 0.0;
  product.quantity = 0;
  return product;
});

// final categoryListProvider = StateProvider((ref) => []);

class AddProduct extends ConsumerWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addProduct = ref.watch(productProvider);
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Add Product', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          icon:Icon(Icons.arrow_back, color: Colors.black,),
           onPressed: () { 
              Navigator.of(context).pop();
            },
          ),
          
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column (
              children: [
                TextFormField(
                  initialValue: addProduct.itemName,
                  onChanged: (value) {
                    ref.read(productProvider).itemName = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                      borderSide : BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                // TextFormField(
                //   initialValue: addProduct.category,
                //   onChanged: (value) {
                //     ref.read(productProvider).category = value;
                //   },
                //   decoration: InputDecoration(labelText: 'Category'),
                // ),
                const SampleDropdown(),
                TextFormField(
                  initialValue: addProduct.price.toString(),
                  onChanged: (value) {
                    ref.read(productProvider).price = double.parse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                      borderSide : BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: addProduct.quantity.toString(),
                  onChanged: (value) {
                    ref.read(productProvider).quantity = int.parse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                      borderSide : BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: addProduct.tax.toString(),
                  onChanged: (value) {
                    ref.read(productProvider).tax = double.parse(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Tax',
                    labelStyle: TextStyle(color: Colors.orange),
                    focusedBorder: UnderlineInputBorder(
                      borderSide : BorderSide(color: Colors.orange),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    final realm = Realm(Configuration.local([ProductModel.schema]));
                    final addproduct = ref.read(productProvider);
                    final selectedCategory = ref.read(categoryProvider.notifier).state;
                    
                    final newproduct = ProductModel(ObjectId(),'','',0.0,0.0,0)
                    ..id = ObjectId()
                    ..itemName=addproduct.itemName
                    ..category=selectedCategory.toString()
                    ..price = addproduct.price
                    ..tax = addproduct.tax
                    ..quantity = addproduct.quantity;
          
                    realm.write(() {
                      realm.add(newproduct);
                    });
                    ref.refresh(viewProductProvider);
                  }, 
                  child: const Text('Add'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

