
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_flutter/model/headlines_model.dart';
import 'package:news_app_flutter/service/api_service.dart';

final headlinesDataProvider = FutureProvider<HeadlinesModel>((data) async{
  return data.read(apiProvider).getHeadlines();
});

final searchHeadlineDataProvider = FutureProvider.family<HeadlinesModel,String>((data,q) async{
  return data.read(apiProvider).searchHeadlines(q);
});