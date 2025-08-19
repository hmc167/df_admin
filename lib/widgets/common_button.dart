import 'package:admin/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double width;
  final double height;
  final IconData? icon;

  const CommonButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.textColorWhite,
    this.borderColor = AppColors.primaryColor,
    this.width = 200,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon!, color: textColor, size: 22),
                SizedBox(width: 8),
              ],
              Text(text, style: TextStyle(color: textColor, fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
