import 'package:flutter/material.dart';
import 'package:islamic_app/generated/l10n.dart';
import 'package:islamic_app/views/widgets/custom_app_bar.dart';
import 'package:islamic_app/views/widgets/last_read_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String id = "home-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
