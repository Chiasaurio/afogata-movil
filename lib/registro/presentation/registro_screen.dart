import 'package:afogata/bloc/auth/bloc.dart';
import 'package:afogata/registro/bloc/register_cubit.dart';
import 'package:afogata/registro/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class RegistroScreen extends StatefulWidget {
  @override
  _RegistroScreenState createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  late String group;

  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;

  late String telefono;
  late String ciudad;
  late String calle;
  late String zipcode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSubmissionInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Signing in'), CircularProgressIndicator()],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Error'), CircularProgressIndicator()],
              ),
              backgroundColor: Colors.red,
            ));
        }
        if (state.status.isSubmissionSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pushReplacementNamed('home');
        }
      },
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            _crearFondo(context),
            _loginForm(context),
          ],
        );
      },
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 20.0,
            ),
          ),
          Container(
            // width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(5.0),
            //     boxShadow: <BoxShadow>[
            //       BoxShadow(
            //           color: Colors.black26,
            //           blurRadius: 3.0,
            //           offset: Offset(0.0, 5.0),
            //           spreadRadius: 3.0)
            //     ]),
            child: Column(
              children: <Widget>[
                Text('Crear cuenta', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 30.0),
                // _crearRol(bloc),
                // SizedBox(height: 30.0),
                _crearNombre(),
                SizedBox(height: 30.0),
                _crearEmail(),
                SizedBox(height: 30.0),
                _crearPassword(),
                SizedBox(height: 30.0),
                _crearPhone(),
                SizedBox(height: 30.0),
                _crearCity(),
                SizedBox(height: 30.0),
                _crearStreet(),
                SizedBox(height: 30.0),
                _crearZipCode(),
                SizedBox(height: 30.0),
                _crearBoton()
              ],
            ),
          ),
          TextButton(
            child: Text('¿Ya tienes cuenta? Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  // Widget _crearRol() {
  //   return StreamBuilder(
  //     stream: bloc.rolStream,
  //     builder: (BuildContext context, AsyncSnapshot snapshot) {
  //       return Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10.0),
  //         child: Row(
  //           children: [
  //             Radio(
  //               value: 'cliente',
  //               groupValue: bloc.rol,
  //               onChanged: (value) {},
  //               // onChanged: bloc.changeRol,
  //             ),
  //             Text('Cliente', style: TextStyle(fontSize: 18.0)),
  //             Radio(
  //               value: 'tienda',
  //               groupValue: bloc.rol,
  //               onChanged: (value) {},
  //               // onChanged: bloc.changeRol,
  //             ),
  //             Text('Tienda', style: TextStyle(fontSize: 18.0)),
  //           ],
  //         ),
  //         //TextField(
  //         //   keyboardType: TextInputType.text,
  //         //   decoration: InputDecoration(
  //         //       // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
  //         //       hintText: 'nombre',
  //         //       labelText: 'Nombre empresa',
  //         //       // counterText: snapshot.data,
  //         //       errorText: snapshot.error),
  //         //   onChanged: bloc.changeName,
  //         // ),
  //       );
  //     },
  //   );
  // }

  Widget _crearNombre() {
    return BlocBuilder<RegisterCubit, RegisterState>(builder: (context, state) {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: nameController,
            decoration: InputDecoration(
              // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'nombre',
              labelText: 'Nombre',
              errorText: state.name.invalid ? 'Nombre muy corto' : null,
            ),
            onChanged: (value) {
              BlocProvider.of<RegisterCubit>(context)
                  .nameChanged(nameController.text.trim());
            },
          ));
    });
  }

  Widget _crearEmail() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            autocorrect: true,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              errorText: state.email.invalid ? 'Correo no es valido' : null,
            ),
            onChanged: (value) {
              BlocProvider.of<RegisterCubit>(context)
                  .emailChanged(emailController.text.trim());
            },
          ),
        );
      },
    );
  }

  Widget _crearPassword() {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(
              // icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
              labelText: 'Contraseña',
              errorText: state.password.invalid ? 'Contaseña muy corta' : null,
            ),
            onChanged: (value) {
              print('hola');
              BlocProvider.of<RegisterCubit>(context)
                  .passwordChanged(passwordController.text.trim());
            },
          ),
        );
      },
    );
  }

  Widget _crearCity() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'City',
          labelText: 'Ciudad',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        onChanged: (value) {
          ciudad = value;
        },
      ),
    );
  }

  Widget _crearStreet() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'Street',
          labelText: 'Street',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        onChanged: (value) {
          calle = value;
        },
      ),
    );
  }

  Widget _crearZipCode() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'Zip Code',
          labelText: 'Zip Code',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        onChanged: (value) {
          zipcode = value;
        },
      ),
    );
  }

  Widget _crearPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          // icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
          hintText: 'Telefono',
          labelText: 'telefono',
          // counterText: snapshot.data,
          // errorText: snapshot.error
        ),
        onChanged: (value) {
          telefono = value;
        },
      ),
    );
  }

  Widget _crearBoton() {
    // formValidStream
    // snapshot.hasData
    //  true ? algo si true : algo si false

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return ElevatedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Crear Cuenta'),
          ),
          onPressed: state.status == FormzStatus.valid
              ? () {
                  BlocProvider.of<RegisterCubit>(context)
                      .signUpFormSubmitted(ciudad, calle, zipcode, telefono);
                }
              : null,
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fondoModaro = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          //     gradient: LinearGradient(colors: <Color>[
          //   Color.fromRGBO(63, 63, 156, 1.0),
          //   Color.fromRGBO(90, 70, 178, 1.0)
          // ])
          ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: <Widget>[
        fondoModaro,
        // Positioned(top: 90.0, left: 30.0, child: circulo),
        // Positioned(top: -40.0, right: -30.0, child: circulo),
        // Positioned(bottom: -50.0, right: -10.0, child: circulo),
        // Positioned(bottom: 120.0, right: 20.0, child: circulo),
        // Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('Afogata',
                  style: TextStyle(color: Colors.white, fontSize: 25.0))
            ],
          ),
        )
      ],
    );
  }
}
