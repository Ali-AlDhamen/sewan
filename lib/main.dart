import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sewan/router/app_router.dart';
import 'package:sewan/theme/palette.dart';
import 'package:sewan/theme/theme_provider.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  // // =========== Functions ===========
  // void getData(WidgetRef ref, User data) async {
  //   UserModel? userModel = await ref
  //       .watch(authControllerProvider.notifier)
  //       .getUserData(data.uid)
  //       .first;
  //   ref.read(userProvider.notifier).update((state) => userModel);
  // }

  // ========== Widget ==========
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // =========== Variables ===========
    final router = ref.watch(goRouterProvider);
    final isDark = ref.watch(themeControllerProvider);

    // // Auth state
    // ref.watch(authStateChangeProvider).whenData(
    //   (data) {
    //     if (data != null) {
    //       getData(ref, data);
    //     }
    //   },
    // );

    // =========== Widget Design ===========
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'PMUSocialize',
          theme: Palette.lightModeThemeData,
          darkTheme: Palette.darkModeThemeData,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          routerConfig: router,
        );
      },
    );
  }
}
