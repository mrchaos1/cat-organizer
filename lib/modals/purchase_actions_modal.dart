import 'package:catmanager/blocs/purchase_listing_bloc.dart';
import 'package:catmanager/models/purchase_model.dart';
import 'package:catmanager/widgets/purchase_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseActionsModal {
  static Future showModal(BuildContext context, Purchase purchase) {
    final provider =  BlocProvider.of<PurchaseListingBloc>(context);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: provider,
          child: PurchaseActionsWidget(purchase: purchase)
        );
      }
    );
  }
}