// lib/widgets/item_tile.dart
import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  final VoidCallback onAdd;

  const ItemTile({
    Key? key,
    required this.item,
    required this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // Item image on the left
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.assetImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),

          // Name + tap-to-view-dialog
          Expanded(
            child: GestureDetector(
              onTap: () => _showImageDialog(context), // full‑size picture
              child: Text(
                item.name,
                style: const TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),

          // Price
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),

          // Add‑to‑cart icon
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: const EdgeInsets.all(16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(item.assetImage, width: 200, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 16),
            IconButton(
              iconSize: 32,
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                Navigator.pop(context);
                onAdd();
              },
            ),
          ],
        ),
      ),
    );
  }
}
