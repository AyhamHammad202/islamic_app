import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/cubits/cubit/quran_cubit.dart';
import 'package:islamic_app/models/aya_model.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  List<AyatModel>? a;
  @override
  void initState() {
    BlocProvider.of<QuranCubit>(context).ayaList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    a = BlocProvider.of<QuranCubit>(context).ayaList;
    return SafeArea(
      child: Column(
        children: [
          SearchBar(
            onChanged: (value) {
              BlocProvider.of<QuranCubit>(context).search(value.trim());
            },
          ),
          BlocBuilder<QuranCubit, QuranState>(
            builder: (context, state) {
              log(" llllllllllllllllllllllllllllllllll ${a!.length} lllllllllllllllllllllll");
              if (state is QuranDone) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: a!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          a![index].ayaText,
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: kFontUthmanicHafs,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else if (state is QuranSearch) {
                return CircularProgressIndicator();
              }
              return Text("Please Search");
            },
          )
        ],
      ),
    );
  }
}
