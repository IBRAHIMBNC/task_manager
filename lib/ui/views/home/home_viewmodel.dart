import 'package:flutter/material.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:task_manager/app/app.snackbars.dart';
import 'package:task_manager/app/models/app_user.dart';
import 'package:task_manager/app/models/task.dart';
import 'package:task_manager/services/app_state_service.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/ui/common/ui_helpers.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();
  final _appStateService = locator<AppStateService>();
  final _snackbarService = locator<SnackbarService>();
  final _authService = locator<AuthService>();
  final TextEditingController taskController = TextEditingController();

  int currentTabIndex = 0;

  set setCurrentTabIndex(int index) {
    currentTabIndex = index;
    notifyListeners();
  }

  HomeViewModel() {
    taskController.addListener(() {
      notifyListeners();
    });
  }

  bool get canAddTask => taskController.text.trim().isNotEmpty;

  List<Todo> get allTasks => _appStateService.allTasks;
  List<Todo> get myTasks => _appStateService.myTasks;

  AppUser get user => _authService.appUser!;

  goToProfileScreen() {
    _navigationService.navigateToUserProfileView();
  }

  getMoreTasks(int lastItemId) {
    _appStateService.fetchMoreTasks(lastItemId);
  }

  toggleTaskStatus(Todo task, bool status) {
    task = task.copyWith(isCompleted: status);
    _appStateService.updateTask(task);
  }

  addTask() async {
    final task = taskController.text.trim();
    taskController.clear();

    final Todo todoTask = Todo(
      id: DateTime.now().millisecondsSinceEpoch,
      todo: task,
      userId: user.id,
    );
    _appStateService.addTask(todoTask);

    _snackbarService.showCustomSnackBar(
      variant: SnackbarType.success,
      message: 'Task added successfully',
      duration: const Duration(seconds: 1),
    );
  }

  removeTask(int id) async {
    loading(true);
    final result = await _appStateService.removeTask(id);
    loading(false);
    if (result) {
      _snackbarService.showCustomSnackBar(
        variant: SnackbarType.success,
        message: 'Task removed successfully',
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_appStateService];

  void incrementCounter() {}
}
