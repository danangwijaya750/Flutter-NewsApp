import 'dart:convert';
import 'package:news_app_flutter/config/constant_config.dart';
import 'package:news_app_flutter/model/headlines_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

class ApiService{
  String base_url ="https://newsapi.org/v2/";
  final ConstantConfig config = ConstantConfig();

  Future<HeadlinesModel> getHeadlines() async{
    String url = "$base_url/top-headlines?country=id&apiKey=${config.API_KEY}";
    Response res = await get(Uri.parse(url));
    if(res.statusCode==200){
      return HeadlinesModel.fromJson(jsonDecode(res.body));
    }else{
      print(res.reasonPhrase);
      print(res.body);
      throw Exception(res.reasonPhrase);
    }
  }
  Future<HeadlinesModel> searchHeadlines(String q) async{
    String url = "$base_url/top-headlines?country=id&q=$q&apiKey=${config.API_KEY}";
    print(url);
    Response res = await get(Uri.parse(url));
    if(res.statusCode==200){
      return HeadlinesModel.fromJson(jsonDecode(res.body));
    }else{
      print(res.reasonPhrase);
      print(res.body);
      throw Exception(res.reasonPhrase);
    }
  }

}
final apiProvider = Provider<ApiService>((ref) => ApiService());