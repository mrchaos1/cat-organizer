import 'package:bloc/bloc.dart';
import 'package:catmanager/blocs/states/navigation_states.dart';
import 'package:catmanager/events/navigation_events.dart';
import 'package:flutter/material.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {

  @override
  NavigationState get initialState => HomePageNavigationState();

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    switch (event) {
      case NavigationEvent.toHomePage:
        yield HomePageNavigationState();
        break;
      case NavigationEvent.toCreateCustomDishPage:
        yield CreateCustomDishPageNavigationState();
        break;
    }
  }
}