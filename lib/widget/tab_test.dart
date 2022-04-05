import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabTest extends StatefulWidget {
  const TabTest(
      {Key? key, required this.page, required this.bottomNavigationKey})
      : super(key: key);
  final int page;
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey;
  @override
  State<TabTest> createState() => _TabTestState();
}

class _TabTestState extends State<TabTest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(widget.page.toString(), textScaleFactor: 10.0),
            ElevatedButton(
              child: Text('Go To Page of index 0'),
              onPressed: () {
                //Page change using state does the same as clicking index 1 navigation button
                final CurvedNavigationBarState? navBarState =
                    widget.bottomNavigationKey.currentState;
                navBarState?.setPage(0);
              },
            )
          ],
        ),
      ),
    );
  }
}
