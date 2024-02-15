import 'package:flutter/material.dart';
import 'package:login/authentication/signIn/login.dart';

class ModuleChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 74, 2, 71),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 41, 2, 41),
            title: Text(
              'CAT-WASTE',
              style: TextStyle(
                color: Colors.white,
                //fontFamily:FontFace(, source)
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'PLEASE SELECT APPROPRIATE CREDENTIALS\nTO LOGIN',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
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
                height: 140,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/mod_choice/team.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "USER",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[100],
              ),
            ),
            HoverContainer(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage('Image 2')),
                );
              },
              child: Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'assets/images/mod_choice/corporation.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              "ORGANIZATION",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue[200],
              ),
            ),
          ],
        ),
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
            borderRadius: BorderRadius.circular(150),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
