import 'package:flutter/material.dart';
import 'package:flutter_wechat/tools/const.dart';
import 'package:flutter_wechat/tools/theme.dart';

/*搜索输入框*/
class SearchBar extends StatefulWidget {
  // 文本输入回调函数
  final ValueChanged<String>? onChange;
  const SearchBar({Key? key, this.onChange}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  // 清除按钮控制
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClearBtn = false; // 是否隐藏清除按钮

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
      height: statusBarHeight + 45,
      color: themeAppBarColor,
      child: Column(
        children: [
          SizedBox(height: statusBarHeight,),
          SizedBox(
            height: 45,
            child: Row(
              children: [
                Container(
                  width: screenWidth(context) - 44,
                  height: 35,
                  margin: const EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(child: Icon(Icons.search, color: Colors.grey,), width: 20,),
                      Expanded(
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: _textFieldOnChange,
                            autofocus: true, // 输入框第一响应
                            cursorColor: Colors.green, // 光标颜色
                            style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300), // 输入文字大小颜色
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 5, bottom: 10), // 输入框边框
                              border: InputBorder.none, // 隐藏输入框下方黑线
                              hintText: '搜索' // 占位符
                            ),
                          )
                      ),
                      if (_showClearBtn) GestureDetector(
                        onTap: () {
                          // 清除文本内容
                          _textEditingController.clear();
                          _textFieldOnChange('');
                        },
                        child: const Icon(Icons.cancel, size: 20, color: Colors.grey,),
                      ) // 清除按钮
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text('取消'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _textFieldOnChange(String text) {
    if (widget.onChange != null) {
      widget.onChange!(text);
    }
    setState(() {
      _showClearBtn = text.isNotEmpty;
    });
  }
}
