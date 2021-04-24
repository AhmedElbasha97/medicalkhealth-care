// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  Blog({
    this.count,
    this.page,
    this.pages,
    this.results,
    this.totalResults,
  });

  int count;
  int page;
  int pages;
  List<Result> results;
  int totalResults;

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        count: json["count"],
        page: json["page"],
        pages: json["pages"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "page": page,
        "pages": pages,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "totalResults": totalResults,
      };
}

class Result {
  Result({
    this.authors,
    this.body,
    this.dataType,
    this.date,
    this.dateTime,
    this.dateTimePub,
    this.eventUri,
    this.image,
    this.isDuplicate,
    this.lang,
    this.relevance,
    this.sentiment,
    this.sim,
    this.source,
    this.time,
    this.title,
    this.uri,
    this.url,
    this.wgt,
  });

  List<Author> authors;
  String body;
  DataType dataType;
  DateTime date;
  DateTime dateTime;
  DateTime dateTimePub;
  String eventUri;
  String image;
  bool isDuplicate;
  Lang lang;
  int relevance;
  double sentiment;
  double sim;
  Source source;
  String time;
  String title;
  String uri;
  String url;
  int wgt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        authors: json["authors"] == null
            ? null
            : List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        body: json["body"],
        dataType: dataTypeValues.map[json["dataType"]],
        date: DateTime.parse(json["date"]),
        dateTime: DateTime.parse(json["dateTime"]),
        dateTimePub: DateTime.parse(json["dateTimePub"]),
        eventUri: json["eventUri"] == null ? null : json["eventUri"],
        image: json["image"] == null ? null : json["image"],
        isDuplicate: json["isDuplicate"],
        lang: langValues.map[json["lang"]],
        relevance: json["relevance"],
        sim: json["sim"].toDouble(),
        source: Source.fromJson(json["source"]),
        time: json["time"],
        title: json["title"],
        uri: json["uri"],
        url: json["url"],
        wgt: json["wgt"],
      );

  Map<String, dynamic> toJson() => {
        "authors": authors == null
            ? null
            : List<dynamic>.from(authors.map((x) => x.toJson())),
        "body": body,
        "dataType": dataTypeValues.reverse[dataType],
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "dateTime": dateTime.toIso8601String(),
        "dateTimePub": dateTimePub.toIso8601String(),
        "eventUri": eventUri == null ? null : eventUri,
        "image": image == null ? null : image,
        "isDuplicate": isDuplicate,
        "lang": langValues.reverse[lang],
        "relevance": relevance,
        "sentiment": sentiment,
        "sim": sim,
        "source": source.toJson(),
        "time": time,
        "title": title,
        "uri": uri,
        "url": url,
        "wgt": wgt,
      };
}

class Author {
  Author({
    this.isAgency,
    this.name,
    this.type,
    this.uri,
  });

  bool isAgency;
  String name;
  String type;
  String uri;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        isAgency: json["isAgency"],
        name: json["name"],
        type: json["type"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "isAgency": isAgency,
        "name": name,
        "type": type,
        "uri": uri,
      };
}

enum DataType { NEWS }

final dataTypeValues = EnumValues({"news": DataType.NEWS});

enum Lang { ENG }

final langValues = EnumValues({"eng": Lang.ENG});

class Source {
  Source({
    this.dataType,
    this.title,
    this.uri,
  });

  DataType dataType;
  String title;
  String uri;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        dataType: dataTypeValues.map[json["dataType"]],
        title: json["title"],
        uri: json["uri"],
      );

  Map<String, dynamic> toJson() => {
        "dataType": dataTypeValues.reverse[dataType],
        "title": title,
        "uri": uri,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
