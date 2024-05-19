import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/app/app.bottomsheets.dart';
import 'package:task_manager/app/app.dialogs.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.snackbars.dart';
import 'package:task_manager/ui/common/app_colors.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupSnackbarUi();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(_designWidth, _designHeight),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.startupView,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            background: AppColors.pureWhite,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            titleSpacing: kPadding20.w,
            centerTitle: false,
          ),
          scaffoldBackgroundColor: AppColors.pureWhite,
        ),
        onGenerateRoute: StackedRouter().onGenerateRoute,
        navigatorKey: StackedService.navigatorKey,
        navigatorObservers: [
          StackedService.routeObserver,
        ],
      ),
    );
  }
}
