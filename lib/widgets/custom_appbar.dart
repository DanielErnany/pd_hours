import 'package:flutter/material.dart';
import 'package:pd_hours/utils/theme/app_colors.dart';
import 'package:pd_hours/widgets/add_launch_modal.dart';

import '../utils/app_images.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(160.0);
  void _showAddLaunchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddLaunchModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final screenSize = MediaQuery.of(context).size;
    return PreferredSize(
      preferredSize: Size.fromHeight(screenSize.height * 0.2),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.08,
          vertical: screenSize.height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
            ),
          ],
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: screenSize.height * 0.01,
                  children: [
                    Image.asset(
                      AppImages.pds_logo,
                    ),
                    Text(
                      "Interface para lançamento de horas",
                      style: textTheme.bodyText2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(
                  height: screenSize.height * 0.01,
                ),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: screenSize.height * 0.01,
                  children: [
                    Text(
                      "PD Hours",
                      style: textTheme.headline6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ElevatedButton(
                      onPressed: () => _showAddLaunchDialog(context),
                      child: const Text(
                        "Lançar horas",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const TabBar(
                  labelColor: AppColors.black,
                  unselectedLabelColor: AppColors.gray3,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 5, color: AppColors.primaryColor),
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "Squad",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Tab(
                        child: Text(
                      "Usuários",
                      overflow: TextOverflow.ellipsis,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
