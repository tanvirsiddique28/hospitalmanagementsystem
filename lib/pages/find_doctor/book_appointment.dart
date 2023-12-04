import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/services/toast_service.dart';
import 'package:hospital_management_system/widgets/my_buttons.dart';
import 'package:hospital_management_system/widgets/my_textField.dart';
import 'package:intl/intl.dart';
class Appointment extends StatefulWidget {
  final String?title,name,address,mobile,fees;
  Appointment({Key? key,this.title,this.name,this.address,this.mobile,this.fees}) : super(key: key);

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  //controller-------------
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController feesController = TextEditingController();

  String? selectDate;
  String? selectTime;
  String? getUid;
  @override
  void initState() {
    nameController.text = 'Doctor Name:- '+widget.name!;
    addressController.text = 'Hospital Address:- '+widget.address!;
    mobileController.text = 'Contact Number:- '+widget.mobile!;
    feesController.text = 'Fees:- '+widget.fees!;
    getTitle();
    getUserId();
    selectDate = 'Select Date';
    selectTime = 'Select Time';
    super.initState();
  }
  void getUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userId = await auth.currentUser?.uid;
    setState(() {
      getUid = userId;
    });
  }

  String?myTitle;
  void getTitle(){

    switch(widget.title){
      case 'familyphysicians': myTitle = 'FAMILY PHYSICIAN';
      break;
      case 'dietician': myTitle = 'DIETICIAN';
      break;
      case 'dentist': myTitle = 'DENTIST';
      break;
      case 'surgeon': myTitle = 'SURGEON';
      break;
      case 'surgeon': myTitle = 'SURGEON';
      break;
      case 'cardiologists': myTitle = 'CARDIOLOGISTS';
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
            Text('$myTitle',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            MyTextFields(controller: nameController,icon: Icon(Icons.person,color: Colors.white,)),
            SizedBox(height: 10,),
            MyTextFields(controller: addressController,icon: Icon(Icons.contact_mail,color: Colors.white,)),
            SizedBox(height: 10,),
            MyTextFields(controller: mobileController,icon: Icon(Icons.contact_phone,color: Colors.white,)),
            SizedBox(height: 10,),
            MyTextFields(controller: feesController,icon: Icon(Icons.payment,color: Colors.white,)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButtons(title: '$selectDate',width: 45.0,height: 45.0,onPress: ()async{
                  DateTime? datePicked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2025));
                  setState(() {
                    if(datePicked!=null){
                      var date = DateFormat('dd/MM/yyyy').format(datePicked!);
                      var getDate = date.toString();
                      selectDate = getDate;
                      print(getDate);
                    }
                  });
                }),
                MyButtons(title: '$selectTime',width: 45.0,height: 45.0,onPress: ()async{
                  TimeOfDay? timePicked = await showTimePicker(context: context, initialTime: TimeOfDay.now(),initialEntryMode: TimePickerEntryMode.dial);
                  setState(() {
                    if(timePicked!=null){
                      if(timePicked.hour>12){
                        selectTime = '${timePicked.hour-12}:${timePicked?.minute} PM';
                      }else{
                        selectTime = '${timePicked?.hour}:${timePicked?.minute} AM';
                      }
                    }
                  });
                }),
              ],
            ),
            SizedBox(height: 20,),
            MyButtons(title: 'Book For Appointment',width: double.infinity,height: 45.0,onPress: (){
              saveappintment();
            })
          ],
        ),
      ),
    );
  }
  void saveappintment()async{
    String id = DateTime.now().millisecond.toString();

    await FirebaseFirestore.instance.collection('appointmentbook').doc(getUid).collection('bookappointment').doc(id).set({
      'name':widget.name,
      'address':widget.address,
      'number':widget.mobile,
      'fees':widget.fees,
      'date':selectDate,
      'time':selectTime,
    });
    showToast(message: 'Booked');
  }

}
