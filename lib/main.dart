import 'package:flutter/material.dart';
import 'package:radio_form_field/radiogroup_form_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'RadioFormField demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: RadioGroupFormField(values: const [
                  'Котэ',
                  'Собакен',
                  'Сурикат',
/*
                  'Кот2',
                  'Со9ба2кен',
                  'Сур9и2каты',
                  'К293от',
                  'С7о93бакен',
                  'Сур749икаты',
                  'Ко785т',
                  'Соб6677акен',
                  'Сур754и7каты',
                  'Соба24к7ен',
                  'Сури23ка7ты',
                  'К23о73т',
                  'Со3ба72кен',
                  'Сур4ик17аты',
                  'Ко57т2',
                  'Соб67а4rкен',
                  'Сур7и7каfты',
*/
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: textController,
                  decoration: const InputDecoration(
                      hintText: 'Enter name', border: OutlineInputBorder()),
                  validator: (value) =>
                      value != null && value.isNotEmpty ? null : 'Required',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  key: const Key('submitButton'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
