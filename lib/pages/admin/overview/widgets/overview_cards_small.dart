//@dart=2.9
import 'package:flutter/material.dart';
import 'info_card_small.dart';
import 'package:sms/services/resident.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final ResidentServices residentServices = ResidentServices();

    return Container(
      height: 400,
      child: Column(
        children: [
          FutureBuilder(
              future: residentServices.getNumberofRes(),
              builder: ((context, AsyncSnapshot<String> snapshot) {
                return InfoCardSmall(
                  title: "Number Of Residents",
                  value: "${snapshot.data}",
                  onTap: () {},
                );
              })),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "abc",
            value: "17",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "abc",
            value: "3",
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "abc",
            value: "32",
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
