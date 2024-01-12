import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:islamic_app/constant.dart';
import 'package:islamic_app/helper.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({super.key});
  static const String id = "about-us-view";
  final String whatsappUrl = "whatsapp://send?phone=\+9647822392275";
  final String telegramUrl = "tg://resolve?domain=a_iqi202";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'عنا',
          style: TextStyle(
            fontFamily: kFontKufamRegular,
            fontSize: 16.sp,
            color: kThirdlyColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'أنا المطور لهذا التطبيق',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: kFontKufamRegular,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'أنا متحمس لتقديم تجربة رائعة لقراءة القرآن الكريم.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: kFontKufamRegular,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'أن واجهت مشكلة ما أو كان لديك اقتراح ما,يمكنك التواصل معي.',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: kFontKufamRegular,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(FontAwesomeIcons.telegram),
                    tooltip: "تواصل معي عبر التلكرام",
                    onPressed: () async {
                      const String telegramUsername = 'a_iqi202';
                      await openUrl(
                        url: 'tg://resolve?domain=$telegramUsername',
                        // url: 'https://t.me/ayhamapp2',
                        errorMessage: 'يرجى تثبيت Telegram أولاً',
                        context: context,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
