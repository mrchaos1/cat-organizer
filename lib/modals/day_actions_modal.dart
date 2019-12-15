import 'package:catmanager/blocs/days_listring_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/models/day_model.dart';
import 'package:catmanager/widgets/day_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayActionsModal {
  static Future showModal(BuildContext context, Day day) {
    final provider =  BlocProvider.of<DaysListingBloc>(context);
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return BlocProvider.value(
              value: provider,
              child: DayActionsWidget(day: day)
          );
        }
    );
  }
}