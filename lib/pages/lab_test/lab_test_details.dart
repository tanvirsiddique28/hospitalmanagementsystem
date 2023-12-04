
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/services/toast_service.dart';
import 'package:intl/intl.dart';

import '../../widgets/my_buttons.dart';
class LabTestDetails extends StatefulWidget {
  final String? name,price,id;
   LabTestDetails({Key? key,this.name,this.price,this.id}) : super(key: key);

  @override
  State<LabTestDetails> createState() => _LabTestDetailsState();
}

class _LabTestDetailsState extends State<LabTestDetails> {
  String? getName;
  String? getPrice;
  String? getId;
  String? selectDate;
  String? selectTime;

  String?getUid;
  @override
  void initState() {
    getName = widget?.name;
    getPrice = widget?.price;
    getId = widget?.id;
    selectDate = 'Select Deliver Date';
    selectTime = 'Select Deliver Time';
    getDetails();
    getUserId();
    super.initState();
  }
String?details;
  void getDetails(){
    switch(getId){
      case '1231': details = 'Complete Hemogram,\nHbA1c,\nIron Studies,\nLDH Lactate Deydrogenase,\nSerum,\nLipid Profile,\nLiver Function Test';
      break;
      case '1232': details = 'CRP(C Reactive Protein)Quantiative,\nSerum,\nIron Studies,\nKidney Function Test,';
      break;
      case '1233': details = 'COVID-19 Antibody - igG';
      break;
      case '1234': details = 'Thyrod Profile Total(T3,T4 & TSH Ultra sensitive';
      break;
      case '1235': details = 'Vitamin D Total-25 Hydroxy,\nLiver Function Test,\nLipid Profile';
      break;
    }
  }
  void getUserId()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    final userId =  await auth.currentUser?.uid;
    setState(() {
      getUid = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('24*7 HEALTHCARE'),
        centerTitle: true,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/primaryback.jpg'),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text('Deliver Location: Dhaka',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
              SizedBox(height: 20,),
              Text('Packages:- '+'$getName',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amberAccent),),
              SizedBox(height: 20,),
              Text('$details',
                style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),),
              SizedBox(height: 200,),
              Text('Total Cost:- '+'$getPrice'+' tk',style: GoogleFonts.roboto(fontSize: 20,color: Colors.white),),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButtons(title: '$selectDate',
                      width: 45.0,
                      height: 45.0,
                      onPress: () async {
                        DateTime? datePicked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2025));
                        setState(() {
                          if (datePicked != null) {
                            var date = DateFormat('dd/MM/yyyy').format(
                                datePicked!);
                            var getDate = date.toString();
                            selectDate = getDate;
                            print(getDate);
                          }
                        });
                      }),
                  MyButtons(title: '$selectTime',
                      width: 45.0,
                      height: 45.0,
                      onPress: () async {
                        TimeOfDay? timePicked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.dial);
                        setState(() {
                          if (timePicked != null) {
                            if (timePicked.hour > 12) {
                              selectTime = '${timePicked.hour - 12}:${timePicked
                                  ?.minute} PM';
                            } else {
                              selectTime = '${timePicked?.hour}:${timePicked
                                  ?.minute} AM';
                            }
                          }
                        });
                      }),
                ],
              ),
              SizedBox(height: 20,),
              MyButtons(title: 'Add',width: double.infinity,height: 45.0,onPress: (){
                saveLabTest();
              })
            ],
          ),
        ),

    );
  }
  saveLabTest()async{
    String id = DateTime.now().millisecond.toString();
    await FirebaseFirestore.instance.collection('labtestcart').doc(getUid).collection('cartlabtest').doc(id).set({
        'package':getName,
        'fees':getPrice,
        'date':selectDate,
        'time':selectTime,
    });
    showToast(message: 'Added');
  }
}
