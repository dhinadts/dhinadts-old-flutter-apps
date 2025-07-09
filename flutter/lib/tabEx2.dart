import 'package:flutter/material.dart';


List<Map<String, dynamic>> pal;

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);
  @override
  _MyTabbedPageState createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ARAM'),
    Tab(text: 'PORUL'),
    Tab(text: 'Inpam')
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    // void _tabC() async {
    //   var db = DatabaseHelper();

    //   pal = await db.any_query(
    //       'select DISTINCT pal_tamil from complete1', 'modi_kural_comp.db');
    //   // List.generate([pal].length, (i) {
    //   //   Pal(
    //   //     pal_tamil: result[i]['pal_tamil'],
    //   //   );
    //   // });
    // }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          final String label = tab.text.toLowerCase();
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
    );
  }
}
