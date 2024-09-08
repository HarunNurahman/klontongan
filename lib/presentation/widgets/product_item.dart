import 'package:flutter/material.dart';
import 'package:klontongan/core/utils/styles.dart';

class ProductItem extends StatelessWidget {
  final String itemName;
  final String itemSKU;
  final String itemPrice;
  final VoidCallback? onTap;
  const ProductItem({
    super.key,
    required this.itemName,
    required this.itemSKU,
    required this.itemPrice,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        // Item information
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Item name and SKU
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item name
                  Text(
                    itemName,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Item SKU
                  Text(
                    itemSKU,
                    style: grayTextStyle.copyWith(
                      fontSize: 12,
                      fontWeight: light,
                    ),
                  )
                ],
              ),
            ),
            // Item price
            Text(
              itemPrice,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semibold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
