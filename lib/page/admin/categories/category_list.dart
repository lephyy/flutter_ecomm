import 'package:flutter/material.dart';
import 'category_model.dart';
import 'category_form.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final List<Category> _categories = [];

  void _addCategory(Category category) {
    setState(() {
      _categories.add(category);
    });
  }

  void _updateCategory(Category updatedCategory) {
    setState(() {
      final index = _categories.indexWhere((c) => c.id == updatedCategory.id);
      if (index != -1) {
        _categories[index] = updatedCategory;
      }
    });
  }

  void _deleteCategory(String id) {
    setState(() {
      _categories.removeWhere((category) => category.id == id);
    });
  }

  void _showCategoryForm({Category? category}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryForm(
          category: category,
          onSave: category == null ? _addCategory : _updateCategory,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _categories.isEmpty
          ? Center(child: Text('No categories added yet.'))
          : ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (_, index) {
          final category = _categories[index];
          return ListTile(
            title: Text(category.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: () => _showCategoryForm(category: category),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteCategory(category.id),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryForm(),
        child: Icon(Icons.add),
      ),
    );
  }

}
