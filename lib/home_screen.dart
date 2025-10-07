import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:expense_tracker/expense/add_page.dart';
import 'package:expense_tracker/expense/chart_screen.dart';
import 'package:expense_tracker/me_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> _titles = ['Home', 'Chart', 'Add', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Chart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Add',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
        ],
      ),
    );
  }

  // ----------------- Body for each tab -----------------
  Widget getBody() {
    if (_currentIndex == 0) {
      // 🏠 HOME TAB
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 💰 Balance Card
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF7F00FF), Color(0xFFE100FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Balance',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '\$85,432.43',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Income\n\$5,850.00',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      Text(
                        'Expenses\n\$430.00',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 🧾 Transactions Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'See All',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 📋 Transaction List
            Expanded(
              child: ListView(
                children: const [
                  TransactionTile(
                    icon: Icons.business,
                    color: Colors.blue,
                    title: 'Mahila Inc.',
                    subtitle: 'Today 10:35 AM',
                    amount: '-\$43.00',
                    amountColor: Colors.red,
                  ),
                  TransactionTile(
                    icon: Icons.account_balance,
                    color: Colors.green,
                    title: 'Palibert Inc.',
                    subtitle: 'Today 09:15 AM',
                    amount: '+\$1,324.32',
                    amountColor: Colors.green,
                  ),
                  TransactionTile(
                    icon: Icons.account_balance_wallet,
                    color: Colors.orange,
                    title: 'Richard Inc.',
                    subtitle: 'Today 08:00 AM',
                    amount: '-\$231.43',
                    amountColor: Colors.red,
                  ),
                  TransactionTile(
                    icon: Icons.work,
                    color: Colors.purple,
                    title: 'Owen Inc.',
                    subtitle: 'Yesterday 01:45 PM',
                    amount: '+\$4,433.00',
                    amountColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (_currentIndex == 1) {
      return const ChartScreen();
    } else if (_currentIndex == 2) {
      return const AddScreen();
    } else if (_currentIndex == 3) {
      return const MePage();
    } else {
      return Center(
        child: Text(
          _titles[_currentIndex] + ' Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    }
  }
}

// 🔹 Custom widget for each transaction row
class TransactionTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final String amount;
  final Color amountColor;

  const TransactionTile({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.1),
            radius: 24,
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
