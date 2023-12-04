import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/pages/find_doctor/book_appointment.dart';
class DoctorDetails extends StatefulWidget {
  final String? data;
  DoctorDetails({Key? key,this.data}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  String? collection;
  @override
  void initState() {
    collection = widget.data;
    getTitle();
    super.initState();
  }

  String?myTitle;
  void getTitle(){
    switch(collection){
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
            Text('$myTitle',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(collection!)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: new BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot  documentSnapshot = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Appointment(
                                title:collection ,
                                name: documentSnapshot.get('name'),
                                address: documentSnapshot.get('address'),
                                mobile:documentSnapshot.get('mobile') ,
                                fees:documentSnapshot.get('fees') ,

                              )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 80,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Doctor Name: '+documentSnapshot.get('name'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                  Text('Hospital Address: '+documentSnapshot.get('address'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text('Exp: '+documentSnapshot.get('exp'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                      Text('Mobile: '+documentSnapshot.get('mobile'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                      Text('Fees: '+documentSnapshot.get('fees'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),

    );
  }
}
