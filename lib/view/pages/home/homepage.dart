import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:food/view/pages/cart/carthistory.dart';
import 'package:food/view/pages/order/historyorder.dart';
import 'package:food/view/utils/appcolor.dart';

import '../account/account_page.dart';
import 'mainfoodpage.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  
  var Listpages = <Widget>[
    const mainfoodpage(),
      const order_history(),
      const cartHistory(),
    
      
       accountpage()
  ];
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listpages[_page],
      bottomNavigationBar: FlashyTabBar(
        selectedIndex: _page,
        height: 55,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _page = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(
              Icons.home,
              color: AppColor.maincolor,
            ),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.archive,
              color: AppColor.maincolor,
            ),
            title: const Text('History'),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.shopping_cart,
              color: AppColor.maincolor,
            ),
            title: const Text('Cart'),
          ),
          FlashyTabBarItem(
            icon: const Icon(
              Icons.person,
              color: AppColor.maincolor,
            ),
            title: const Text('Me'),
          ),
        ],
      ),
    );
  }
}
