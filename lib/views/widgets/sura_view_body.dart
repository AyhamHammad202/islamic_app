import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/cubits/cubit/quran_cubit.dart';
import 'package:islamic_app/models/aya_model.dart';
import 'package:islamic_app/models/sura_model.dart';
import 'package:islamic_app/views/widgets/aya_container.dart';

import 'custom_app_bar.dart';
import 'sura_info_contianer.dart';

class SuraViewBody extends StatelessWidget {
  const SuraViewBody({
    super.key,
    required this.sura,
  });

  final SuraModel sura;

  @override
  Widget build(BuildContext context) {
    final List<AyaModel> allAya =
        BlocProvider.of<QuranCubit>(context).allAyaOfSura!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomAppBar(
            title: sura.nameTranslation,
            icon: Icons.edit_note,
          ),
          SizedBox(height: 24),
          SuraInfoContainer(sura: sura),
          Expanded(
            child: ListView.builder(
              itemCount: allAya.length,
              itemBuilder: (context, index) => AyaContainer(
                aya: allAya[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
