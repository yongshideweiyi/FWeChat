import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wechat/home/chat/chat_data.dart';
import 'package:flutter_wechat/home/chat/chat_search_cell.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
/*
AutomaticKeepAliveClientMixin是混入，可以让页面状态保持，切换之后不会重新渲染，需要重写wantKeepAlive
*/
class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  // 聊天列表
  List<Chat> _chatList = [];

  @override
  void initState() {
    // TODO: implement initState
    getConversationList().then((List<Chat> value) {
      setState(() {
        _chatList = value;
      });
    }).catchError((e) {
      print('请求出错信息:$e');
    }).whenComplete(() {
      print('网络请求完成');
    }).timeout(
        const Duration(seconds: 10)
    ).catchError((timeout) {
      print('请求超时:$timeout');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('微信', style: TextStyle(fontSize: 16),),
      ),
      body: Container(
        color: Colors.white,
        child: FutureBuilder(
          future: getConversationList(),
          builder: (BuildContext contest, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('正在加载数据...'),
              );
            } else {
              return ListView.builder(itemBuilder: _itemBuilderForRow, itemCount: _chatList.length + 1,);
            }
          },
        ),
      ),
    );
  }

  // 从网络请求获取聊天列表
  Future<List<Chat>> getConversationList() async {
    var response = await Dio().get('http://rap2api.taobao.org/app/mock/293614/api/chat/list');
    if (response.statusCode == 200) {
      final responseBody = response.data;
      List<Chat> chatList = responseBody['chat_list'].map<Chat>( (item) => Chat.formMap(item)).toList();
      return chatList;
    } else {
      throw Exception('statusCode:${response.statusCode}, statusMessage:${response.statusMessage}');
    }
  }

  Widget _itemBuilderForRow(BuildContext context, int index) {
    if (index == 0) { // 第一行显示搜索输入框
      return ChatSearchCell(list: _chatList,);
    }
    index--;
    return ListTile(
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: NetworkImage(_chatList[index].avatar ?? '')
          )
        ),
      ),
      title: Text(_chatList[index].name ?? ''),
      subtitle: Container(
        alignment: Alignment.bottomLeft,
        child: Text(_chatList[index].message ?? '', overflow: TextOverflow.ellipsis,), // ellipsis溢出的文本显示为...
      ),
      trailing: const Icon(Icons.keyboard_arrow_right), // 箭头
      contentPadding: const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
      onTap: () {

      },
    );
  }
}
