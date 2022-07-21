import 'package:flutter/material.dart';

enum RadioPosition { leading, trailing }

typedef IndexedWidgetValueBuilder<T> = Widget Function(
    BuildContext context, int index, T? value);

class RadioGroupFormField<T> extends FormField<RadioGroupData<T>> {
  static const defaultSubmitErrorMessage = 'Please select an option';

  RadioGroupFormField({
    Key? key,
    required List<T> itemsList,
    T? initialSelectedItem,
    this.onChanged,
    IndexedWidgetValueBuilder? itemTitleBuilder,
    RadioPosition? radioPosition = RadioPosition.trailing,
    WidgetBuilder? errorWidgetBuilder,
    RadioDecoration? radioDecoration,
    TileDecoration? tileDecoration,
    String? Function(RadioGroupData<T>?)? validator,
    bool? listShrinkWrap,
    //
  }) : super(
          key: key,
          initialValue: RadioGroupData(
            itemsList: itemsList,
            selectedItem: initialSelectedItem,
          ),
          validator: validator ??
              (value) {
                if (value?.selectedItem == null) {
                  return defaultSubmitErrorMessage;
                }
                return null;
              },
          builder: (FormFieldState<RadioGroupData<T>> state) {
            // to avoid code duplication:
            radio(int index) {
              return Radio<T>(
                value: itemsList[index],
                groupValue: state.value?.selectedItem,
                onChanged: (value) {
                  // state.value!.selectedItem = values[index];
                  state.setState(() {
                    state.value!.selectedItem = value;
                    onChanged?.call(state.value!);
                    if (value != null) {
                      state.reset();
                    }
                  });
                },
                mouseCursor: radioDecoration?.mouseCursor,
                toggleable: radioDecoration?.toggleable ?? false,
                activeColor: radioDecoration?.activeColor,
                fillColor: radioDecoration?.fillColor,
                focusColor: radioDecoration?.focusColor,
                hoverColor: radioDecoration?.hoverColor,
                overlayColor: radioDecoration?.overlayColor,
                splashRadius: radioDecoration?.splashRadius,
                materialTapTargetSize: radioDecoration?.materialTapTargetSize,
                visualDensity: radioDecoration?.visualDensity,
              );
            }

            final List<T> values = itemsList;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Material(
                    color: Colors.transparent,
                    child: ListView.builder(
                      shrinkWrap: listShrinkWrap ?? true,
                      itemCount: values.length,
                      itemBuilder: (context, index) => ListTile(
                        selected: state.value?.selectedItem == values[index],
                        title: itemTitleBuilder == null
                            ? Text(values[index].toString())
                            : itemTitleBuilder(context, index, values[index]),
                        onTap: () {
                          if (radioDecoration != null &&
                              radioDecoration.toggleable &&
                              state.value?.selectedItem == values[index]) {
                            state.setState(() {
                              state.value!.selectedItem = null;
                              onChanged?.call(state.value!);
                            });
                            return;
                          }

                          if (state.value!.selectedItem != values[index]) {
                            state.value!.selectedItem = values[index];
                            onChanged?.call(state.value!);
                            state.reset();
                          }
                        },
                        trailing: (radioPosition == RadioPosition.trailing)
                            ? radio(index)
                            : null,
                        leading: (radioPosition == RadioPosition.leading)
                            ? radio(index)
                            : null,
                        dense: tileDecoration?.dense,
                        visualDensity: tileDecoration?.visualDensity,
                        shape: tileDecoration?.shape,
                        selectedColor: tileDecoration?.selectedColor,
                        textColor: tileDecoration?.textColor,
                        style: tileDecoration?.style,
                        contentPadding: tileDecoration?.contentPadding,
                        mouseCursor: tileDecoration?.mouseCursor,
                        focusColor: tileDecoration?.focusColor,
                        hoverColor: tileDecoration?.hoverColor,
                        tileColor: tileDecoration?.tileColor,
                        selectedTileColor: tileDecoration?.selectedTileColor,
                        horizontalTitleGap: tileDecoration?.horizontalTitleGap,
                        minVerticalPadding: tileDecoration?.minVerticalPadding,
                        minLeadingWidth: tileDecoration?.minLeadingWidth,
                      ),
                    ),
                  ),
                ),
                if (state.hasError)
                  (errorWidgetBuilder == null)
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            state.errorText ?? defaultSubmitErrorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        )
                      : errorWidgetBuilder(state.context)
                else
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(''),
                  ),
              ],
            );
          },
        );

  ValueChanged<RadioGroupData<T>>? onChanged;
}

class RadioGroupData<T> {
  RadioGroupData({required this.itemsList, this.selectedItem})
      : assert(
            itemsList.every(
              (element1) =>
                  itemsList.where((element2) => element1 == element2).length ==
                  1,
            ),
            'Elements in RadioGroup must be unique'),
        assert(itemsList.isNotEmpty,
            'RadioGroup must contain at least one element');

  final List<T> itemsList;
  T? selectedItem;

  bool get isValid => selectedItem != null;
}

class RadioDecoration {
  RadioDecoration({
    this.mouseCursor,
    this.toggleable = false,
    this.activeColor,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize,
    this.visualDensity,
  });

  MouseCursor? mouseCursor;
  bool toggleable;
  Color? activeColor;
  MaterialStateProperty<Color?>? fillColor;
  Color? focusColor;
  Color? hoverColor;
  MaterialStateProperty<Color?>? overlayColor;
  double? splashRadius;
  MaterialTapTargetSize? materialTapTargetSize;
  VisualDensity? visualDensity;
}

class TileDecoration {
  TileDecoration({
    this.dense,
    this.visualDensity,
    this.shape,
    this.selectedColor,
    this.textColor,
    this.style,
    this.contentPadding,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.tileColor,
    this.selectedTileColor,
    this.horizontalTitleGap,
    this.minVerticalPadding,
    this.minLeadingWidth,
  });

  final bool? dense;
  final VisualDensity? visualDensity;
  final ShapeBorder? shape;
  final Color? selectedColor;
  final Color? textColor;
  final ListTileStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final MouseCursor? mouseCursor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? tileColor;
  final Color? selectedTileColor;
  final double? horizontalTitleGap;
  final double? minVerticalPadding;
  final double? minLeadingWidth;
}
