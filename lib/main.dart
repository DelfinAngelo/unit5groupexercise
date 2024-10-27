import 'package:flutter/material.dart';

void main() => runApp(AppZoomImageAndSwipeDelete());

class AppZoomImageAndSwipeDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenImageZoomAndSwipe(),
    );
  }
}

class ScreenImageZoomAndSwipe extends StatefulWidget {
  @override
  State<ScreenImageZoomAndSwipe> createState() => _ScreenImageZoomAndSwipeState();
}

class _ScreenImageZoomAndSwipeState extends State<ScreenImageZoomAndSwipe> {
  List<String> _items = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  double _imageScale = 1.0;

  void handleDeleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Item deleted")),
    );
  }

  void handleScaleImage(ScaleUpdateDetails details) {
    setState(() {
      _imageScale = details.scale.clamp(1.0, 3.0); // Limit zoom scale between 1x and 3x
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Zoom & Swipe to Delete"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image with pinch-to-zoom functionality
            SizedBox(height: 20),
            GestureDetector(
              onScaleUpdate: handleScaleImage,
              child: Transform.scale(
                scale: _imageScale,
                child: Image.asset('assets/image1.jpg', width: 150, height: 150),
              ),
            ),

            // List with swipe-to-delete interaction
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(_items[index]),
                    onDismissed: (direction) => handleDeleteItem(index),
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
