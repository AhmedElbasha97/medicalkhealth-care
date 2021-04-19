import 'package:flutter/material.dart';
import 'package:med_app/Widgets/Blogs_Card_List.dart';
import 'package:provider/provider.dart';
import '../../provider/Blog_Provider.dart';
import 'BlogsDetailsScreen.dart';
class MedicalListScreen extends StatefulWidget {
  @override
  _MedicalListScreenState createState() => _MedicalListScreenState();
}

class _MedicalListScreenState extends State<MedicalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: ChangeNotifierProvider<BlogProvider>(
            create: (context) => BlogProvider(),
            child: Consumer<BlogProvider>(
                builder: (buildContext, BlogProvider, _) {


                  return (BlogProvider.Medical != null)
                      ? ListView.builder(
                    itemCount: BlogProvider.Medical.length,
                    itemBuilder: (ctx, index) {
                      final person = BlogProvider.Medical[index];

                      return GestureDetector(
                          child: BlogsCardList(Title: person.title,subTitle: person.body,imageURL: person.image,),
                          onTap: () async{

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BlogsDetailedScreen(title: person.title,SubTitle: person.body,imageURL: person.image,URI: person.url,Index: index, Date: person.date,),));



                          }
                      ); },): Center(child: CircularProgressIndicator());
                })

        )
    );

  }

}