import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/app/app.locator.dart';
import 'package:task_manager/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
