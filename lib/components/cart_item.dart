import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tiny_shop/models/products_response.dart';
import 'package:tiny_shop/store/cart_store.dart';

class CartItem extends StatefulWidget {
  final ProductResponseData product;
  final int quantity;
  final Future<void> Function(int) onQuantityChanged;

  const new({
    super.key,
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late final TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();

    _quantityController = TextEditingController(text: '${widget.quantity}');
  }

  @override
  void didUpdateWidget(covariant CartItem oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.quantity != widget.quantity) {
      _setQuantityText(widget.quantity);
    }
  }

  void _setQuantityText(int quantity) {
    final text = '$quantity';
    _quantityController.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  Future<void> _submitQuantity(String value) async {
    final quantity = int.tryParse(value);
    if (quantity == null) {
      _setQuantityText(widget.quantity);
      return;
    }

    await _updateQuantity(quantity);
  }

  Future<void> _updateQuantity(int quantity) async {
    try {
      await widget.onQuantityChanged(quantity);
    } on CartPersistenceException catch (error) {
      if (!mounted) return;

      _setQuantityText(widget.quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          backgroundColor: Colors.red,
          content: Text(error.message),
        ),
      );
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F7),
              borderRadius: BorderRadius.circular(8),
              image: widget.product.image != null
                  ? DecorationImage(
                      image: NetworkImage(widget.product.image!),
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            child: widget.product.image != null
                ? const Icon(Icons.image, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.product.tagline!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.product.price!,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                tooltip: widget.quantity == 1
                    ? 'Remove item'
                    : 'Decrease quantity',
                color: widget.quantity == 1 ? Colors.red : Colors.grey,
                icon: Icon(
                  widget.quantity == 1 ? Icons.delete_outlined : Icons.remove,
                ),
                onPressed: () {
                  _updateQuantity(widget.quantity - 1);
                },
              ),
              SizedBox(
                width: 48,
                child: TextField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    isDense: true,
                  ),
                  onSubmitted: _submitQuantity,
                ),
              ),
              IconButton(
                tooltip: 'Increase quantity',
                icon: const Icon(Icons.add),
                onPressed: () {
                  _updateQuantity(widget.quantity + 1);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
