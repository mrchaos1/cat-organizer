import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/pages/create_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductActionsWidget extends StatefulWidget {
  ProductActionsWidget({ @required this.product });
  final Product product;
  _ProductActionsWidgetState createState() => _ProductActionsWidgetState();
}

class _ProductActionsWidgetState extends State<ProductActionsWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text('${widget.product.calorieContent.toString()}kCal/100g', style: TextStyle(color: Colors.white)),
                  Text('${widget.product.addedDatetime.toIso8601String()}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            color: Colors.blue,
          ),
          ListTile(
            title: Text('Edit'),
            trailing: Icon(Icons.edit),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return CreateProductPage(
                      product: widget.product,
                    );
                  }
              ));
            },
          ),
          ListTile(
            title: Text('Remove', style: TextStyle(color: Colors.red),),
            trailing: Icon(Icons.close, color: Colors.redAccent),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Delete product?', style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.normal, fontWeight: FontWeight.normal)),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Text('Yes'),
                        onPressed: () {
                          BlocProvider.of<ProductListingBloc>(context).add(ProductDeletingEvent(widget.product));
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

