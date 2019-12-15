import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/widgets/create_meal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateMealModal {
  static Future showModal(BuildContext context) {
    final provider =  BlocProvider.of<MealsListingBloc>(context);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
              value: provider,
              child: CreateMealWidget()
          );
        }
    );
  }
}