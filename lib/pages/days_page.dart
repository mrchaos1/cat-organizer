import 'package:catmanager/blocs/days_listring_bloc.dart';
import 'package:catmanager/blocs/states/days_listing_states.dart';
import 'package:catmanager/events/days_listing_event.dart';
import 'package:catmanager/modals/day_actions_modal.dart';
import 'package:catmanager/models/day_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaysPage extends StatefulWidget {
  DaysPage({Key key}) : super(key: key);
  @override
  _DaysPageState createState() => _DaysPageState();
}

class _DaysPageState extends State<DaysPage> {
  @override
  Widget build(BuildContext context) {



    BlocProvider.of<DaysListingBloc>(context).add(DaysFetchEvent());

    return Scaffold(
      body: Container(
        child: BlocBuilder<DaysListingBloc, DaysListingState>(
          builder: (BuildContext context, state) {
            if (state is DaysListingLoading) {

              return Center(child: CircularProgressIndicator( strokeWidth: 2.0));

            } else if (state is DaysListingFetched) {

              final List<Day> items = state.days.reversed.toList();

              return ListView(
                children: items.map((Day day) => Card(child: ListTile(
                    title: Text(day.calories.toString()),
                    subtitle: Text(day.startDatetime.toIso8601String()),
                    onTap: () => DayActionsModal.showModal(context, day)
                ))).toList(),
              );
            }
            return Center(child: Text('Unknown state'));
          }
        )
      ),
    );
  }
}
