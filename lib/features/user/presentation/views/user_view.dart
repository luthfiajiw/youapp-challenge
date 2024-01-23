import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_challenge/config/routes/route_pahts.dart';
import 'package:youapp_challenge/core/widgets/custom_appbar.dart';
import 'package:youapp_challenge/core/widgets/gradient_icon.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_cubit.dart';
import 'package:youapp_challenge/features/auth/presentation/cubit/splash_state.dart';
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
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Dialog(
            shape: CircleBorder(),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            child: Center(
              child: SizedBox(
                height: 35,
                width: 35,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
      return context.read<UserCubit>().onGetUser();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: customAppbar(
          title: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state.getUserStatus == GetUserStatus.done) {
                // dismiss dialog
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Visibility(
                visible: state.getUserStatus == GetUserStatus.done,
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
          actions: [
            BlocListener<SplashCubit, SplashState>(
              listener: (context, state) {
                if (state is AccessTokenEmpty) {
                  Navigator.pushNamedAndRemoveUntil(context, RoutePaths.login, (route) => false);
                }
              },
              child: IconButton(
                onPressed: () => context.read<SplashCubit>().clearAccessToken(),
                icon: const GradientIcon(
                  icon: Icon(
                    Icons.logout_rounded,
                  ),
                )
              ),
            )
          ]
        ),
        body: ListView(
          children: const [
            Padding(
              padding: EdgeInsets.all(8),
              child: UserHeader(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: UserAbout()
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: UserInterest(),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}