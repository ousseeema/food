import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food/view/utils/appcolor.dart';

class order_history extends StatefulWidget {
  const order_history({super.key});

  @override
  State<order_history> createState() => _order_historyState();
}

class _order_historyState extends State<order_history> with TickerProviderStateMixin{
  

  
  @override
  Widget build(BuildContext context) {
    TabController tabController= TabController(length: 2, vsync: this);
    return  Scaffold(
      appBar: AppBar(
        title: 
      const Text('Order History'),
      centerTitle: true,
      backgroundColor: AppColor.maincolor,
        toolbarHeight: 80,
        
      
      
      ),
      body: Column(
        children: [
          Container(
            //height: 90,
            // ! with  tabbar if faut toujours ajoute tabbarview (controller wahed naamla fi zouz )
            child: TabBar(
              controller:  tabController,
               indicatorColor: AppColor.maincolor,
              tabs: const [
                Tab(
                  text: "Order List",
                ), 
                Tab(text: " History List"),


              ]
                ),
              
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                 Center(child: Text("No Order Data", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),))
                , Center(child: Text("No Order History", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)))
              ]),
          )

         

        ],
      ),



    );
  }
}