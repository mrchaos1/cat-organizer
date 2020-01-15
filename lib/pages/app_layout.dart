import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/modals/create_meal_modal.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/models/purchase_model.dart';
import 'package:catmanager/pages/create_custom_dish_page.dart';
import 'package:catmanager/pages/create_product_page.dart';
import 'package:catmanager/pages/days_page.dart';
import 'package:catmanager/pages/edit_meal_page.dart';
import 'package:catmanager/pages/edit_purchase_page.dart';
import 'package:catmanager/pages/home_page.dart';
import 'package:catmanager/pages/map_page.dart';
import 'package:catmanager/pages/meals_page.dart';
import 'package:catmanager/pages/products_page.dart';
import 'package:catmanager/pages/purchases_page.dart';
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
    PurchasesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
//          padding: EdgeInsets.zero,
          children: <Widget>[
//            DrawerHeader(
//              child: Center(child: Text('Drawer Header')),
//              decoration: BoxDecoration(
//                color: Colors.blue,
//              ),
//            ),

            ListTile(
              title: Text('+ Create custom dish'),
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

            ListTile(
              title: Text('+ Create product'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CreateProductPage(
                        product: Product(),
                      );
                    }
                ));
              },
            ),

            ListTile(
              title: Text('+ Create meal'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return EditMealPage(
                        meal: Meal(),
                      );
                    }
                ));
              },
            ),

            ListTile(
              title: Text('+ Create purchase'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return EditPurchasePage(
                        purchase: Purchase(),
                      );
                    }
                ));
              },
            ),
            ListTile(
              title: Text('Products'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProductsPage(
                      );
                    }
                ));
              },
            ),
            ListTile(
              title: Text('Map'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MapPage();
                    }
                ));
              },
            ),

          ],
        ),
      ),

      appBar: AppBar(
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              color: Colors.black54,
              icon: const Icon(Icons.menu),
              onPressed: () { Scaffold.of(context).openDrawer(); },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: BlocBuilder<MealsListingBloc, MealsListingState>(
            builder: (BuildContext context, state) {
              if (state is MealsListingFetched) {
                return RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                    text: '${state.getTotalCaloriesEaten().toStringAsFixed(2)} kCal',
                    children: [
                      TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        text: ' / ${state.getTotalCalories().toStringAsFixed(2)} kCal',
                      )
                    ]),
                );
                return Text('${state.getTotalCaloriesEaten().toStringAsFixed(2)} kCal / ${state.getTotalCalories().toStringAsFixed(2)} kCal', style: TextStyle(color: Colors.black54, fontSize: 15.0));
              }
              return SizedBox(
                height: 15.0,
                width: 15.0,
                child: CircularProgressIndicator( strokeWidth: 2.0, backgroundColor: Colors.white, ),
              );
            }
        )
      ),

      body: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          _pageOptions[_selectedPage],
          Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  child: FloatingActionButton(
                      backgroundColor: Colors.yellow,
                      child: Icon(Icons.credit_card, color: Colors.black54,),
                      heroTag: 2,
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) {
                          return EditPurchasePage(
                            purchase: Purchase(),
                          );
                        }
                      ),
                    ),
                  ),
                ),

                Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    child: BlocBuilder<MealsListingBloc, MealsListingState>(
                    builder: (BuildContext context, state) {
                      if (state is MealsListingFetched) {

                        int sortOrder = 0;

                        if (state.meals.length > 0 && state.meals.first.sortOrder != null) {
                          sortOrder = state.meals.first.sortOrder - 1;
                        }

                        return InkWell(
                          onLongPress: () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EditMealPage(
                                  meal: Meal(),
                                );
                              }
                          )),
                          child: FloatingActionButton(
                            child: Icon(Icons.add),
                            heroTag: 1,
                            onPressed: () => CreateMealModal.showModal(context, sortOrder),
                        ));
                      }

                      return FloatingActionButton(
                        child: Icon(Icons.add),
                        backgroundColor: Colors.lightBlueAccent,
                        onPressed: () {},
                      );
                    },
                  )
                ),

              ],
            ),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        unselectedFontSize: 14.0,
        iconSize: 25,
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
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            title: Text('Purchases'),
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
