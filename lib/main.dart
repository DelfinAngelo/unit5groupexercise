import 'package:flutter/material.dart';

void main() => runApp(ImageSwipeApp());

class ImageSwipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSwipeScreen(),
    );
  }
}

class ImageSwipeScreen extends StatefulWidget {
  @override
  _ImageSwipeScreenState createState() => _ImageSwipeScreenState();
}

class _ImageSwipeScreenState extends State<ImageSwipeScreen> {
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  double _imageScale = 1.0;

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item deleted")),
    );
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _imageScale = details.scale.clamp(1.0, 3.0); // Limit zoom scale between 1x and 3x
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Zoom and Swipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image with pinch-to-zoom functionality
            SizedBox(height: 20),
            GestureDetector(
              onScaleUpdate: _onScaleUpdate,
              child: Transform.scale(
                scale: _imageScale,
                child: Image.asset('assets/default_image.png', width: 150, height: 150),
              ),
            ),

            // List with swipe-to-delete interaction
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_items[index]),
                    onDismissed: (direction) => _deleteItem(index),
                    background: Container(color: Colors.red),
                    child: ListTile(
                      title: Text(_items[index]),
                    ),
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
