import 'package:flutter/material.dart';
import 'package:hospital_management_system/pages/health_articles/articles_details.dart';
class HealthArticles extends StatefulWidget {
  const HealthArticles({Key? key}) : super(key: key);

  @override
  State<HealthArticles> createState() => _HealthArticlesState();
}

class _HealthArticlesState extends State<HealthArticles> {

  List<String> articles = ['Walking Daily','Home Care of Covid-19','Stop Smoking','Menstrual Cramps','Healthy Gut'];

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
        padding: EdgeInsets.fromLTRB(16, 70, 10, 5),
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/primaryback.jpg'),
              fit: BoxFit.fill,
            )
        ),
        child:Column(
          children: [
              Expanded(
                child: ListView.separated(
                    itemCount: articles.length,
                    separatorBuilder: (context,index){
                      return Divider(height: 20,thickness: 1);
                    },
                    itemBuilder: (context,index){
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HealthDetails(title:articles[index])));
                      },
                      child:  Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: ListTile(
                          leading: Text('${index+1}',style:TextStyle(color: Colors.white) ,),
                          title: Text(articles[index],style: TextStyle(color: Colors.white),),
                          trailing: Text('Click More Details',style: TextStyle(color: Colors.amberAccent),),
                        ),
                      ),
                    );
                    }


                )
              )
          ],
        )
      ),
    );
  }
}

// ListView.builder(
// itemCount: articles.length,
// itemBuilder: (context,index){
// Divider(height: 20,thickness: 1,) ;
// return ListTile(
// leading: Text('${index+1}',style:TextStyle(color: Colors.white) ,),
// title: Text(articles[index],style: TextStyle(color: Colors.white),),
// trailing: Text('Click More Details',style: TextStyle(color: Colors.amberAccent),),
// );
// }
// ),