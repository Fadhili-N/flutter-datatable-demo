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

  int sortColumnIndex = 0;
  bool sortAscending = true;

  void _sort(String key, int columnIndex, bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
      students.sort((a, b) {
        if (a[key] is int) {
          return ascending
              ? (a[key] as int).compareTo(b[key] as int)
              : (b[key] as int).compareTo(a[key] as int);
        }
        return ascending
            ? (a[key] as String).compareTo(b[key] as String)
            : (b[key] as String).compareTo(a[key] as String);
      });
    });
  }

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
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
          columns: [
            DataColumn(
              label: const Text('Name'),
              onSort: (i, asc) => _sort('name', i, asc),
            ),
            DataColumn(
              label: const Text('Country'),
              onSort: (i, asc) => _sort('country', i, asc),
            ),
            DataColumn(
              label: const Text('Score'),
              numeric: true,
              onSort: (i, asc) => _sort('score', i, asc),
            ),
            const DataColumn(label: Text('Status')),
          ],
          rows: students.map((student) {
            final bool passed = student['score'] >= 70;
            return DataRow(
              selected: student['selected'],
              onSelectChanged: (isSelected) {
                setState(() {
                  student['selected'] = isSelected ?? false;
                });
              },
              cells: [
                DataCell(Text(student['name'])),
                DataCell(Text(student['country'])),
                DataCell(Text(
                  '${student['score']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: passed ? Colors.green[100] : Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      passed ? 'Pass' : 'Review',
                      style: TextStyle(
                        color: passed
                            ? Colors.green[800]
                            : Colors.orange[800],
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}