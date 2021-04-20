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

        body: Consumer<BlogProvider>(builder: (buildContext, blogProvider, _) {
      return (blogProvider.medical != null)
          ? ListView.builder(
              itemCount: blogProvider.medical.length,
              itemBuilder: (ctx, index) {
                final person = blogProvider.medical[index];

                return GestureDetector(
                    child: BlogsCardList(
                      title: person.title,
                      subTitle: person.body,
                      imageURL: person.image,
                    ),
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlogsDetailedScreen(
                          title: person.title,
                          subTitle: person.body,
                          imageURL: person.image,
                          URI: person.url,
                          index: index,
                          date: person.date,
                        ),
                      ));
                    });
              },
            )
          : Center(child: CircularProgressIndicator());
    }));


  }
}
