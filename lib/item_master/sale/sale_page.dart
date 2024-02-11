import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';
import 'package:tr_app/item_master/customer/add_customer.dart';
import 'package:tr_app/item_master/product_realm.dart';
import 'package:intl/intl.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:tr_app/item_master/sale/saleProduct_add.dart';



class SalePage extends ConsumerWidget {
  const SalePage({super.key});

  double totalPrice(List<ProductModel> products) {
    double total = 0.0;
    for (final product in products) {
      total += product.price * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    TextEditingController customerNameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController priceController = TextEditingController();
    
    DateTime date = DateTime.now();
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    String sale = '1';

    List<ProductModel> addedProducts = ref.watch(addedProductsProvider);

    void updateTotalPrice() {
      double total = totalPrice(addedProducts);
      priceController.text = totalPrice(addedProducts).toStringAsFixed(2);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Sale', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: Icon(Icons.arrow_back, color: Colors.black,)
        ),
      ),
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Column(
          crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sale: $sale',
                style: 
                TextStyle(fontSize: 10)
                ),
                Text('Date: $formattedDate', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Row(
                  children: [
                    Expanded(
                      child: TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                          controller: customerNameController,
                        decoration: InputDecoration(
                          labelText: 'Customer Name',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        final realm = Realm(Configuration.local([CustomerModel.schema]));
                        final customers = realm.all<CustomerModel>();
                        final filteredCustomers = customers.where((customer) {
                          return customer.customerName.contains(pattern);
                        }).toList();
                        return filteredCustomers;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.customerName),
                          subtitle: Text(suggestion.phone),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        customerNameController.text = suggestion.customerName;
                        phoneController.text = suggestion.phone;
                      }
                    ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddCustomer(),
                          ),
                        );
                      }, 
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          Text('Add'),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
        
                      ),
                    ),
        
                  ],
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number'
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    final addedProduct = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SaleProductAdd(),
                      )
                    );

                    if (addedProduct != null) {
                      ref.read(addedProductsProvider.notifier).addProduct(addedProduct);
                      updateTotalPrice();
                    }
                  }, 
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text('Add Items'),
                    ],
                  ),
                ),
                SizedBox(height: 8.0,),

                ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: addedProducts.length,
                  itemBuilder: (context, index) {
                    ProductModel product = addedProducts[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                      child: ListTile(title: Text(product.itemName),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: ${product.quantity}'),
                            Text('Price: \$${product.price}'),
                          ],
                        ),
                      ),
                    );
                  },
                  
                ),

                Row(
                  children: [
                    Text('Total'),
                    TextFormField(
                      controller: priceController,
                      decoration: InputDecoration(),
                      readOnly: true, 
                    ),
                  ],
                ),
                
                ElevatedButton(
                  onPressed: () {
          
                  }, 
                  child: Text('Save'),
                ),
              ],
            ),
          ),
          
              
        ],
          ),
        ],
      ),
   );
      
  }
}