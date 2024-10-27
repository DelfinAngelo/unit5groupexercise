// Lamasan Code
import 'package:flutter/material.dart';

void main() => runApp(AppValidateEmailAndSelectItem());

class AppValidateEmailAndSelectItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenEmailAndItemSelection(),
    );
  }
}

class ScreenEmailAndItemSelection extends StatefulWidget {
  @override
  State<ScreenEmailAndItemSelection> createState() => _ScreenEmailAndItemSelectionState();
}

class _ScreenEmailAndItemSelectionState extends State<ScreenEmailAndItemSelection> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String _selectedItemDetail = "Select an item to see details here.";

  void handleSelectItem(int index) {
    setState(() {
      _selectedItemDetail = "Details for ${_items[index]}";
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("You selected: ${_items[index]}"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void handleValidateEmail() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email is valid!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Validation & Item Selection"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Enter your email here:'),
                validator: (value) {
                  if (value == null || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: handleValidateEmail,
              child: Text("Validate Email"),
            ),

            
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _selectedItemDetail,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            ),

           
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_items[index]),
                    onTap: () => handleSelectItem(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
