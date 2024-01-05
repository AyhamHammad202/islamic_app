import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/cubits/quran_cubit/quran_cubit.dart';

import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String id = "Search-View";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width - 30,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextField(
            decoration: InputDecoration(
                hintText: "أبحث بأستخدام الآية أو رقم الصفحة أو اسم السورة",
                hintStyle: TextStyle(
                  fontFamily: kFontNotoNaskhArabic,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r))),
            onChanged: (value) {
              BlocProvider.of<QuranCubit>(context).search(value.trim());
            },
          ),
        ),
      ),
      body: SearchViewBody(),
    );
  }
}
