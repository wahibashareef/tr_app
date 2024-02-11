
import 'package:flutter/material.dart';
import 'package:tr_app/item_master/sale/sale_page.dart';
import 'package:tr_app/item_master/view_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY APP', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: (){

          },
          icon: const Icon(Icons.menu, color: Colors.black,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Column(
          children: [
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5
                ),
                children: [
                  // GestureDetector(
                  //   onTap: (){
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => const ProductView(),
                  //       ),
                  //     );
                  //   },
                  //   child: const Card(
                  //     child: Center(child: Text('Item ', 
                  //       style: TextStyle(fontSize: 20),)),
                  //   ),
                  // ),
                  buildCard(context, 'Item', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductView(),
                        ),
                      );
                  }),
                  
                  buildCard(context, 'Sale', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SalePage(),
                        ),
                      );
                   }),
                  buildCard(context, 'Item', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductView(),
                        ),
                      );
                   }),
                  buildCard(context, 'Item', () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProductView(),
                        ),
                      );
                   }),
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String text, VoidCallback onTap) {
    
    return GestureDetector(
      onTap: onTap,
      child: Card(
        // margin: EdgeInsets.symmetric(),
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.orange),
          ),
          elevation: 2.0,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 12),
            )
          ),
        ),
      );
    
  }
}

