import 'package:flutter/material.dart';
import 'package:flutter_application_2/modals/hoteldata.dart';
import 'package:flutter_application_2/widgets/grid_hotels.dart';

class AllHotels extends StatefulWidget {
  final ThemeData? themeData;
  final List<Hotel>? hotels;
  const AllHotels({super.key, this.themeData, this.hotels});
  @override
  _AllHotelsState createState() => _AllHotelsState();
}

class _AllHotelsState extends State<AllHotels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'All Hotels',
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
        body: Container(
          padding: const EdgeInsets.only(top: 8.0),
          color: widget.themeData!.primaryColor,
          child: Center(
            child: GridHotels(
              themeData: widget.themeData,
            ),
          ),
        ));
  }
}
