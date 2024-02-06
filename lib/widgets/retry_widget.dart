import 'package:flutter/material.dart';

class RetryWidget extends StatefulWidget {
  final ThemeData? themeData;
  final VoidCallback? onRetried;

  const RetryWidget({super.key, this.themeData, this.onRetried});

  @override
  _RetryWidgetState createState() => _RetryWidgetState();
}

class _RetryWidgetState extends State<RetryWidget> {
  bool isRetried = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: isRetried
          ? <Widget>[
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(widget.themeData!.colorScheme.secondary),
              )
            ]
          : <Widget>[
              Text("Oops! Something went wrong !",
                  style: Theme.of(context).textTheme.bodyLarge),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        widget.themeData!.colorScheme.secondary)),
                child: Text("Retry",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: widget.themeData!.primaryColor)),
                onPressed: () {
                  setState(() {
                    isRetried = true;
                  });
                  widget.onRetried!();
                },
              )
            ],
    );
  }
}
