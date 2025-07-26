import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/dependency_injection.dart';
import 'core/theme/cubit/theme/theme_cubit.dart';
import 'core/theme/dark_mode.dart';
import 'core/theme/light_mode.dart';
import 'core/widgets/loading_indicator.dart';
import 'features/auth/logic/auth/auth_cubit.dart';
import 'features/auth/logic/auth/auth_state.dart';
import 'features/auth/ui/login_or_register.dart';
import 'features/home/logic/notifications/notification_cubit.dart';
import 'features/home/logic/cart/cart_cubit.dart';
import 'features/splash/ui/splash_screen.dart';
import 'features/home/ui/home_screen.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key, required this.nextScreen});
  final Widget nextScreen;

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = getIt<ThemeCubit>().state;
    getIt<ThemeCubit>().stream.listen((themeMode) {
      if (mounted) {
        setState(() {
          _themeMode = themeMode;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      darkTheme: darkMode,
      themeMode: _themeMode,
      home: SplashScreen(nexScreen: widget.nextScreen),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getIt<AuthCubit>().checkAuth();
    getIt<CartCubit>().loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<ThemeCubit>()),
        BlocProvider.value(value: getIt<AuthCubit>()),
        BlocProvider.value(value: getIt<NotificationCubit>()),
        BlocProvider.value(value: getIt<CartCubit>()),
      ],
      child: BlocConsumer<AuthCubit, AuthState>(
        buildWhen: (previous, current) {
          return current is Authenticated ||
              current is Unauthenticated ||
              current is AuthLoading ||
              current is AuthError;
        },
        listenWhen: (previous, current) {
          return current is Authenticated ||
              current is Unauthenticated ||
              current is AuthLoading ||
              current is AuthError;
        },
        listener: (context, state) {
          if (state is AuthLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loading...')),
              );
            });
          } else if (state is AuthError) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: state.maybeWhen(
              unauthenticated: () => const LoginOrRegister(),
              authenticated: (user) => const HomeScreen(),
              loading: () => const LoadingIndicator(),
              error: (e) => Center(child: Text(e)),
              orElse: () => const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}
