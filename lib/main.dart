import 'package:flutter/material.dart';
import 'package:radio_form_field/radiogroup_form_field.dart';

void main() {
  runApp(const MyApp());
}

const pets = ['cat', 'dog', 'meerkat'];
const numbers = [2.71828, 3.14159, 9.80665];
const petsLong = [
  'cats',
  'dogs',
  'birds',
  'rabbits',
  'horses',
  'ferrets',
  'fish',
  'guinea pigs',
  'rats',
  'mice',
  'amphibians',
  'reptiles',
];

const pics = [
  'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/MatheranPanoramaPointDrySeasonCrop.jpg/640px-MatheranPanoramaPointDrySeasonCrop.jpg',
  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/MatheranPanoramaPointMonsoonCrop.jpg/640px-MatheranPanoramaPointMonsoonCrop.jpg',
];

const tabs = [
  'default',
  '<double>',
  '<User>',
  'onChanged',
  'validator',
  'long',
  'custom',
  'images',
];

const petsCustom = ['cybercat', 'megadog', 'meerkat'];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
          length: tabs.length,
          child: const MyHomePage(title: 'RadioFormField demo')),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          DefaultExample(context: context),
          DoubleExample(context: context),
          UsersExample(context: context),
          OnChangedExample(context: context),
          ValidatorExample(context: context),
          LongExample(context: context),
          CustomExample(context: context),
          ImagesExample(context: context),
        ],
      ),
    );
  }
}

class DefaultExample extends StatelessWidget {
  DefaultExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "What's your favourite pet?",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<String>(
                itemsList: pets,
              ),
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
    );
  }
}

class DoubleExample extends StatelessWidget {
  DoubleExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "The value of pi is approximately:",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<double>(
                itemsList: numbers,
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
    );
  }
}

class OnChangedExample extends StatelessWidget {
  OnChangedExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  SnackBar snackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return SnackBar(
      content: Text('You selected $value'),
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "The value of pi is approximately:",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<double>(
                itemsList: numbers,
                onChanged: (data) => ScaffoldMessenger.of(context)
                    .showSnackBar(snackBar(data.selectedItem.toString())),
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
    );
  }
}

class ValidatorExample extends StatelessWidget {
  ValidatorExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "What's your favourite pet?",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<String>(
                itemsList: pets,
                validator: (data) {
                  if (data?.selectedItem != data?.itemsList.first) {
                    return 'Are you really sure?';
                  } else {
                    return null;
                  }
                },
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
    );
  }
}

class LongExample extends StatelessWidget {
  LongExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "So, who's the best of the best?",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<String>(
                itemsList: petsLong,
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
    );
  }
}

class CustomExample extends StatelessWidget {
  CustomExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.black,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    'CHOOSE YOUR CHARACTER',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: RadioGroupFormField<String>(
                  listShrinkWrap: false,
                  errorWidgetBuilder: (_) => const Expanded(
                    child: Text(
                      'Select a character',
                      style: TextStyle(
                        color: Colors.orangeAccent,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  radioPosition: RadioPosition.leading,
                  itemTitleBuilder: (context, index, value) => Text(
                    value,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  itemsList: petsCustom,
                  radioDecoration: RadioDecoration(
                      toggleable: true,
                      activeColor: Colors.yellow,
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey.withOpacity(.32);
                        } else if (states.contains(MaterialState.selected)) {
                          return Colors.yellow.withOpacity(.8);
                        }
                        return Colors.grey.withOpacity(.60);
                      })),
                  tileDecoration: TileDecoration(
                    dense: true,
                    tileColor: Colors.black,
                    textColor: Colors.white.withOpacity(0.6),
                    selectedTileColor: Colors.green.withOpacity(0.6),
                    selectedColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: Colors.green.withOpacity(0.6), width: 1.0)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: ElevatedButton(
                  key: const Key('submitButton'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith<Color>((states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey.withOpacity(.32);
                    } else if (states.contains(MaterialState.selected)) {
                      return Colors.yellow.withOpacity(.8);
                    }
                    return Colors.green.withOpacity(.60);
                  })),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagesExample extends StatelessWidget {
  ImagesExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                'Pick one:',
                style: TextStyle(fontSize: 24),
              ),
            ),
            Flexible(
              child: RadioGroupFormField<String>(
                itemsList: pics,
                listShrinkWrap: false,
                errorWidgetBuilder: (_) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Image.asset(
                      'assets/images/index-pointing-up.png',
                    ),
                  ),
                ),
                radioPosition: RadioPosition.leading,
                itemTitleBuilder: (context, index, value) => SizedBox(
                  height: 48,
                  child: Image.network(
                    value,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                tileDecoration: TileDecoration(
                    selectedTileColor: Colors.blue.withOpacity(0.5)),
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
    );
  }
}

class User {
  const User(this.id, this.login, this.name);

  final int id;
  final String login;
  final String name;

  @override
  String toString() {
    return 'User{id: $id, login: $login, name: $name}';
  }
}

const users = [
  User(1, 'john', 'John Smith'),
  User(2, 'barbara', 'Barbara Smith'),
  User(3, 'alien', 'Robert Martianovich'),
];

class UsersExample extends StatelessWidget {
  UsersExample({Key? key, required this.context}) : super(key: key);

  final BuildContext context;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textController = TextEditingController();
  User? _selectedUser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Best name for alien is:",
                style: TextStyle(fontSize: 18),
              ),
            )),
            Flexible(
              child: RadioGroupFormField<User>(
                itemsList: users,
                itemTitleBuilder: (context, index, user) => Text(user.name),
                onChanged: (data) {
                  _selectedUser = data.selectedItem;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                key: const Key('submitButton'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Processing Data: $_selectedUser')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
