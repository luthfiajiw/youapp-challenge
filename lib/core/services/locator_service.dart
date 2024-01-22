import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_register_usercase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';

final locator = GetIt.instance;

Future<void> setupDependencies() async {
  final prefeferences = await SharedPreferences.getInstance();

  // SERVICES
  locator.registerSingleton<SharedPrefsService>(
    SharedPrefsService(prefs: prefeferences)
  );
  locator.registerSingleton<DioService>(
    DioService(
      Dio(
        BaseOptions(baseUrl: 'https://techtest.youapp.ai/api')
      )
    )
  );

  // SOURCES
  locator.registerSingleton<RemoteAuthSource>(
    RemoteAuthSource(dioService: locator.get<DioService>())
  );

  // REPOSITORIES
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(source: locator.get<RemoteAuthSource>())
  );

  // USECASES
  locator.registerSingleton<PostLogin>(
    PostLogin(authRepository: locator.get<AuthRepository>())
  );
  locator.registerSingleton<PostRegister>(
    PostRegister(authRepository: locator.get<AuthRepository>())
  );

  // CUBITS
  locator.registerFactory(() {
    return SplashCubit(locator.get<SharedPrefsService>());
  });

  // BLOCS
  locator.registerFactory<AuthBloc>(() {
    return AuthBloc(
      locator.get<PostLogin>(),
      locator.get<PostRegister>(),
      locator.get<SharedPrefsService>(),
    );
  });

}