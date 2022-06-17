import 'package:flutter/material.dart';
import 'package:news_app_flutter/model/headlines_model.dart';

class DetailScreen extends StatelessWidget{
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Articles;
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail News"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Container(
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(article.urlToImage ?? "")
                          )
                      ),
                    ),
                Text(article.title!,style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold)),
                Text(article.publishedAt!,style: const TextStyle(fontSize: 12,fontStyle: FontStyle.italic)),
                Text(article.author ?? "",style: const TextStyle(fontSize: 12,fontStyle: FontStyle.italic)),
                Row(
                  children: [
                    Expanded(
                    child: Text(article.content!, style: const TextStyle(fontSize: 14),),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}