import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/widgets/custom_dish_actions_widget.dart';
import 'package:catmanager/widgets/custom_dish_gobble_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDishGobbleUpModal {

  static Future showModal(BuildContext context, CustomDish dish) {
    final provider =  BlocProvider.of<MealsListingBloc>(context);
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: provider,
            child: CustomDishGobbleUpWidget(dish)
          );
        }
    );
  }
}