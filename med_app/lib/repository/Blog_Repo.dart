import 'package:med_app/Models/ModelBlog.dart';
import 'package:med_app/services/BlogServices.dart';

class BlogRepo{
  BlogService _blogService = BlogService();
  Future<Blog> fetchBlogs() async {
    return _blogService.fetchBlogs();
  }
  Future<Blog> fetchNewsFeed() async {
    return _blogService.fetchtNewsFeed();
  }
  Future<Blog> fetchNiteration() async {
    return _blogService.fetchNitrition();
  }
  Future<Blog> fetchMedical() async {
    return _blogService.fetchMedical();
  }
}