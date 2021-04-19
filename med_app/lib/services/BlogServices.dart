import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:med_app/Models/ModelBlog.dart';

class BlogService {
  Future<Blog> fetchBlogs() async {
    final response = await http.get(Uri.parse('https://med-app-701e8-default-rtdb.firebaseio.com/Blogs.json'));
    if (response.statusCode == 200) {
      return blogFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD Blogs');
    }
  }

  Future<Blog> fetchtNewsFeed() async {
    final response = await http.get(
        Uri.parse('https://med-app-701e8-default-rtdb.firebaseio.com/NewsFeed.json'));
    if (response.statusCode == 200) {

      return blogFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD Blogs');
    }
  }
  Future<Blog> fetchMedical() async {
    final response = await http.get(
        Uri.parse('https://med-app-701e8-default-rtdb.firebaseio.com/%20Medical.json'));
    if (response.statusCode == 200) {
      return blogFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD Blogs');
    }
  }
  Future<Blog> fetchNitrition() async {
    final response = await http.get(
        Uri.parse('https://med-app-701e8-default-rtdb.firebaseio.com/Health%20.json'));
    if (response.statusCode == 200) {
      return blogFromJson(response.body);
    } else {
      throw Exception('FAILED TO LOAD Blogs');
    }
  }

}