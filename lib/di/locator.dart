import 'package:get_it/get_it.dart';
import '../data/hive/hive.dart';
import '../data/net/audio_service.dart';
import '../data/net/block_service.dart';
import '../data/net/dialog_service.dart';
import '../data/net/faq_service.dart';
import '../data/net/welcome_service.dart';
import '../data/net/auth_service.dart';
import '../data/net/lesson_service.dart';

GetIt locator = GetIt.instance;

void locatorSetup() {
  locator.registerSingleton(HiveDB());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => WelcomeService());
  locator.registerLazySingleton(() => LessonService());
  locator.registerLazySingleton(() => BlockService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AudioService());
  locator.registerLazySingleton(() => FAQService());
}
