import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/festivaldata.dart';
import 'package:flutter_application_2/widgets/grid_festivals.dart';

class AllFestivals extends StatefulWidget {
  final List<Festival>? festivals;
  final ThemeData? themeData;
  const AllFestivals({super.key, this.festivals, this.themeData});
  @override
  _AllFestivalsState createState() => _AllFestivalsState();
}

class _AllFestivalsState extends State<AllFestivals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'All festivals',
          style: widget.themeData!.textTheme.headlineSmall,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: widget.themeData!.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: widget.themeData!.primaryColor,
      ),
      body: GridFestivals(
          themeData: widget.themeData, festivals: widget.festivals),
    );
  }
}
