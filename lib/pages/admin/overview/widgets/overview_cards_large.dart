//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms/pages/admin/overview/widgets/info_card.dart';
import 'package:sms/provider/resident.dart';
import 'package:sms/services/resident.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    final ResProvider resProvider = Provider.of<ResProvider>(context);
    final ResidentServices residentServices = ResidentServices();

    return FutureBuilder(
        future: residentServices.getNumberofRes(),
        builder: ((context, snapshot) {
          return Row(
            children: [
              InfoCard(
                title: "Number of residents",
                value: snapshot.data,
                onTap: () {},
                topColor: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title: "abc",
                value: "17",
                topColor: Colors.lightGreen,
                onTap: () {},
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title: "abc",
                value: "3",
                topColor: Colors.redAccent,
                onTap: () {},
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title: "abc",
                value: "32",
                onTap: () {},
              ),
            ],
          );
        }));
  }
}
