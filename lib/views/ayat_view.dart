import 'package:flutter/material.dart';
import 'package:islamic_app/models/sorah_model.dart';

import 'widgets/ayat_image_page_view.dart';
import 'widgets/ayat_text_page_view.dart';

int globalPage = 0;

class AyatView extends StatefulWidget {
  const AyatView({super.key, required this.sorah});
  static const String id = "Ayat-View";
  final SorahModel sorah;

  @override
  State<AyatView> createState() => _AyatViewState();
}

class _AyatViewState extends State<AyatView> {
  bool isImageView = true;
  @override
  void initState() {
    globalPage = widget.sorah.pageNum - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController =
        PageController(initialPage: globalPage, keepPage: true);

    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    isImageView = !isImageView;
                  });
                },
                icon: Icon(Icons.change_circle_outlined))
          ],
        ),
        body: isImageView
            ? AyatImagePageView(
                sorahModel: widget.sorah,
                pageController: pageController,
              )
            : AyatTextPageView(
                sorah: widget.sorah,
                pageController: pageController,
              ));
  }
}
