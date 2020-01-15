import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/purchase_listing_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/events/purchase_listing_event.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/models/purchase_model.dart';
import 'package:catmanager/pages/edit_purchase_page.dart';
import 'package:catmanager/widgets/bottom_sheet_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PurchaseActionsWidget extends StatefulWidget {
  PurchaseActionsWidget({ @required this.purchase });
  final Purchase purchase;
  _PurchaseActionsWidgetState createState() => _PurchaseActionsWidgetState();
}

class _PurchaseActionsWidgetState extends State<PurchaseActionsWidget> {

  double _productCalories = 0;
  double _quantity = 0;
  String _formattedDateTime;

  @override
  void initState() {
    _quantity = widget.purchase.quantity > 0 ? widget.purchase.quantity : 1;

    if (widget.purchase.jsonData['product_calorie_content'] != null && widget.purchase.jsonData['product_calorie_content'] > 0 && widget.purchase.jsonData['product_net_weight'] > 0) {
      _productCalories = (widget.purchase.jsonData['product_net_weight'] / 100 * widget.purchase.jsonData['product_calorie_content']) * _quantity;
    }
    _formattedDateTime = DateFormat('HH:mm yyyy, MMM dd').format(widget.purchase.datetime);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetContainer(
      child: Wrap(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0)
                )
            ),
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('₽ ${widget.purchase.price.toString()} x ${widget.purchase.quantity.toString()} (${_formattedDateTime})'),
                ],
              ),
            ),
          ),

          ListTile(
            title: Text('Edit'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditPurchasePage(
                    purchase: widget.purchase,
                  );
                }
              ));
            },
          ),


          BlocBuilder<MealsListingBloc, MealsListingState>(
            builder: (BuildContext context, state) {
              if (state is MealsListingFetched) {
                return ListTile(
                  enabled: (_productCalories > 0) ? true : false,
                  title: Text("Create meal ${_productCalories.toString()} kCal"),
                  trailing: Icon(Icons.restaurant),
                  onTap: () {
                    BlocProvider.of<MealsListingBloc>(context).add(MealCreatingEvent(Meal(
                      calories: _productCalories,
                      description: "${widget.purchase.jsonData['product_title']} x ${widget.purchase.quantity.toString()}",
                      datetime: DateTime.now()), state.meals,
                          () {
                        widget.purchase.isEaten = true;
                        BlocProvider.of<PurchaseListingBloc>(context).add(PurchaseCreatingEvent(widget.purchase));
                        Navigator.of(context).pop();
                      })
                    );

                  },
                );

              }

              return ListTile(title: Text('Loading...'));

            }),



          ListTile(
            title: Text('Remove', style: TextStyle(color: Colors.red),),
            trailing: Icon(Icons.close, color: Colors.redAccent),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete purchase?', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          BlocProvider.of<PurchaseListingBloc>(context).add(PurchaseDeletingEvent(widget.purchase));
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                }
              );
            },
          ),
        ],
      )
    );
  }
}

