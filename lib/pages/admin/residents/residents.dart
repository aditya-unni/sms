import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sms/widgets/custom_text.dart';

class ResidentsPage extends StatelessWidget {
  const ResidentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        text: "Residents",
      ),
    );
  }
}
