//@dart=2.9
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:sms/provider/resident.dart';
import 'package:sms/models/resident.dart';
import 'package:sms/services/resident.dart';

/// Example without a datasource
class ResidentsTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final ResProvider resProvider = Provider.of<ResProvider>(context);
    final ResidentServices residentServices = ResidentServices();
    List<ResidentModel> model;

    return FutureBuilder(
        future: residentServices.getAll(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Expanded(
              // padding: const EdgeInsets.all(35),
              child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: [
                    DataColumn2(
                      label: Text('ID'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('NAME'),
                    ),
                    DataColumn(
                      label: Text('ADDRESS'),
                    ),
                    DataColumn(
                      label: Text('EMAIL'),
                    ),
                    DataColumn(
                      label: Text('CONTACT'),
                      numeric: true,
                    ),
                  ],
                  rows: List<DataRow>.generate(
                      snapshot.data.length,
                      (index) => DataRow(cells: [
                            DataCell(Text("${snapshot.data[index].id}")),
                            DataCell(Text("${snapshot.data[index].name}")),
                            DataCell(Text("${snapshot.data[index].address}")),
                            DataCell(Text("${snapshot.data[index].email}")),
                            DataCell(
                                Text(snapshot.data[index].contact.toString()))
                          ]))),
            );
          } else {
            return Container();
          }
        }));
  }
}
