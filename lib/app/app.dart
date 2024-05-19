import 'package:task_manager/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:task_manager/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:task_manager/ui/views/home/home_view.dart';
import 'package:task_manager/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/services/app_state_service.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/services/database_service.dart';
import 'package:task_manager/ui/views/sign_in/sign_in_view.dart';
import 'package:task_manager/services/local_storage_service.dart';
import 'package:task_manager/ui/views/user_profile/user_profile_view.dart';
import 'package:task_manager/ui/dialogs/loading_dialog/loading_dialog_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: SignInView),
    MaterialRoute(page: UserProfileView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppStateService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: DatabaseService),
    LazySingleton(classType: SnackbarService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: LoadingDialogDialog),
// @stacked-dialog
  ],
)
class App {}
