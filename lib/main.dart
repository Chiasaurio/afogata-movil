import 'package:afogata/chat/bloc/chat_bloc.dart';
import 'package:afogata/chat/chat_list_screen.dart/chatuser_screen.dart';
import 'package:afogata/chat/stream_socket.dart';
import 'package:afogata/home_screen.dart';
import 'package:afogata/registro/bloc/register_cubit.dart';
import 'package:afogata/resources/api_repository_implementation.dart';
import 'package:afogata/resources/local_repository_implementation.dart';
import 'package:afogata/sign_in/ui/login_screen.dart';
import 'package:afogata/splash_screen.dart';
import 'package:afogata/routes.dart';
import 'package:bloc/bloc.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'bloc/auth/authentication_bloc.dart';
import 'bloc/auth/authentication_event.dart';
import 'bloc/auth/authentication_state.dart';
import 'bloc/auth/simple_bloc_delegate.dart';

void connectAndListen() {
  IO.Socket socket = IO.io('http://localhost:3000',
      OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('connect');
    socket.emit('msg', 'test');
  });

  //When an event recieved from server, data is added to the stream
  socket.on('event', (data) => streamSocket.addResponse);
  socket.onDisconnect((_) => print('disconnect'));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = SimpleBlocObserver();
  final LocalRepositoryImpl localRepositoryImpl = LocalRepositoryImpl();
  final ApiRepositoryImpl apiRepositoryImpl = ApiRepositoryImpl();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthenticationBloc(
            apiRepositoryImpl: apiRepositoryImpl,
            localRepositoryImpl: localRepositoryImpl)
          ..add(AppStarted()),
      ),
      BlocProvider<ChatBloc>(
        create: (context) => ChatBloc(),
      ),
      BlocProvider<RegisterCubit>(
        create: (context) =>
            RegisterCubit(apiRepositoryImpl, localRepositoryImpl),
      ),
    ],
    child: MyApp(
        apiRepositoryImpl: apiRepositoryImpl,
        localRepositoryImpl: localRepositoryImpl),
  ));
}

class MyApp extends StatelessWidget {
  final LocalRepositoryImpl localRepositoryImpl;
  final ApiRepositoryImpl apiRepositoryImpl;

  const MyApp(
      {Key? key,
      required this.localRepositoryImpl,
      required this.apiRepositoryImpl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afogata-App',
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is Uninitialized) {
          return SplashScreen();
        }
        // if (state is Unauthenticated) {
        //   return ChatUserScreen();
        // }
        if (state is Authenticated) {
          return HomeScreen();
        }
        if (state is Unauthenticated) {
          return LoginScreen(
            apiRepositoryImpl: apiRepositoryImpl,
            localRepositoryImpl: localRepositoryImpl,
          );
        }
        return Container();
      }),
      // initialRoute: 'login',
      routes: getApplicationRoutes(),
    );
  }
}
