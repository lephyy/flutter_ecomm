import 'package:flutter/material.dart';
import 'brand_model.dart';
import 'brand_form.dart';

class BrandsPage extends StatefulWidget {
  @override
  _BrandsPageState createState() => _BrandsPageState();
}

class _BrandsPageState extends State<BrandsPage> {
  final List<Brand> _brands = [];

  void _addBrand(Brand brand) {
    setState(() {
      _brands.add(brand);
    });
  }

  void _updateBrand(Brand updatedBrand) {
    setState(() {
      final index = _brands.indexWhere((b) => b.id == updatedBrand.id);
      if (index != -1) {
        _brands[index] = updatedBrand;
      }
    });
  }

  void _deleteBrand(String id) {
    setState(() {
      _brands.removeWhere((brand) => brand.id == id);
    });
  }

  void _showBrandForm({Brand? brand}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BrandForm(
          brand: brand,
          onSave: brand == null ? _addBrand : _updateBrand,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _brands.isEmpty
          ? Center(child: Text('No brands added yet.'))
          : ListView.builder(
        itemCount: _brands.length,
        itemBuilder: (_, index) {
          final brand = _brands[index];
          return ListTile(
            title: Text(brand.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _showBrandForm(brand: brand),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteBrand(brand.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBrandForm(),
        child: Icon(Icons.add),
      ),
    );
  }
}
