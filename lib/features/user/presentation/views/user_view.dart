import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/screen_loading.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_cubit.dart';
import 'package:youapp_challenge/features/user/presentation/cubit/user_state.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_about.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_header.dart';
import 'package:youapp_challenge/features/user/presentation/widgets/user_interest.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    Future.microtask(() {
      showScreenLoading(context);
      return context.read<UserCubit>().onGetUser();
    });
    super.initState();
  }

  void logout() {
    context.read<SplashCubit>().clearAccessToken();
    Navigator.pushNamedAndRemoveUntil(context, RoutePaths.login, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: customAppbar(
          onBack: () {
            logout();
          },
          title: BlocConsumer<UserCubit, UserState>(
            listenWhen: (previous, current) {
              return previous.getUserStatus != current.getUserStatus;
            },
            listener: (context, state) {
              if (state.getUserStatus == GetUserStatus.done) {
                // dismiss screen loading
                Navigator.pop(context);
              } else if (state.getUserStatus == GetUserStatus.error) {
                logout();
              }
            },
            builder: (context, state) {
              return Visibility(
                visible: state.username != null,
                child: Text(
                  "@${state.username!}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700
                  ),
                ),
              );
            },
          ),
        ),
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(12),
              child: UserHeader(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: UserAbout()
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: UserInterest(),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}