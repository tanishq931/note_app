
import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/Bloc/Internet%20Event.dart';
import 'package:note_app/Bloc/Internet_State.dart';

class InternetBLoc extends Bloc<InternetEvent,InternetState>{
  Connectivity connectivity = Connectivity();
  StreamSubscription? connectivitySubs;
  InternetBLoc() : super(InitialInternetState()){

    on<InternetGained>((event, emit) => emit(InternetGainedState()));
    on<InternetLost>((event, emit) => emit(InternetLostState()));
    connectivity.onConnectivityChanged.listen((event) {
    if(event == ConnectivityResult.mobile || event==ConnectivityResult.wifi){
      add(InternetGained());
    }
    else{
      add(InternetLost());
    }
    });
  }
  @override
  Future<void> close() {
    connectivitySubs?.cancel();
    return super.close();
  }

}