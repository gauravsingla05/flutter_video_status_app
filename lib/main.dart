import 'package:flutter/material.dart';
import 'package:flutter_video/Admin.dart';
import 'package:flutter_video/home.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_video/tabs/cat.dart';
import 'package:fluttertoast/fluttertoast.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    final navigatorKey = GlobalKey<NavigatorState>();
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(


          drawer: new Drawer(
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                  accountName: new Text("Pratap Kumar"),
                  accountEmail: new Text("kprathap23@gmail.com"),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage('assets/images/lake.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/men/46.jpg")),
                ),
                new ListTile(
                    leading: Icon(Icons.library_music),
                    title: new Text("Music"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.movie),
                    title: new Text("Movies"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: new Text("Shopping"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.apps),
                    title: new Text("Apps"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.dashboard),
                    title: new Text("Docs"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
                new ListTile(
                    leading: Icon(Icons.settings),
                    title: new Text("Settings"),
                    onTap: () {
                      navigatorKey.currentState.push(
                        MaterialPageRoute(builder: (context) => Cat()),
                      );
                    }),
                new Divider(),
                new ListTile(
                    leading: Icon(Icons.info),
                    title: new Text("Admin"),
                    onTap: () {
                      navigatorKey.currentState.push(
                        MaterialPageRoute(builder: (context) => Admin()),
                      );
                    }),
                new ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: new Text("Logout"),
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        body: DefaultTabController(
              length: 3,
              child:NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                    return <Widget>[
                    SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Status Media",
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    )),
                    background:Carousel(
                      images: [
                        new NetworkImage('https://cdn-images-1.medium.com/max/2000/1*GqdzzfB_BHorv7V2NV7Jgg.jpeg'),
                        new NetworkImage('https://cdn-images-1.medium.com/max/2000/1*wnIEgP1gNMrK5gZU7QS0-A.jpeg'),
                        new ExactAssetImage("assets/images/LaunchImage.jpg")
                      ],
                      dotSize: 4.0,
                      dotSpacing: 15.0,
                      dotColor: Colors.red,
                      indicatorBgPadding: 5.0,
                      dotBgColor: Colors.purple.withOpacity(0.5),
                      borderRadius: true,
                    )),
                    ),

                  

                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(

                          indicatorColor: Colors.red,
                          labelColor: Colors.black87,
                          unselectedLabelColor: Colors.grey,

                          tabs: [
                            new Tab(icon: new Icon(Icons.home),),
                            new Tab(icon: new Icon(Icons.category)),
                            new Tab(icon: new Icon(Icons.whatshot)),
                          ],

                        ),
                      ),
                      pinned: true,
                    ),
                    ];
                  },

                  body: TabBarView(
                      children: [
                    Home(),
                   Cat(),
                    new Icon(Icons.directions_bike,size: 50.0,),
                  ]))
        ),

      ),
    );
  }
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }


  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
