import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HealthDetails extends StatefulWidget {
  final String? title;
  HealthDetails({Key? key,this.title}) : super(key: key);

  @override
  State<HealthDetails> createState() => _HealthDetailsState();
}

class _HealthDetailsState extends State<HealthDetails> {

  @override
  void initState() {
    getImage();
    super.initState();
  }

  String?myImage;
  void getImage() {
    switch (widget.title) {
      case 'Walking Daily':
        myImage = 'assets/health1.jpeg';
        break;
      case 'Home Care of Covid-19':
        myImage = 'assets/health2.jpeg';
        break;
      case 'Stop Smoking':
        myImage = 'assets/health3.jpeg';
        break;
      case 'Menstrual Cramps':
        myImage = 'assets/health4.jpeg';
        break;
      case 'Healthy Gut':
        myImage = 'assets/health5.jpeg';
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('24*7 Healthcare'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/doctorbg.jpg'),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Text('${widget.title}',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            Container(
              height: 500,
              width: 800,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(myImage!),
            )
          ],
        ),
      ),
    );
  }
}
