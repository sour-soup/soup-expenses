import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/category/category_provider.dart';

class AddCategoryWidget extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Название категории'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Описание категории'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                ref.read(categoryProvider.notifier).addCategory(_nameController.text, _descriptionController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
