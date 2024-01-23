import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_challenge/core/services/dio_interceptor.dart';
import 'package:youapp_challenge/core/services/dio_service.dart';
import 'package:youapp_challenge/core/services/shared_prefs_service.dart';
import 'package:youapp_challenge/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:youapp_challenge/features/auth/data/sources/remote_auth_source.dart';
import 'package:youapp_challenge/features/auth/domain/repositories/auth_repository.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_login_usecase.dart';
import 'package:youapp_challenge/features/auth/domain/usecases/post_register_usercase.dart';
import 'package:youapp_challenge/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/user/data/repositories/user_repository_impl.dart';
import 'package:youapp_challenge/features/user/data/source/remote_user_source.dart';
import 'package:youapp_challenge/features/user/domain/repositories/user_repository.dart';
import 'package:youapp_challenge/features/user/domain/usecases/get_user_usecase.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';

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
      ),
      interceptor: DioInterceptor()
    )
  );

  // SOURCES
  locator.registerSingleton<RemoteAuthSource>(
    RemoteAuthSource(dioService: locator.get<DioService>())
  );
  locator.registerSingleton<RemoteUserSource>(
    RemoteUserSource(dioService: locator.get<DioService>())
  );

  // REPOSITORIES
  locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(source: locator.get<RemoteAuthSource>())
  );
  locator.registerSingleton<UserRepository>(
    UserRepositoryImpl(source: locator.get<RemoteUserSource>())
  );

  // USECASES
  locator.registerSingleton<PostLogin>(
    PostLogin(authRepository: locator.get<AuthRepository>())
  );
  locator.registerSingleton<PostRegister>(
    PostRegister(authRepository: locator.get<AuthRepository>())
  );
  locator.registerSingleton<GetUser>(
    GetUser(userRepository: locator.get<UserRepository>())
  );

  // CUBITS
  locator.registerFactory(() {
    return SplashCubit(locator.get<SharedPrefsService>());
  });
  locator.registerFactory(() {
    return UserCubit(locator.get<GetUser>());
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