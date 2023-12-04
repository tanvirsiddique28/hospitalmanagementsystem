import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  String?getUid;
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  void getUserId() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final userId = await auth.currentUser?.uid;
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
            Text('Order Details',style: GoogleFonts.roboto(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 20,),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('appointmentbook')
                    .doc(getUid).collection('bookappointment')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot.data!
                              .docs[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Doctor Name: '+documentSnapshot.get('name'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                    Text('Hospital Address: '+documentSnapshot.get('address'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Date: '+documentSnapshot.get('date'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Time: '+documentSnapshot.get('time'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Fees: '+documentSnapshot.get('fees'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('labtestcart')
                    .doc(getUid).collection('cartlabtest')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot.data!
                              .docs[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Test Name: '+documentSnapshot.get('package'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Date: '+documentSnapshot.get('date'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Time: '+documentSnapshot.get('time'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Fees: '+documentSnapshot.get('fees'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('medicinecart')
                    .doc(getUid).collection('cartmedicine')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot.data!
                              .docs[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text('Medicine: '+documentSnapshot.get('name'),style:TextStyle(fontSize: 16,color: Colors.white),),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Date: '+documentSnapshot.get('date'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Time: '+documentSnapshot.get('time'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                        Text('Price: '+documentSnapshot.get('price'),style:TextStyle(fontSize: 16,color: Colors.amberAccent),),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return CircularProgressIndicator();
                  }
                }
            ),

          ],
        ),
      ),

    );
  }
}
