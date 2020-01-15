import 'package:catmanager/blocs/meals_listing_bloc.dart';
import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/blocs/states/product_listing_states.dart';
import 'package:catmanager/events/meal_listing_event.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/modals/create_meal_modal.dart';
import 'package:catmanager/modals/meal_actions_modal.dart';
import 'package:catmanager/modals/product_actions_modal.dart';
import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/pages/create_product_page.dart';
import 'package:catmanager/widgets/create_meal_widget.dart';
import 'package:catmanager/widgets/date_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catmanager/blocs/states/meals_listing_states.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({Key key}) : super(key: key);
  @override
  _ProductsPageState createState() => _ProductsPageState();
}


class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    BlocProvider.of<ProductListingBloc>(context).add(ProductListingFetchingEvent());
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Products')
      ),
      body: Container(
          child: BlocBuilder<ProductListingBloc, ProductListingState>(
          builder: (BuildContext context, state) {
            if (state is ProductListingLoadingState) {
              return Center(child: CircularProgressIndicator( strokeWidth: 2.0));
            } else if (state is ProductListingFetchedState) {
              final List<Product> products = state.products.reversed.toList();
                return ListView(
                  children: products.map((Product product) => Card(child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(product.title),
                        DateTimeWidget(dateTime: product.addedDatetime)
                      ]
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Code: ${product.code.toString()}'),
                        product.calorieContent == null ? Text('Calorie content: not specified') : Text('Calorie content: ${product.calorieContent.toStringAsFixed(2)} kCal'),
                      ],
                    ),
                    onTap: () => ProductActionsModal.showModal(context, product)
                  ))).toList(),
                );
            }

            return Center(child: Text('Unknown state'));
          }
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return CreateProductPage(
                  product: Product(),
                );
              }
          ));
        },
        tooltip: 'Add product',
        child: Icon(Icons.add),
      ),
    );
  }
}
