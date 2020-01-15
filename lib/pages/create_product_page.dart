import 'package:catmanager/blocs/custom_dish_listing_bloc.dart';
import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/events/custom_dish_listing_event.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CreateProductPage extends StatefulWidget {
  CreateProductPage({
    Key key, this.product
  }) : super(key: key);

  final Product product;

  @override
  _CreateProductPageState createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _codeController = new TextEditingController();
  TextEditingController _netWeightController = new TextEditingController();
  TextEditingController _calorieContentController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product.id != null) {
      _titleController.text = widget.product.title;
      _codeController.text = widget.product.code.toString();
      _netWeightController.text = widget.product.netWeight.toString();
      _calorieContentController.text = widget.product.calorieContent.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Create product')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title'
                  ),
                  maxLines: null,
                  controller: _titleController,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Code'
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: _codeController,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Net weight'
                  ),
                  maxLines: null,
                  controller: _netWeightController,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Calorie content'
                  ),

                  maxLines: null,
                  controller: _calorieContentController,
                ),

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {


                        widget.product.title = _titleController.text;
                        widget.product.netWeight = double.parse(_netWeightController.text);
                        widget.product.code = int.parse(_codeController.text);
                        widget.product.calorieContent = double.parse(_calorieContentController.text);


                        BlocProvider.of<ProductListingBloc>(context).add(ProductCreatingEvent(widget.product, () {
                          Navigator.of(context).pop();
                        }));
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          Navigator.of(context).push(MaterialPageRoute(
//              builder: (BuildContext context) {
//                return CreateProductPage(
//                  product: Product(),
//                );
//              }
//          ));
        },
        tooltip: 'Scan barcode',
        child: Icon(Icons.camera),
      ),

    );
  }
}