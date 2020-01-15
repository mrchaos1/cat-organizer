import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/widgets/product_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductActionsModal {
  static Future showModal(BuildContext context, Product product) {
    final provider =  BlocProvider.of<MealsListingBloc>(context);
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BlocProvider.value(
            value: provider,
            child: ProductActionsWidget(product: product)
        );
      }
    );
  }
}