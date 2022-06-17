import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_flutter/provider/data_provider.dart';
import 'package:news_app_flutter/screen/detail_screen.dart';
import 'package:news_app_flutter/screen/search_screen.dart';

class HomeScreen extends ConsumerWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(headlinesDataProvider);
    return Scaffold(
     appBar: AppBar(
      title: const Text('Top Headlines'),
       actions: [
         IconButton(
             onPressed: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>SearchScreen())),
             icon: const Icon(Icons.search))
       ],
     ),
     body:  data.when(
         data: (headline){
           return Center(
             child: ListView.builder(
               itemCount: headline.articles!.length,
               itemBuilder: (BuildContext ctx, int idx) {
                 final article = headline.articles![idx];
                 return GestureDetector(
                   child: Card(
                     child: SizedBox(
                       height: 300,
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                               child: Container(
                                 decoration: BoxDecoration(
                                     image: DecorationImage(
                                         fit: BoxFit.cover,
                                         image: NetworkImage(article.urlToImage ?? "")
                                     )
                                 ),
                               )),
                           Text(article.title!,style: const TextStyle(fontSize: 18,fontWeight:FontWeight.bold)),
                           Text(article.publishedAt!,style: const TextStyle(fontSize: 12,fontStyle: FontStyle.italic)),
                           Text(article.description!,style: const TextStyle(fontSize: 14))
                         ],
                       ),
                     ),
                   ),
                   onTap: (){
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context)=> DetailScreen(),
                             settings: RouteSettings(arguments: article)
                         ));
                   },
                 );
               },
             ),
           );
         },
         error:(err, s) => Text(err.toString()) ,
         loading: () => const Center(
           child: CircularProgressIndicator(),
         )),

    );
  }

}
