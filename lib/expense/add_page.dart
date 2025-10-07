import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting date

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedType = 'Income';
  String _selectedCategory = 'Salary';
  DateTime _selectedDate = DateTime.now();

  final List<String> _categories = [
    'Salary',
    'Food',
    'Transport',
    'Shopping',
    'Other'
  ];

  // Function to pick a date
  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to save transaction (for now just print)
  void _saveTransaction() {
    if (_amountController.text.isEmpty) return;

    double amount = double.tryParse(_amountController.text) ?? 0;

    // For now, just print the values
    print('Type: $_selectedType');
    print('Category: $_selectedCategory');
    print('Amount: $amount');
    print('Date: ${DateFormat.yMMMd().format(_selectedDate)}');

    // Clear after saving
    _amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Transaction',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Type selector (Income / Expense)
          Row(
            children: [
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Income'),
                  value: 'Income',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile<String>(
                  title: const Text('Expense'),
                  value: 'Expense',
                  groupValue: _selectedType,
                  onChanged: (value) {
                    setState(() {
                      _selectedType = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Amount input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Category dropdown
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: _categories
                .map((cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Date picker
          Row(
            children: [
              Text(
                'Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _pickDate,
                child: const Text('Pick Date'),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveTransaction,
              child: const Text('Save Transaction'),
            ),
          ),
        ],
      ),
    );
  }
}


