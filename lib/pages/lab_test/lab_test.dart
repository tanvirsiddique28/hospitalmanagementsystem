
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hospital_management_system/pages/lab_test/lab_test_details.dart';
class LabTest extends StatefulWidget {
  const LabTest({Key? key}) : super(key: key);

  @override
  State<LabTest> createState() => _LabTestState();
}

class _LabTestState extends State<LabTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('24*7 HEALTHCARE'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/mainback.png'),
              fit: BoxFit.fill,
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('Deliver Location: Dhaka',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            Text('Lab test and packages',style: GoogleFonts.roboto(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amberAccent),),
            SizedBox(height: 20,),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("labtest")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot  documentSnapshot = snapshot.data!.docs[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LabTestDetails(
                                name: documentSnapshot.get('name'),
                                price: documentSnapshot.get('price'),
                                id:documentSnapshot.get('id') ,

                              )));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(documentSnapshot.get('name'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(documentSnapshot.get('price')+' tk',style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
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
