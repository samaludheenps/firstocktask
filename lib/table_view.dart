import 'package:flutter/material.dart';

class TableView extends StatelessWidget {
  const TableView({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> jsonData = [
      {
        "id": "0001",
        "type": "donut",
        "name": "Cake",
        "ppu": 0.55,
        "batters": {
          "batter": [
            {"id": "1001", "type": "Regular"},
            {"id": "1002", "type": "Chocolate"},
            {"id": "1003", "type": "Blueberry"}
          ]
        },
        "topping": [
          {"id": "5001", "type": "None"},
          {"id": "5002", "type": "Glazed"},
          {"id": "5005", "type": "Sugar"},
          {"id": "5007", "type": "Powdered Sugar"}
        ]
      },
      {
        "id": "0002",
        "type": "donut",
        "name": "Cake",
        "ppu": 0.55,
        "batters": {
          "batter": [
            {"id": "1001", "type": "Blueberry"}
          ]
        },
        "topping": [
          {"id": "5001", "type": "None"},
          {"id": "5002", "type": "Glazed"}
        ]
      }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Table view"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          border: TableBorder.all(color: Colors.grey),
          columns: const [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('PPU')),
            DataColumn(label: Text('Batter')),
            DataColumn(label: Text('Topping')),
          ],
          rows: jsonData.expand<DataRow>((item) {
            final id = item['id'];
            final type = item['type'];
            final name = item['name'];
            final ppu = item['ppu'];
            final batters = item['batters']['batter'];
            final topping = item['topping'];

            final toppingTypes =
                topping.map<dynamic>((top) => top['type']).join(', ');

            return batters.map<DataRow>((batter) {
              final batterType = batter['type'];

              return DataRow(
                cells: [
                  DataCell(Text(id)),
                  DataCell(Text(type)),
                  DataCell(Text(name)),
                  DataCell(Text(ppu.toString())),
                  DataCell(Text(batterType)),
                  DataCell(Text(toppingTypes)),
                ],
              );
            }).toList(); // Convert Iterable<DataRow> to List<DataRow>
          }).toList(),
        ),
      ),
    );
  }
}
