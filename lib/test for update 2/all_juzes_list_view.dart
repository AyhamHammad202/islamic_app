import 'package:flutter/material.dart';

class AllJuzesListView extends StatelessWidget {
  const AllJuzesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: 30,
      itemBuilder: (context, index) {
        return const JuzTile();
      },
    );
  }
}

class JuzTile extends StatelessWidget {
  const JuzTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("1");
  }
}
