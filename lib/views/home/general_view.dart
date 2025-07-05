import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:islamic_app/controllers/general_controller.dart';
import 'package:islamic_app/views/home/widgets/nav_item.dart';
import '../../constants/constant.dart';

class GeneralView extends StatelessWidget {
  const GeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    GeneralController controller = Get.find();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.transparent,
        body: PageView.builder(
          itemCount: controller.homeNavViews.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return controller.homeNavViews[controller.navItemSelected.value];
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              const BoxShadow(
                color: Color(0xff043336),
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: const Color(0xff000000),
                offset: const Offset(0, 4),
                blurRadius: 4.r,
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => NavItem(
                  icon: Constant.homeNavItemsIconsTitles[index],
                  title: Constant.homeNavItemsTitles[index],
                  isSelected: controller.navItemSelected.value == index,
                  onTap: () {
                    controller.navItemSelected.value = index;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
