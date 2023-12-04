
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_management_system/authentication/auth_screen.dart';
import 'package:hospital_management_system/pages/buy_medicine/buy_medicine.dart';
import 'package:hospital_management_system/pages/find_doctor/find_doctor.dart';
import 'package:hospital_management_system/pages/health_articles/health_articles.dart';
import 'package:hospital_management_system/pages/lab_test/lab_test.dart';
import 'package:hospital_management_system/pages/order_details.dart';
import 'package:hospital_management_system/widgets/my_container.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('24*7 HEALTHCARE'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 70, 10, 5),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mainback.png'),
              fit: BoxFit.fill,
            )
        ),
        child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 12.0,
            ),
            children: [
             MyContainer(icon: Icons.home,title: 'LAB TEST',color: Colors.cyan,onPress: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>LabTest()));
             }),
             MyContainer(icon: Icons.shop,title: 'BUY MEDICINE',color: Colors.cyan,onPress: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>BuyMedicine()));
             }),
             MyContainer(icon: Icons.message,title: 'FIND DOCTOR',color: Colors.cyan,onPress: (){
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>FindDoctor()), (route) => false);
             }),
             MyContainer(icon: Icons.calendar_month,title: 'HEALTH ARTICLES',color: Colors.cyan,onPress: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>HealthArticles()));
             }),
             MyContainer(icon: Icons.shopping_cart,title: 'ORDER DETAILS',color: Colors.cyan,onPress: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
             }),
             MyContainer(icon: Icons.info,title: 'LOGOUT',color: Colors.cyan,onPress: (){
               FirebaseAuth.instance.signOut();
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AuthScreen()), (route) => false);
             }),
            ]
        ),
      ),
    );
  }
}
