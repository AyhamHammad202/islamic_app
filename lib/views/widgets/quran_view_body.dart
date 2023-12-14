import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import 'hijri_widget_info.dart';

class QuranViewBody extends StatelessWidget {
  const QuranViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HijriWidgetInfo(),
        ),
        SliverToBoxAdapter(
          child: Text(
            S.of(context).lastRead,
          ),
        )
      ],
    );
  }
}
