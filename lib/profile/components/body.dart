import 'package:afogata/bloc/auth/authentication_bloc.dart';
import 'package:afogata/bloc/auth/authentication_event.dart';
import 'package:afogata/domain/models/user_model.dart';
import 'package:afogata/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  final UserModel user;

  const Body({Key? key, required this.user}) : super(key: key);
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late UserModel user;
  @override
  Widget build(BuildContext context) {
    user = widget.user;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: DeliveryColors.green),
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                user.name != null ? user.name : '',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //   SizedBox(
              //     height: 10,
              //   ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Card(
                  // color: Theme.of(context)
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Personal Information',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(user.email != null ? user.email : ''),
                        Text(
                          user.city != null ? user.city : '',
                        ),
                        Text(
                          user.address != null ? user.address : '',
                        ),
                        // SwitchListTile(value: true, onChanged: (val) {}),
                      ],
                    ),
                  ),
                ),
              ),
              // Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(LoggedOut());
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Log Out',
                      style: TextStyle(color: DeliveryColors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
