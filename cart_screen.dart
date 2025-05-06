import 'package:flutter/material.dart';
import '../models/item.dart';

class CartScreen extends StatefulWidget {
  final List<Item> cart;
  const CartScreen({required this.cart, super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get subtotal => widget.cart.fold(0, (sum, item) => sum + item.price);
  double get tax      => subtotal * 0.13;
  double get total    => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    final itemCount = widget.cart.length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bag ($itemCount ${itemCount == 1 ? 'item' : 'items'})'),
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, i) {
                final item = widget.cart[i];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() => widget.cart.removeAt(i));
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Subtotal: \$${subtotal.toStringAsFixed(2)}'),
                Text('Tax (13%): \$${tax.toStringAsFixed(2)}'),
                const Divider(),
                Text(
                  'Total (with tax): \$${total.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
