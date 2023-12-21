import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/models/sorah_model.dart';

import '../../cubits/quran_cubit/quran_cubit.dart';
import 'sorah_tile.dart';

class AllSorahListView extends StatefulWidget {
  const AllSorahListView({super.key});

  @override
  State<AllSorahListView> createState() => _AllSorahListViewState();
}

class _AllSorahListViewState extends State<AllSorahListView> {
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).all();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<SorahModel> allSorah =
        BlocProvider.of<QuranCubit>(context).allSorahOfQuran;
    return BlocBuilder<QuranCubit, QuranState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: allSorah.length,
          itemBuilder: (context, index) {
            return SorahTile(sorah: allSorah[index]);
          },
        );
      },
    );
    // return ListView.custom(
    //   semanticChildCount: allSorah.length,
    //   childrenDelegate: SliverChildBuilderDelegate(
    //     (context, index) => SorahTile(
    //       sorah: allSorah[index],
    //     ),
    //   ),
    // );
  }
}
