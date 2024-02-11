import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final categoryProvider = StateProvider<String?>((ref) => null);

final categoryListProvider = StateProvider<List<String>>((ref) => ["Fruits", "Stationary", "Gadgets"]);

abstract class CategoryProvider extends Notifier<String?> {
  void setCategory(String category) {
    state = category;
  }
}

class SampleDropdown extends ConsumerWidget {
  const SampleDropdown({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final categories = ref.watch(categoryProvider);
    final selectedCategories = ref.watch(categoryListProvider);

    // return DropdownButton(
    //   hint: Text('Category'),
    //   value: categories,
    //   items: <String>["Fruits", "Stationery", "Gadgets"]
    //     .map((e) => DropdownMenuItem(
    //       value: e,
    //       child: Text(e),
    //       ),
    //     ).toList(),
    //   onChanged: (value) {
    //     ref.read(categoryProvider.notifier).state = value.toString();
    //   }
    // );

    return Row(
      children: [
        Expanded(
          child: DropdownButton(
            hint: const Text('Category', style: TextStyle(color: Colors.orange),),
            value: categories,
            items: selectedCategories.map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              )).toList(),
            onChanged: (value) {
              ref.read(categoryProvider.notifier).state = value.toString();
            }
          ),
        ),

        ElevatedButton(
          onPressed: () async{
            final newCategory = await showDialog<String>(
              context: context, 
              builder: (BuildContext context) {
                String? categoryName;

                return AlertDialog(
                  title: const Text('Add Category'),
                  content: TextField(
                    onChanged: (value) {
                      categoryName = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Category Name',
                      labelStyle: TextStyle(color: Colors.orange),
                      focusedBorder: UnderlineInputBorder(
                      borderSide : BorderSide(color: Colors.orange),
                    ),
                    ),
                  ),

                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(categoryName);
                      }, 
                      child: const Text('Add', 
                      style: TextStyle(color: Colors.orange),
                      ),
                    ),
                  ]
                );
              }
            );
            if (newCategory != null) {
              ref.read(categoryListProvider.notifier).state = [...selectedCategories, newCategory];
              ref.read(categoryProvider.notifier).state = newCategory;
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
          ), 
          child: const Icon(Icons.add),
        ),
      ],
    );
  }

}


