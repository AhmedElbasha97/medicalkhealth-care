import 'package:flutter/material.dart';
import 'package:med_app/Widgets/Blogs_Card_List.dart';
import 'package:provider/provider.dart';
import '../../provider/Blog_Provider.dart';
import 'BlogsDetailsScreen.dart';
class NutritionalListScreen extends StatefulWidget {
  @override
  _NutritionalListScreenState createState() => _NutritionalListScreenState();
}

class _NutritionalListScreenState extends State<NutritionalListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Consumer<BlogProvider>(
            builder: (buildContext, BlogProvider, _) {

              return (BlogProvider.nuitrition != null)
                  ? ListView.builder(
                  itemCount: BlogProvider.nuitrition.length,
                  itemBuilder: (ctx, index) {
                    final person = BlogProvider.nuitrition[index];

                    return GestureDetector(
                      child: BlogsCardList(Title: person.title,subTitle: person.body,imageURL: person.image,),
                      onTap: () async{

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                    BlogsDetailedScreen(title: person.title,SubTitle: person.body,imageURL: person.image,URI: person.url,Index: index, Date: person.date,),));



                        }
                    ); },): Center(child: CircularProgressIndicator());
                  })

            );
   

  }

}
