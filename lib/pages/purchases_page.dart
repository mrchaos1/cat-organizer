import 'package:catmanager/blocs/purchase_listing_bloc.dart';
import 'package:catmanager/blocs/states/purchase_listing_states.dart';
import 'package:catmanager/events/purchase_listing_event.dart';
import 'package:catmanager/modals/purchase_actions_modal.dart';
//import 'package:catmanager/modals/day_actions_modal.dart';
import 'package:catmanager/models/purchase_model.dart';
import 'package:catmanager/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchasesPage extends StatefulWidget {
  PurchasesPage({Key key}) : super(key: key);
  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  Widget build(BuildContext context) {

    BlocProvider.of<PurchaseListingBloc>(context).add(PurchaseListingFetchingEvent());

    return Scaffold(
      body: Container(
        child: BlocBuilder<PurchaseListingBloc, PurchaseListingState>(
          builder: (BuildContext context, state) {
            if (state is PurchaseListingLoadingState) {

              return Center(child: CircularProgressIndicator( strokeWidth: 2.0));

            } else if (state is PurchaseListingFetchedState) {

              final List<Purchase> items = state.purchases.reversed.toList();

              return ListView(
                children: items.map((Purchase purchase) => Container(
                    color: purchase.isEaten ? null : Theme.of(context).highlightColor,
                    child: ListTile(
                    title: Text('- ₽ ${purchase.price.toString()} ', style: TextStyle(fontWeight: FontWeight.w500)),
                    trailing: DateTimeWidget(dateTime: purchase.datetime,),
                    subtitle: Text("${purchase.jsonData['product_title']}, #${purchase.jsonData['product_code']}, ${purchase.jsonData['product_calorie_content']}kCal/100g, ${purchase.jsonData['product_net_weight']}g, x${purchase.quantity.toString()}"),
                    onTap: () => PurchaseActionsModal.showModal(context, purchase)
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
