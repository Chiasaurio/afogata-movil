import 'package:afogata/theme.dart';
import 'package:afogata/widgets/afogata_button.dart';
import 'package:afogata/widgets/grey_button.dart';
import 'package:flutter/material.dart';

class OpcionesRegistroScreen extends StatelessWidget {
  void googleSignIn() async {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: DeliveryColors.grey,
      body: SingleChildScrollView(
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: deliveryGradients,
        // )),
        child: Container(
          width: size.width,
          // height: size.height,
          margin: EdgeInsets.symmetric(vertical: 100.0, horizontal: 30.0),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: DeliveryColors.white,
                radius: 80,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Registrate',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              _googleBoton(),
              _otraformaBoton(context),
              SizedBox(
                height: 70,
              ),
              Divider(
                color: DeliveryColors.blue,
              ),
              FlatButton(
                child: Text('¿Ya tienes una cuenta?'),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleBoton() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: AfogataButton(
              text: 'con GOOGLE',
              onTap: googleSignIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _otraformaBoton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: GreyButton(
              text: 'Registrar de otra forma',
              onTap: () => Navigator.pushReplacementNamed(context, 'registro'),
            ),
          ),
        ],
      ),
    );
  }
}
