import 'package:flutter/material.dart';
import 'package:med_app/Models/ModelBlog.dart';
import 'package:med_app/repository/Blog_Repo.dart';
class BlogProvider extends ChangeNotifier{
  List<Result> blogs;
  List<Result> newsFeed;
  List<Result> nuitrition;
  List<Result> medical;
  int counter = 1;
  BlogRepo _blogRepo = BlogRepo();

  BlogProvider(){
    getBlogAtFrist();
    getNewsForList();
    getMedicalForList();
    getNutritionForList();

  }

  void getBlogAtFrist() async {
    _blogRepo.fetchBlogs().then((newBlogs) {
      blogs = newBlogs.results;
      notifyListeners();
    });


  }
  void getNewsForList() async {
      _blogRepo.fetchNewsFeed().then((newFeeds) {
        newsFeed = newFeeds.results;
        notifyListeners();
      });
  }
  void getMedicalForList() async {
    _blogRepo.fetchMedical().then((newFeeds) {
      medical = newFeeds.results;
      notifyListeners();
    });
  }
  void getNutritionForList() async {
    _blogRepo.fetchNiteration().then((newFeeds) {
      nuitrition = newFeeds.results;
      notifyListeners();
    });
  }
}
