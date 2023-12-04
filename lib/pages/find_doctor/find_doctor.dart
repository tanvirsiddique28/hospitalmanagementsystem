import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/home_screen.dart';
import 'package:hospital_management_system/pages/find_doctor/doctor_details.dart';

import '../../widgets/my_container.dart';
class FindDoctor extends StatefulWidget {
  const FindDoctor({Key? key}) : super(key: key);

  @override
  State<FindDoctor> createState() => _FindDoctorState();
}

class _FindDoctorState extends State<FindDoctor> {
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
              image: AssetImage('assets/doctorbg.jpg'),
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
              MyContainers(image: 'assets/family_physicians.jpg',title: 'FAMILY PHYSICIANS',color: Colors.deepPurple,onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(
                    data: 'familyphysicians',
                  )));
              }),
              MyContainers(image: 'assets/dietician.jpg',title: 'DIETICIAN',color: Colors.deepPurple,onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(
                  data: 'dietician',
                )));
              }),
              MyContainers(image: 'assets/dentist.jpg',title: 'DENTIST',color: Colors.deepPurple,onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(
                  data: 'dentist',
                )));
              }),
              MyContainers(image: 'assets/surgeon.jpeg',title: 'SURGEON',color: Colors.deepPurple,onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(
                  data: 'surgeon',
                )));
              }),
              MyContainers(image: 'assets/cardiologists.jpg',title: 'CARDIOLOGISTS',color: Colors.deepPurple,onPress: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorDetails(
                  data: 'cardiologists',
                )));
              }),
              MyContain(icon: Icons.info,title: 'BACK',color: Colors.deepPurple,onPress: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (route) => false);
              }),
            ]
        ),
      ),
    );;
  }
}
