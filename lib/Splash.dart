import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Bloc/Internet%20Event.dart';
import 'package:note_app/Bloc/Internet_Bloc.dart';
import 'package:note_app/Bloc/Internet_State.dart';
import 'package:note_app/database/Show_Data.dart';
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Show_DB()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<InternetBLoc,InternetState>(
          builder:(context,state){
            if(state is InternetLostState){
              return Text('Connection Lost');
            }
            else if(state is InternetGainedState){
              return Text('Connection Establish');
            }
            else{
              return Text('Loding');
            }
          } ,
        ),
      ),
    );
  }
}
