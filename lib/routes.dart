import 'package:afogata/chat/chat_detail/chat_detail_screen.dart';
import 'package:afogata/chat/chat_list_screen.dart/chatuser_screen.dart';
import 'package:afogata/home_screen.dart';
import 'package:afogata/profile/profile_screen.dart';
import 'package:afogata/registro/presentation/opcionesregistro_screen.dart';
import 'package:afogata/registro/presentation/registro_screen.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:afogata/sign_in/ui/login_screen.dart';
import 'package:afogata/splash_screen.dart';
import 'package:flutter/material.dart';

final LocalRepositoryImpl localRepositoryImpl = LocalRepositoryImpl();
final ApiRepositoryImpl apiRepositoryImpl = ApiRepositoryImpl();

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    'home': (BuildContext context) => HomeScreen(),
    'login': (BuildContext context) => LoginScreen(
          apiRepositoryImpl: apiRepositoryImpl,
          localRepositoryImpl: localRepositoryImpl,
        ),
    // 'registro': (BuildContext context) => RegistroPage(),
    // 'editar': (BuildContext context) => EditProfileFieldPage(),
    'profile': (BuildContext context) => ProfileScreen(),
    'splash': (BuildContext context) => SplashScreen(),
    'registro': (BuildContext context) => RegistroScreen(),
    'opcionesregistro': (BuildContext context) => OpcionesRegistroScreen(),
    'chat_list_screen': (BuildContext context) => ChatUserScreen(),
    'chat_details_screen': (BuildContext context) => ChatDetailScreen(),
  };
}
