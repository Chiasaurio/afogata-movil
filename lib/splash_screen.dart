import 'dart:async';

import 'package:afogata/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: deliveryGradients)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: DeliveryColors.white,
              radius: 45,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Afogata',
              textAlign: TextAlign.center,
              // style: Theme.of(context).textTheme.headline3.copyWith(
              //       fontWeight: FontWeight.bold,
              // ),
            )
          ],
        ),
      ),
    );
  }
}
