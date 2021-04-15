import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'package:med_app/Models/ModelBlog.dart';
import 'package:med_app/Repo/Blog_Repo.dart';
class BlogProvider extends ChangeNotifier{
  List<Result> Blogs;
  List<Result> NewsFeed;
  List<Result> nuitrition;
  List<Result> Medical;
  int counter = 1;
  BlogRepo _blogRepo = BlogRepo();

  BlogProvider(){
    getBlogAtFrist();
    getNewsForList();
    getMedicalForList();
    getNutritionForList();

  }

  void getBlogAtFrist() async {
    _blogRepo.fetchBlogs().then((NewBlogs) {
      Blogs = NewBlogs.results;
      notifyListeners();
    });


  }
  void getNewsForList() async {
      _blogRepo.fetchNewsFeed().then((NewFeeds) {
        NewsFeed = NewFeeds.results;
        notifyListeners();
      });
  }
  void getMedicalForList() async {
    _blogRepo.fetchMedical().then((NewFeeds) {
      Medical = NewFeeds.results;
      notifyListeners();
    });
  }
  void getNutritionForList() async {
    _blogRepo.fetchNiteration().then((NewFeeds) {
      nuitrition = NewFeeds.results;
      notifyListeners();
    });
  }
}
