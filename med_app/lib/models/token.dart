// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);

import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
    Token({
        this.token,
        this.channelName
    });

    String token;
    String channelName;
    factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
        channelName: json["channelName"]
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "channelName":channelName,
    };
}
