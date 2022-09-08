//@dart=2.9
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:sms/models/resident.dart';
import 'package:sms/services/resident.dart';

import 'package:sms/helper/constants.dart';

/// Example without a datasource
class ResidentsTable extends StatefulWidget {
  @override
  State<ResidentsTable> createState() => _ResidentsTableState();
}

class _ResidentsTableState extends State<ResidentsTable> {
  var enableField = false;
  @override
  Widget build(BuildContext context) {
    // final ResProvider resProvider = Provider.of<ResProvider>(context);
    final ResidentServices residentServices = ResidentServices();
    List<ResidentModel> model;
    updateData(id, key, value) {
      firebaseFirestore.collection("residents").doc(id).update({key: value});
    }

    return FutureBuilder(
        future: residentServices.getAll(),
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.data != null) {
            return Form(
              child: Expanded(
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
                              DataCell(InkWell(
                                onLongPress: (() {
                                  setState(() {
                                    enableField = true;
                                  });
                                }),
                                child: TextFormField(
                                  enabled: enableField,
                                  initialValue: "${snapshot.data[index].name}",
                                  onFieldSubmitted: ((value) {
                                    updateData("${snapshot.data[index].id}",
                                        "name", value);
                                    setState(() {
                                      enableField = false;
                                    });
                                  }),
                                ),
                              )),
                              DataCell(InkWell(
                                onLongPress: (() {
                                  setState(() {
                                    enableField = true;
                                  });
                                }),
                                child: TextFormField(
                                  enabled: enableField,
                                  initialValue:
                                      "${snapshot.data[index].address}",
                                  onFieldSubmitted: ((value) {
                                    updateData("${snapshot.data[index].id}",
                                        "address", value);
                                    setState(() {
                                      enableField = false;
                                    });
                                  }),
                                ),
                              )),
                              DataCell(InkWell(
                                onLongPress: (() {
                                  setState(() {
                                    enableField = true;
                                  });
                                }),
                                child: TextFormField(
                                  enabled: enableField,
                                  initialValue: "${snapshot.data[index].email}",
                                  onFieldSubmitted: ((value) {
                                    updateData("${snapshot.data[index].id}",
                                        "email", value);
                                    setState(() {
                                      enableField = false;
                                    });
                                  }),
                                ),
                              )),
                              DataCell(InkWell(
                                onLongPress: (() {
                                  setState(() {
                                    enableField = true;
                                  });
                                }),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                  },
                                  enabled: enableField,
                                  initialValue:
                                      snapshot.data[index].contact.toString(),
                                  onFieldSubmitted: ((value) {
                                    updateData("${snapshot.data[index].id}",
                                        "contact", int.parse(value));
                                    setState(() {
                                      enableField = false;
                                    });
                                  }),
                                ),
                              ))
                            ]))),
              ),
            );
          } else {
            return Container();
          }
        }));
  }
}
