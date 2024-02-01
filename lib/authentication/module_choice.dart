import 'package:flutter/material.dart';
import 'package:login/authentication/signIn/login.dart';

class ModuleChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('CAT-WASTE'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Please select appropriate credentials to login',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          HoverContainer(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                'https://example.com/image1.jpg', // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
          HoverContainer(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage('Image 2')),
              );
            },
            child: Container(
              width: 150,
              height: 150,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                'https://example.com/image2.jpg', // Replace with your image URL
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final String imageName;

  DetailPage(this.imageName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageName),
      ),
      body: Center(
        child: Text(
          'This is the detail page for $imageName',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class HoverContainer extends StatefulWidget {
  final Widget child;
  final Function() onTap;

  HoverContainer({required this.child, required this.onTap});

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _isHovered ? Colors.grey[300] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
