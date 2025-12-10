import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Presentation/pages/login_page.dart';
import 'Data/repos/meal_repo_impl.dart';
import 'Domain/repositry/meal_repo.dart';
import '../../firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(
      overrides: [
        mealRepoProvider.overrideWith((ref) => ref.watch(mealRepoImplProvider)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.orange,
      ),
      home: const LoginPage(),
    );
  }
}


//  inside widget : Selector<classModel,String>(
// selector :(context ,classModel)=>classModel.var,
// builder : (context ,String var, child){
// 
// 
// 
// 
// 
// 
// 
// 
// 
// 