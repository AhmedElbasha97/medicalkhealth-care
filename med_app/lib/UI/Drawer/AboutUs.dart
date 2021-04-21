import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html_textview/flutter_html_textview.dart';
import 'package:med_app/Styles/colors.dart';


class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsCollection.mainColor,
        elevation: 0.0,
        title:Row(
          children: <Widget>[
            Text("About US"),
          ],
        ),
      ),
      body: Container(

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new HtmlTextView(data:"<p>We are a group of health care and IT professionals with a special interest in taking new and innovative ideas to light. We have a passion for developing new products exclusively targeted and tailored towards the medical sector. We have been working with app and website development since 1999.</p>\r\n\r\n<p></p>\r\n\r\n<p>Our main headquarters is in Cairo, Egypt. Our Europe office with an office in Bosnia and Herzegovina. Our USA branch in Delaware will soon be open.</p>\r\n\r\n<p></p>\r\n\r\n<p><strong>Main office:</strong>21 Gaber Ibn Hayan Street, Dokki, Giza, Egypt</p>\r\n\r\n<p></p>\r\n\r\n<h2>Partner with us</h2>\r\n\r\n<p></p>\r\n\r\n<p>We are looking to expand the utility of online medical consultations globally. We are working to make our <strong>Web Cam Clinics</strong> the number one platform in the field of internet medical consultation and to be available to every doctor and patient world-wide. We welcome potential partners:</p>\r\n\r\n<p></p>\r\n\r\n<ul>\r\n\t<li><strong>Investors</strong></li>\r\n\t<li><strong>Payment platforms</strong></li>\r\n\t<li><strong>Banks / Credit card providers</strong></li>\r\n\t<li><strong>Distributors</strong></li>\r\n\t<li><strong>Hospitals</strong>and<strong>Medical Centers</strong></li>\r\n\t<li><strong>Pharmaceutical Industry</strong></li>\r\n</ul>\r\n\r\n<p></p>\r\n\r\n<p></p>"),
            ],
          ),
        ),
      ),
    );
  }
}
