import 'package:flutter/material.dart';
import 'package:flutter_resume_app/data/util/colors.dart';
import 'package:flutter_resume_app/data/widget/widget.dart';
import 'package:flutter_resume_app/home_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'state_screen/lessons/lesson_screen.dart';
import 'state_screen/learns/learn_screen.dart';
import 'state_screen/saveds/saved_screen.dart';
import 'state_screen/settings/settings_screen.dart';
import 'main_provider.dart';

class MainScreen extends StatefulWidget {
  static Widget screen() => HomeScreen(
        child: ChangeNotifierProvider(
          create: (_) => MainProvider(),
          child: MainScreen(),
        ),
      );

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.greyLight,
      body: Consumer<MainProvider>(
        builder: (context, value, child) {
          if (value.bottomMenuIndex == value.BOTTOM_MENU_LESSON)
            return LessonScreen.screen();
          if (value.bottomMenuIndex == value.BOTTOM_MENU_LEARN)
            return LearnScreen.screen();
          if (value.bottomMenuIndex == value.BOTTOM_MENU_SAVED)
            return SavedScreen.screen();
          if (value.bottomMenuIndex == value.BOTTOM_MENU_SETTINGS)
            return SettingsScreen.screen();
          return WLoading();
        },
      ),
      bottomNavigationBar:
          Consumer<MainProvider>(builder: (context, value, child) {
        return BottomNavigationBar(
          backgroundColor: MyColors.greyLight,
          currentIndex: value.bottomMenuIndex,
          onTap: (id) => value.onChangedBottomMenu(id),
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon_lesson.svg",
                width: 25,
                height: 25,
                color: value.bottomMenuIndex == 0
                    ? MyColors.orangeAccent
                    : MyColors.greyDark,
              ),
              label: "lesson",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon_learn.svg",
                width: 25,
                height: 25,
                color: value.bottomMenuIndex == 1
                    ? MyColors.orangeAccent
                    : MyColors.greyDark,
              ),
              label: "list",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon_folder.svg",
                width: 25,
                height: 25,
                color: value.bottomMenuIndex == 2
                    ? MyColors.orangeAccent
                    : MyColors.greyDark,
              ),
              label: "folder",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icon_settings.svg",
                width: 25,
                height: 25,
                color: value.bottomMenuIndex == 3
                    ? MyColors.orangeAccent
                    : MyColors.greyDark,
              ),
              label: "settings",
            ),
          ],
        );
        return SizedBox();
      }),
    );
  }
}
