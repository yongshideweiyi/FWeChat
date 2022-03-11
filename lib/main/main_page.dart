import 'package:flutter/material.dart';
import 'package:flutter_wechat/contacts/contacts_page.dart';
import 'package:flutter_wechat/found/found_page.dart';
import 'package:flutter_wechat/home/home_page.dart';
import 'package:flutter_wechat/mine/mine_page.dart';
/*主页面*/
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _currentIndex = 0; // 默认选中第一个页面

  // 首页，通讯录，发现，我
  final List<Widget> _pages = [const HomePage(), const ContactsPage(), const FoundPage(), const MinePage()];
  final PageController _pageController = PageController(initialPage: 0);

  void _itemTap(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        physics: const NeverScrollableScrollPhysics(), // 禁止拖拽滑动切换页面
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        onTap: _itemTap,
        items: const [
          BottomNavigationBarItem(
            label: '微信',
            icon: Image(image: AssetImage('res/images/message_normal.png'), width: 20, height: 20,),
            activeIcon: Image(image: AssetImage('res/images/message_selected.png'), width: 20, height: 20,),
          ),
          BottomNavigationBarItem(
            label: '通讯录',
            icon: Image(image: AssetImage('res/images/txl_normal.png'), width: 20, height: 20,),
            activeIcon: Image(image: AssetImage('res/images/txl_selected.png'), width: 20, height: 20,),
          ),
          BottomNavigationBarItem(
            label: '发现',
            icon: Image(image: AssetImage('res/images/fx_normal.png'), width: 20, height: 20,),
            activeIcon: Image(image: AssetImage('res/images/fx_selected.png'), width: 20, height: 20,),
          ),
          BottomNavigationBarItem(
            label: '我的',
            icon: Image(image: AssetImage('res/images/me_normal.png'), width: 20, height: 20,),
            activeIcon: Image(image: AssetImage('res/images/me_selected.png'), width: 20, height: 20,),
          ),
        ],
      ),
    );
  }
}
