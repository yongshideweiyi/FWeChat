import 'package:flutter/material.dart';
import 'package:flutter_wechat/home/chat/chat_data.dart';
import 'package:flutter_wechat/tools/theme.dart';
/*聊天列表上部搜索框*/
class ChatSearchCell extends StatelessWidget {
  final List<Chat>? list;
  // 构造函数
  ChatSearchCell({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: themeAppBarColor,
      padding: const EdgeInsets.all(5),
      height: 45,
      child: Stack(
        alignment: Alignment.center, // 部件居中对齐
        children: [
          Container( // 白底，圆角为8
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // 主轴居中对齐
            children: const [
              Icon(Icons.search, color: Colors.grey), // 搜索图标
              Text('搜索', style: TextStyle(fontSize: 15, color: Colors.grey))
            ],
          )
        ],
      ),
    );
  }
}
