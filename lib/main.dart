import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DataTable Demo',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const DataTableScreen(),
    );
  }
}

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});
  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  List<Map<String, dynamic>> students = [
    {'name': 'Amara',  'country': 'Rwanda',   'score': 95, 'selected': false},
    {'name': 'Kwame',  'country': 'Ghana',    'score': 88, 'selected': false},
    {'name': 'Zainab', 'country': 'Nigeria',  'score': 92, 'selected': false},
    {'name': 'Tendai', 'country': 'Zimbabwe', 'score': 74, 'selected': false},
    {'name': 'Fatou',  'country': 'Senegal',  'score': 61, 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Scores'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Country')),
            DataColumn(label: Text('Score'), numeric: true),
            DataColumn(label: Text('Status')),
          ],
          rows: students.map((student) {
            return DataRow(cells: [
              DataCell(Text(student['name'])),
              DataCell(Text(student['country'])),
              DataCell(Text('${student['score']}')),
              DataCell(Text('—')),
            ]);
          }).toList(),
        ),
      ),
    );
  }
} 