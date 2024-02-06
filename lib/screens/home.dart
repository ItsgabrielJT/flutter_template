import 'package:flutter_application_2/theme/theme_state.dart';
import 'package:flutter_application_2/widgets/sliding_festivals.dart';
import 'package:flutter_application_2/widgets/sliding_hotels.dart';
import 'package:provider/provider.dart';

import '../screens/settings.dart';
import '../widgets/sliding_attractions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);
    return Theme(
      data: state.themeData,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            elevation: 5,
            title: Text(
              'Visit Nepal',
              style: state.themeData.textTheme.headlineSmall,
            ),
            leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: state.themeData.colorScheme.secondary,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
            backgroundColor: state.themeData.primaryColor),
        drawer: const Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 50, 25),
          child: SettingsPage(),
        ),
        body: Container(
            color: state.themeData.primaryColor,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                SlidingPlacesView(themeData: state.themeData),
                SlidingHotelsView(themeData: state.themeData),
                SlidingFestivalsView(themeData: state.themeData),
              ],
            )),
      ),
    );
  }
}
