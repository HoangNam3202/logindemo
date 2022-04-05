import 'package:flutter/material.dart';
import 'package:logindemo/widget/header_tab_test_header.dart';

class TabTestHeader extends StatelessWidget {
  const TabTestHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: HeaderTabTestHeader(),
        ),
        SliverFillRemaining(
          child: Text('data'),
        ),
      ],
    );
  }
}
