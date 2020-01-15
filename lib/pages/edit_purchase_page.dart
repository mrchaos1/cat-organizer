import 'package:catmanager/blocs/product_listing_bloc.dart';
import 'package:catmanager/blocs/purchase_listing_bloc.dart';
import 'package:catmanager/blocs/states/product_listing_states.dart';
import 'package:catmanager/blocs/states/purchase_listing_states.dart';
import 'package:catmanager/events/product_listing_event.dart';
import 'package:catmanager/events/purchase_listing_event.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/models/purchase_model.dart';
import 'package:catmanager/repositories/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class EditPurchasePage extends StatefulWidget {
  EditPurchasePage({
    Key key, this.purchase
  }) : super(key: key);

  final Purchase purchase;

  @override
  _EditPurchasePageState createState() => _EditPurchasePageState();
}

class _EditPurchasePageState extends State<EditPurchasePage> {

  final _formKey = GlobalKey<FormState>();
  final _productRepository = ProductRepository();
  Product _selectedProduct = null;

  TextEditingController _productTitle = new TextEditingController();
  TextEditingController _productCode = new TextEditingController();
  TextEditingController _productNetWeight = new TextEditingController();
  TextEditingController _productCalorieContent = new TextEditingController();

  TextEditingController _priceController = new TextEditingController();
  TextEditingController _quantityController = new TextEditingController(text: '1');
  TextEditingController _descriptionController = new TextEditingController();

  final _productTitleFocus = FocusNode();
  final _productCodeFocus = FocusNode();
  final _productNetWeightFocus = FocusNode();
  final _productCalorieContentFocus = FocusNode();
  final _priceFocus = FocusNode();
  final _quantityFocus = FocusNode();
  final _descriptionFocus = FocusNode();


  @override
  void initState() {
    super.initState();
    if (widget.purchase.id != null) {
      _priceController.text = widget.purchase.price.toString();
      _quantityController.text = widget.purchase.quantity.toString();
      _descriptionController.text = widget.purchase.description;
    }

    if (widget.purchase.productId != null) {
      _setSelectedProduct(widget.purchase.productId);
    }
  }

  @override
  void dispose() {
    _productTitle.dispose();
    _productCode.dispose();
    _productNetWeight.dispose();
    _productCalorieContent.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }


  _setSelectedProduct(int productId) async {
    _selectedProduct = await _productRepository.find(widget.purchase.productId);
    _onProductSelect(_selectedProduct);
  }

  _onProductSelect(Product product) {
    _productTitle.text = product.title;
    _productCode.text = product.code.toString();
    _productNetWeight.text = product.netWeight.toString();
    _productCalorieContent.text = product.calorieContent.toString();
    _selectedProduct = product;
  }

  _foundProductItem(Product product) {
    return ListTile(
      title: Text('${product.title}'),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Code: ${product.code.toString()}'),
          Text('Calorie content: ${product.calorieContent.toString()}'),
          Text('Net weight: ${product.netWeight}'),
        ],
      ),
    );
  }

  _savePurchase(Product product) {
    final Purchase purchase = Purchase(
      productId: product.id,
      description: _descriptionController.text,
      datetime: DateTime.now(),
      price: double.parse(_priceController.text),
      quantity: double.parse(_quantityController.text),
    );

    BlocProvider.of<PurchaseListingBloc>(context).add(PurchaseCreatingEvent(purchase));
    Navigator.of(context).pop();
  }


  _save() {
    if (_formKey.currentState.validate()) {
      if (_selectedProduct is Product && _selectedProduct.id != null) {
        _savePurchase(_selectedProduct);
      } else {
        final Product product = Product(
          title: _productTitle.text,
          calorieContent: _productCalorieContent.text == '' ? null : double.parse(_productCalorieContent.text),
          code: _productCode.text == '' ? null : int.parse(_productCode.text),
          netWeight: _productNetWeight.text == '' ? null : double.parse(_productNetWeight.text),
          addedDatetime: DateTime.now(),
        );

        BlocProvider.of<ProductListingBloc>(context).add(ProductCreatingEvent(product, () {
          _savePurchase(product);
        }));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit purchase'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _save(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Builder(
                  builder: (context) {
                    if (_selectedProduct != null) {
                      return Container(
                          child: Card(
                            color: Color(0xFFC8E6C9),
                            child: ListTile(
                              title: Text(_selectedProduct.title),
                              trailing: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () => setState(() {
                                  _selectedProduct = null;
                                }),
                              ),
                            ),
                          ),
                        );
                    }

                    return Container(
                      child: Card(
                        color: Color(0xFFBBDEFB),
                        child : ListTile(
                          title: Text('Select product'),
                        ),
                      )
                    );
                  }
                ),

                TextFormField(
                  focusNode: _priceFocus,
                  decoration: InputDecoration(
                    labelText: 'Price'
                  ),
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_quantityFocus),
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: _priceController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter value';
                    }
                  },
                ),

                TextFormField(
                  focusNode: _quantityFocus,
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_productTitleFocus),
                  decoration: InputDecoration(
                      labelText: 'Quantity'
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  maxLines: null,
                  controller: _quantityController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter value';
                    }
                  },
                ),

                TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_productCodeFocus),
                        focusNode: _productTitleFocus,
                        textInputAction: TextInputAction.next,
                        controller: this._productTitle,
                        decoration: InputDecoration(
                            labelText: 'Product title'
                        )
                    ),
                    suggestionsCallback: (pattern) =>  _productRepository.search(pattern),
                    itemBuilder: (context, Product product) => _foundProductItem(product),
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Product product) => _onProductSelect(product)
                ),

                TypeAheadFormField(
                    textFieldConfiguration: TextFieldConfiguration(
                        onEditingComplete: () => FocusScope.of(context).requestFocus(_productNetWeightFocus),
                        focusNode: _productCodeFocus,
                        textInputAction: TextInputAction.next,
                        controller: this._productCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Product code'
                        )
                    ),
                    suggestionsCallback: (pattern) =>  _productRepository.search(pattern),
                    itemBuilder: (context, Product product) => _foundProductItem(product),
                    transitionBuilder: (context, suggestionsBox, controller) {
                      return suggestionsBox;
                    },
                    onSuggestionSelected: (Product product) => _onProductSelect(product)
                ),

                TextFormField(
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_productCalorieContentFocus),
                  focusNode: _productNetWeightFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Product net weight'
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: _productNetWeight,
                ),
                TextFormField(
                  onEditingComplete: () => FocusScope.of(context).requestFocus(_descriptionFocus),
                  focusNode: _productCalorieContentFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Product calorie content'
                  ),
                  keyboardType: TextInputType.number,
                  maxLines: null,
                  controller: _productCalorieContent,
                ),
                TextFormField(
                  focusNode: _descriptionFocus,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                  maxLines: 2,
                  controller: _descriptionController,
                ),

                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                    onPressed: () => _save(),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}