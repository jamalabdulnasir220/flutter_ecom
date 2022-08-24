
import 'package:ecommerce/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';

import '../utils/dimensions.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  final Color iconColor;
  const IconAndTextWidget({Key? key, required this.icon, required this.text,  required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: Dimensions.iconsize24,),
        SizedBox(width: Dimensions.width3,),
        SmallText(text: text,)
      ],
    );
  }
}
