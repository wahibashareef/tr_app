import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_app/item_master/product_realm.dart';
import 'package:realm/realm.dart';

final customerProvider = StateProvider<CustomerModel>((ref) {
  final customer = CustomerModel(ObjectId(), '', '', '');
  customer.customerId = ObjectId();
  customer.customerName = '';
  customer.customerAddress = '';
  customer.phone = '';
  return customer;
});

class AddCustomer extends ConsumerWidget {
  const AddCustomer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addCustomer = ref.watch(customerProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Add Customer', style: TextStyle(color: Colors.black),),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          icon: Icon(Icons.arrow_back, color: Colors.black,)
        ),
      ),
      body: Container(
        child:Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  initialValue: addCustomer.customerName,
                  onChanged: (value) {
                    ref.read(customerProvider).customerName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Customer Name'
                  ),
                ),
                TextFormField(
                  initialValue: addCustomer.phone,
                  onChanged: (value) {
                    ref.read(customerProvider).phone = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number'
                  ),
                ),
                TextFormField(
                  initialValue: addCustomer.customerAddress,
                  onChanged: (value) {
                    ref.read(customerProvider).customerAddress = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Locality'
                  ),
                ),
                ElevatedButton(
                  onPressed: () async{
                    final realm = Realm(Configuration.local([CustomerModel.schema]));
                    final newCustomer = CustomerModel(ObjectId(), '', '', '')
                    ..customerId = ObjectId()
                    ..customerName = addCustomer.customerName
                    ..phone = addCustomer.phone
                    ..customerAddress = addCustomer.customerAddress;

                    realm.write(() {
                      realm.add(newCustomer);
                    });
                    
                  }, 
                  child: Text('Save')
                ),
              ],
            ),
          ),
        
      ),
    );
  }
}