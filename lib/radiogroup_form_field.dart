import 'package:flutter/material.dart';

class _RadioGroupData {
  _RadioGroupData(this.itemsList)
      : assert(
            itemsList.every(
              (element1) =>
                  itemsList.where((element2) => element1 == element2).length ==
                  1,
            ),
            'Elements in RadioGroup must be unique'),
        assert(itemsList.length > 1,
            'RadioGroup must contain at least two elements');

  final List<String> itemsList;
  String? _selectedItem;

  set selectedItem(String? value) {
    assert(itemsList.contains(value));
    _selectedItem = value;
  }

  String? get selectedItem => _selectedItem;

  bool get isValid => _selectedItem != null;
}

class RadioGroupFormField extends FormField<_RadioGroupData> {
  static const defaultSubmitErrorMessage = 'Please select an option';

  RadioGroupFormField({
    Key? key,
    required List<String> values,
  }) : super(
          key: key,
          initialValue: _RadioGroupData(values),
          validator: (value) {
            if (value!.selectedItem == null) {
              return defaultSubmitErrorMessage;
            }
            return null;
          },
          builder: (state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: values.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(values[index]),
                      onTap: () {
                        state.value!.selectedItem = values[index];
                        state.validate();
                      },
                      trailing: Radio<String>(
                          value: values[index],
                          groupValue: state.value!.selectedItem,
                          onChanged: (value) {
                            state.value!.selectedItem = values[index];
                            state.validate();
                          }),
                    ),
                  ),
                ),
                if (state.hasError)
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      defaultSubmitErrorMessage,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
}
