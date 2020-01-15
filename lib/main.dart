import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/days_listring_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/navigation_bloc.dart';
import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/blocs/purchase_listing_bloc.dart';
import 'package:catmanager/blocs/states/navigation_states.dart';
import 'package:catmanager/pages/app_layout.dart';
import 'package:catmanager/pages/create_custom_dish_page.dart';
import 'package:catmanager/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<MealsListingBloc>(
          create: (BuildContext context) => MealsListingBloc(),
        ),
        BlocProvider<DaysListingBloc>(
          create: (BuildContext context) => DaysListingBloc(),
        ),
        BlocProvider<CustomDishListingBloc>(
          create: (BuildContext context) => CustomDishListingBloc(),
        ),
        BlocProvider<ProductListingBloc>(
          create: (BuildContext context) => ProductListingBloc(),
        ),
        BlocProvider<PurchaseListingBloc>(
          create: (BuildContext context) => PurchaseListingBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Cat Manager',
        debugShowCheckedModeBanner: false,
        home: AppLayout(),
        theme: ThemeData(
          canvasColor: Colors.white,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
            textTheme: ButtonTextTheme.primary,
          ),
          accentColor: Colors.blue,
          fontFamily: 'Montserrat',
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ),
      ),
    );
  }
}
