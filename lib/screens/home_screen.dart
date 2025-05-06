// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/item.dart';
import '../widgets/item_tile.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // All items with explicit category
  final List<Item> _allItems = [
    Item('Soccer Ball',                  19.99, 'assets/images/soccer_ball.png',      'Ball'),
    Item('Basketball',                   14.99, 'assets/images/basketball_ball.jpg',   'Ball'),
    Item('Tennis Racket',                89.99, 'assets/images/tennis_racket.jpg',     'Racket'),
    Item('Tennis Balls (Pack of 3)',      9.99, 'assets/images/tennis_balls.jpg',      'Ball'),
    Item('Baseball Glove',               49.99, 'assets/images/baseball_glove.jpg',    'Glove'),
    Item('Baseball Bat',                 59.99, 'assets/images/baseball_bat.jpg',      'Bat'),
    Item('Volleyball',                   12.99, 'assets/images/volleyball_ball.jpg',    'Ball'),
    Item('Skateboard',                   49.99, 'assets/images/skateboard_board.jpg',   'Board'),
    Item('Snowboard',                   199.99, 'assets/images/snowboard_board.jpg',    'Board'),
  ];

  // Categories list
  final List<String> _categories = ['Ball', 'Racket', 'Bat', 'Glove', 'Board'];

  // State
  bool _showPopular = true;
  String _selectedCategory = '';
  List<Item> _displayItems = [];
  final List<Item> _cart = [];

  @override
  void initState() {
    super.initState();
    _showPopularItems();
  }

  // Show first 5 items
  void _showPopularItems() {
    setState(() {
      _showPopular = true;
      _selectedCategory = '';
      _displayItems = _allItems.take(5).toList();
    });
  }

  // Filter by exact category
  void _onCategoryTap(String category) {
    setState(() {
      _showPopular = false;
      _selectedCategory = category;
      _displayItems = _allItems
          .where((item) => item.category == category)
          .toList();
    });
  }

  void _addToCart(Item item) {
    setState(() => _cart.add(item));
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartScreen(cart: _cart)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sport Shop')),
      body: Column(
        children: [
          // Item list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _displayItems.length,
              itemBuilder: (context, index) {
                final item = _displayItems[index];
                return ItemTile(item: item, onAdd: () => _addToCart(item));
              },
            ),
          ),

          const Divider(height: 1),

          // Bottom bar: Popular + category chips + cart
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                // Chips
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: const Text('Popular'),
                          selected: _showPopular,
                          onSelected: (_) => _showPopularItems(),
                        ),
                        const SizedBox(width: 8),
                        ..._categories.map((cat) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat),
                            selected: _selectedCategory == cat,
                            onSelected: (_) => _onCategoryTap(cat),
                          ),
                        )),
                      ],
                    ),
                  ),
                ),

                // Cart icon with badge
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_bag, size: 28),
                        onPressed: _openCart,
                      ),
                      if (_cart.isNotEmpty)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                            child: Text(
                              '${_cart.length}',
                              style: const TextStyle(color: Colors.white, fontSize: 10),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
