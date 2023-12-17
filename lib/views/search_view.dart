import 'package:flutter/material.dart';

import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String id = "Search-View";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchViewBody(),
    );
  }
}
