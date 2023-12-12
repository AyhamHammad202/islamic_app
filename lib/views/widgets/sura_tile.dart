import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/cubits/cubit/quran_cubit.dart';
import 'package:islamic_app/models/sura_model.dart';
import 'package:islamic_app/views/sura_view.dart';

class SuraTile extends StatelessWidget {
  const SuraTile({super.key, required this.sura});
  final SuraModel sura;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
    BlocProvider.of<QuranCubit>(context).getAllAyaOfSura(sura);
          Navigator.pushNamed(context, SuraView.id);
        },
        child: Container(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ayaFram),
                      ),
                    ),
                    child: Center(
                      child: Text("${sura.index}",
                          style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(sura.titleEn),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            "${sura.allAyaNumber} Verses",
                            style: TextStyle(
                              color: secondlyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            child: VerticalDivider(
                              color: secondlyColor,
                              thickness: 1,
                              width: 10,
                            ),
                          ),
                          Text(
                            sura.type,
                            style: TextStyle(
                              color: secondlyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Text(
                    sura.titleAr,
                    style: TextStyle(
                      color: secondlyColor,
                      fontSize: 24,
                      fontFamily: fontUthmanicHafs,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
              SizedBox(height: 16),
              Divider(
                thickness: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
