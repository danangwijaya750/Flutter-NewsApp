import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app_flutter/provider/data_provider.dart';

import 'detail_screen.dart';

class SearchScreen extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}
class _SearchScreenState extends ConsumerState{

  final TextEditingController _controller = TextEditingController();
  String search="";
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if(_controller.text.isNotEmpty) {
        search = _controller.text;
        ref.watch(searchHeadlineDataProvider(_controller.text));
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var data = ref.watch(searchHeadlineDataProvider(search));

    return Scaffold(
      appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.search,
                onSubmitted: (value){

                },
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: data.when(
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


