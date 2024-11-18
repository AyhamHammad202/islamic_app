import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/common/background_image.dart';
import 'package:islamic_app/constants/assets.dart';
import 'package:islamic_app/constants/constant.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/helper.dart';
import 'package:islamic_app/views/more_view/widgets/more_item.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(S.current.navmore),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 9,
                width: MediaQuery.of(context).size.width / 4,
                child: Image.asset(kAppIconAsset),
              ),
              Text(
                "نور المؤمن",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontFamily: kFontKufamRegular,
                  color: kThirdlyColor,
                ),
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerColor,
                indent: 60.w,
                endIndent: 60.w,
              ),
              ...List.generate(
                Constant.drawerItems.length,
                (index) => Constant.drawerItems[index],
              ),
              MoreItem(
                title: S.current.rate,
                leading: Image.asset(Assets.svgRatePng),
                onTap: () {
                  openUrl(
                    url: Constant.appUrl,
                    errorMessage: "There is an error",
                    context: context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
