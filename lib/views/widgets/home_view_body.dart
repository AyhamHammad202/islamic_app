import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/cubits/cubit/quran_cubit.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/models/sura_model.dart';
import 'package:islamic_app/views/widgets/sura_tile.dart';
import 'package:islamic_app/views/widgets/tab_bar_home_view.dart';

import 'custom_app_bar.dart';
import 'last_read_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<QuranCubit>(context).getAllSuraOfQuran();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          SizedBox(height: 24),
          Text(
            S.of(context).lastRead,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 85,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) {
                return LastReadItem();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TabBarHomeView(),
          ),
          SizedBox(height: 16),
          BlocBuilder<QuranCubit, QuranState>(
            builder: (context, state) {
              final List<SuraModel> allSuras =
                  BlocProvider.of<QuranCubit>(context).suras;

              return Expanded(
                child: ListView.builder(
                  itemCount: allSuras.length,
                  itemBuilder: (context, index) =>
                      SuraTile(sura: allSuras[index]),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
