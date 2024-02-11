import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:tr_app/item_master/add_product.dart';
import 'package:tr_app/item_master/product_realm.dart';
import 'package:tr_app/item_master/viewProductTemplate.dart';


final viewProductProvider = FutureProvider<List<ProductModel>>((ref) async{
  final realm = Realm(Configuration.local([ProductModel.schema]));
  return realm.all<ProductModel>().toList();

});

final listProvider = StateProvider((ref) => '');

class ProductView extends ConsumerWidget {
  const ProductView({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    final productView = ref.watch(viewProductProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: Icon(Icons.arrow_back, color: Colors.black,),
        ),
        title: const Text('Products', style: TextStyle(color: Colors.black),),
        actions: [ 
          IconButton(
            onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddProduct(),
                  ),
                );
              }, 
            icon: Icon(Icons.add, color: Colors.black),
          ),
          
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8)), 
                    borderSide: BorderSide(
                      color:  Colors.orange
                      )),
              ),
              onChanged: (query){
                ref.read(listProvider.notifier).state = query.toLowerCase();
              },
            ),
            ),
            
            Expanded(
              child: productView.when(
              
                data: (products) {
                  final searchQuery = ref.watch(listProvider);
                  final filteredProducts = products.where(
                    (product) => product.itemName.toLowerCase()
                      .contains(searchQuery),).toList();

                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context,index) {
                      final product = filteredProducts[index];

                      return ListTile(
                        title: Text(product.itemName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        subtitle: Text('\$${product.price.toString()}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children:[
                            IconButton(
                              icon: const Icon(Icons.edit, color: Color.fromARGB(255, 247, 183, 87),),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => EditableProduct(product: product),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                deleteProduct(product.id);
                                ref.refresh(viewProductProvider);
                              }, 
                              icon: const Icon(Icons.delete, color:  Color.fromARGB(255, 247, 183, 87),),
                            ),
                          ],
                        ),
                      
                      );
                    },
                    );
                },
                loading: () => const Center(child: CircularProgressIndicator(),),
                error: (error, stackTrace) {
                  return Center(
                    child: Text('Error: $error'),
                  );
                },
              ),
            ),
          
        ],
      )
    );
  }
}

class EditableProduct extends ConsumerWidget {
final ProductModel product;

  const EditableProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemNameController = TextEditingController(text: product.itemName);
    final categoryController = TextEditingController(text: product.category);
    final priceController = TextEditingController(text: product.price.toString());
    final quantityController = TextEditingController(text: product.quantity.toString());
    final taxController = TextEditingController(text: product.tax.toString());

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // TextField(
            //   controller: itemNameController,
            //   decoration: const InputDecoration(labelText:'Name', hintText:"Enter Item name"),
            // ),
            ViewProductTemplate(
              controller: itemNameController, 
              labelText: 'Name',
              hintText: 'Enter Item name',
            ),
            const SizedBox(height:5),
            ViewProductTemplate(
              controller: categoryController, 
              labelText: 'Category',
              hintText: 'Enter Category',
            ),
            const SizedBox(height: 5),
            ViewProductTemplate(
              controller: priceController, 
              labelText: 'Price',
            ),
            const SizedBox(height: 5),
            ViewProductTemplate(
              controller: quantityController, 
              labelText: 'Quantity',
            ),
            const SizedBox(height: 5),
            ViewProductTemplate(
              controller: taxController, 
              labelText: 'Tax',
            ),
            ElevatedButton(
              onPressed: () {
                final updatedProduct = ProductModel(
                  product.id,
                  itemNameController.text, 
                  categoryController.text,
                  double.parse(priceController.text),
                  double.parse(taxController.text),
                  int.parse(quantityController.text),
                );
                ref.read(updateProductProvider(updatedProduct));
                ref.refresh(viewProductProvider);
              }, 
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              )
            ),
          ],
        ),
      ),
    );
  }
}

final updateProductProvider = StateProvider.autoDispose.family<void, ProductModel>((ref, updatedProduct) {
  final realm = Realm(Configuration.local([ProductModel.schema]));
  realm.write(() {
    realm.add<ProductModel>(updatedProduct, update: true);
  });
});

void deleteProduct(ObjectId objectId) async {
  final realm = Realm(Configuration.local([ProductModel.schema]));
  try {
    final productToDelete = realm.all<ProductModel>()
      .firstWhere((product) => product.id == objectId);
      realm.write(() {
        realm.delete<ProductModel>(productToDelete);
      });
  }
  catch(e) {
    print('Error deleting product: $e');
  }
  finally {
    realm.close();
  }
}
