import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/services/toast_service.dart';
import 'package:intl/intl.dart';

import '../../widgets/my_buttons.dart';
class BuyMedDetails extends StatefulWidget {
  final String? name,price,id;
  BuyMedDetails({Key? key,this.name,this.price,this.id}) : super(key: key);

  @override
  State<BuyMedDetails> createState() => _BuyMedDetailsState();
}

class _BuyMedDetailsState extends State<BuyMedDetails> {
  String? getName;
  String? getPrice;
  String? getId;
  String? getUid;
  String? selectDate;
  String? selectTime;
  @override
  void initState() {
    getName = widget?.name;
    getPrice = widget?.price;
    getId = widget?.id;
    selectDate = 'Select Deliver Date';
    selectTime = 'Select Deliver Time';
    getDetails();
    getUniqueId();
    super.initState();
  }
  void getUniqueId()async{
    FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    setState(() {
      getUid = userId;
    });
  }
  String?details;
  void getDetails(){

    switch(getId){
      case '1231': details = 'This capsule helps maintain healthy vitamin D levels in the body\nIt improves calcium and phosphorus absorption in the body\nIt supports bone, muscle and nerve health';
      break;
      case '1232': details = 'It is an essential trace mineral that plays an important role\nin helping insulin regulate blood glucose.';
      break;
      case '1233': details = 'used to treat or prevent vitamin deficiency due to poor diet\ncertain illnesses, alcoholism, or during pregnancy';
      break;
      case '1234': details = 'It promotes health as well as skin benefit\nIt helps reduce skin blemish and pigmentation\nIt act as safeguard the skin from the harsh UVA and UVB sun rays\nIt helps to maintain a healthy body with overall wellness';
      break;
      case '1235': details = 'It is used to treat headaches, migraine, nerve pain, toothache,\nsore throat, period (menstrual) pains,\narthritis, muscle aches, and the common cold.';
      break;
      case '1236': details = 'provide temporary, effective relief from tension headache pain,\nmigraine pain, toothache, cold and flu symptoms,\nmuscle aches, arthritis and osteoarthritis.';
      break;
      case '1237': details = 'It provide fast-acting relief which\nhelps prevent sore throat pain from getting worse.';
      break;
      case '1238': details = 'It is a dietary supplement formulated with calcium\ncitrate, vitamin D3, vitamin K2, alfalfa, magnesium\nand zinc that promote bone and joint health.';
      break;
      case '1239': details = 'Iron helps the body move oxygen throughout the\nbody and maintain red blood cells, which helps people\nfeel more energised and prevents anaemia from occurring.';
      break;
    }

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
            Text('Medicine:- '+'$getName',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amberAccent),),
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
              saveMedicine();
            })
          ],
        ),
      ),

    );
  }

  void saveMedicine()async{
    String id = DateTime.now().millisecond.toString();
    await FirebaseFirestore.instance.collection('medicinecart').doc(getUid).collection('cartmedicine').doc(id).set({
      'name': getName,
      'price': getPrice,
      'date': selectDate,
      'time': selectTime,
    });
    showToast(message: 'Added');
  }
}
