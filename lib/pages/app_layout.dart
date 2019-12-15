import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/navigation_bloc.dart';
import 'package:catmanager/blocs/states/navigation_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/events/navigation_events.dart';
import 'package:catmanager/modals/create_meal_modal.dart';
import 'package:catmanager/modals/meal_actions_modal.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/pages/create_custom_dish_page.dart';
import 'package:catmanager/pages/days_page.dart';
import 'package:catmanager/pages/home_page.dart';
import 'package:catmanager/pages/meals_page.dart';
import 'package:catmanager/widgets/create_meal_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';

class AppLayout extends StatefulWidget {
  AppLayout({Key key}) : super(key: key);
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {

  int _selectedPage = 0;

  final _pageOptions = [
    HomePage(),
    MealsPage(),
    DaysPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[

            DrawerHeader(
              child: Center(child: Text('Drawer Header')),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Create custom dish'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateDishPage(
                        customDish: CustomDish(),
                      );
                    }
                ));
              },
            ),
          ],
        ),
      ),

      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: BlocBuilder<MealsListingBloc, MealsListingState>(
            builder: (BuildContext context, state) {
              if (state is MealsListingFetched) {
                double totalCalories = 0;
                state.meals.forEach((meal) => totalCalories += meal.calories);
                return Text('${totalCalories.toString()}kCal');
              }

              return SizedBox(
                height: 15.0,
                width: 15.0,
                child: CircularProgressIndicator( strokeWidth: 2.0, backgroundColor: Colors.white, ),
              );
            }
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()  => CreateMealModal.showModal(context),
        tooltip: 'Add meal',
        child: Icon(Icons.add),
      ),
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Info'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            title: Text('Meals'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Days'),
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedPage = index;
          });
        },
        currentIndex: _selectedPage,
        selectedItemColor: Colors.amber[800],
      ),
    );
  }
}
