import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/views/ayat_view.dart';
import 'package:islamic_app/views/widgets/aya_item.dart';
import '../../cubits/quran_cubit/quran_cubit.dart';

import 'package:islamic_app/models/aya_model.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<AyatModel>? ayat;
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).ayaList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ayat = BlocProvider.of<QuranCubit>(context).ayaList;
    return SafeArea(
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          if (state is QuranDone) {
            return ListView.builder(
              itemCount: ayat!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<QuranCubit>(context)
                          .getCurrentPageSora(ayat![index].ayaPage);
                      globalPage = ayat![index].ayaPage - 1;
                      log("Global page = ${globalPage}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AyatView(
                                sorah: BlocProvider.of<QuranCubit>(context)
                                    .allSorahOfQuran[ayat![index].soraNumber]),
                          ));
                    },
                    child: AyaItem(ayat: ayat![index]),
                  ),
                );
              },
            );
          } else if (state is QuranSearch) {
            return Center(child: CircularProgressIndicator());
          }
          return Text("Please Search");
        },
      ),
    );
  }
}
