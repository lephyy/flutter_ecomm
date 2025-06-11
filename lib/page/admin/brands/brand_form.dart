import 'package:flutter/material.dart';
import 'brand_model.dart';
import 'package:uuid/uuid.dart';

class BrandForm extends StatefulWidget {
  final Brand? brand;
  final Function(Brand) onSave;

  BrandForm({this.brand, required this.onSave});

  @override
  _BrandFormState createState() => _BrandFormState();
}

class _BrandFormState extends State<BrandForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;

  @override
  void initState() {
    super.initState();
    _name = widget.brand?.name ?? '';
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final brand = Brand(
        id: widget.brand?.id ?? Uuid().v4(),
        name: _name,
      );
      widget.onSave(brand);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.brand == null ? 'Create Brand' : 'Edit Brand'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Brand Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _name = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(widget.brand == null ? 'Create' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
