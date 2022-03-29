import 'package:flutter/material.dart';
import 'package:flutter_wechat/home/chat/chat_data.dart';
import 'package:flutter_wechat/home/search/search_bar.dart';

/*搜索页面*/
class SearchPage extends StatefulWidget {
  final List<Chat>? searchList; // 搜索列表
  const SearchPage({Key? key, this.searchList}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBar(onChange: (text) {
            print('搜索内容:$text');
          },),
          Expanded(
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                children: [
                  Text('aaa'),
                  Text('bbb'),
                  Text('ccc'),
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}
