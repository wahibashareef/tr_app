import 'package:flutter/material.dart';

class ViewProductTemplate extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final String? hintText;

  const ViewProductTemplate({
    super.key, 
    required this.controller, 
    required this.labelText, 
    this.hintText, 
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.orange),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ), 
        hintText: hintText,
        
      ),
      
    );
    
  }
    Widget buttonTemplate({
    required VoidCallback onPressed,
    required String label,
     }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange
      ), 
      child: Text(label),
    );
  }
}

class ButtonTemplate extends StatelessWidget {
  
  const ButtonTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

