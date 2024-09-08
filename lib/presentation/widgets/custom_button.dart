import 'package:flutter/material.dart';
import 'package:klontongan/core/utils/styles.dart';

class CustomSubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  const CustomSubmitButton({
    super.key,
    this.onPressed,
    this.text = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: blueColor,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
      ),
      child: Text(
        text,
        style: whiteTextStyle.copyWith(
          fontSize: 16,
          fontWeight: semibold,
        ),
      ),
    );
  }
}

class CustomDeleteButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomDeleteButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(160, 40),
        side: BorderSide(color: grayColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Hapus Barang',
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
          color: redColor,
        ),
      ),
    );
  }
}

class CustomEditButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomEditButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 40),
        backgroundColor: blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Text(
        'Edit Barang',
        style: whiteTextStyle.copyWith(
          fontWeight: bold,
        ),
      ),
    );
  }
}
