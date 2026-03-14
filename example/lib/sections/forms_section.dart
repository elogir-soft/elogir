import 'package:flutter/widgets.dart';
import 'package:elogir_ui/elogir_ui.dart';

class FormsSection extends StatefulWidget {
  const FormsSection({super.key});

  @override
  State<FormsSection> createState() => _FormsSectionState();
}

class _FormsSectionState extends State<FormsSection> {
  bool _checkboxValue = false;
  String _selectedSegment = 'all';
  String? _selectedFruit;
  double _sliderValue = 0.4;
  String? _selectedDropdown;
  Set<String> _selectedMulti = {};
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  Set<DateTime> _multiDates = {};

  @override
  Widget build(BuildContext context) {
    final theme = ElogirTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElogirDivider(label: ElogirText('Forms')),
        SizedBox(height: theme.spacing.md),
        ElogirTextField(
          label: 'Email address',
          hint: 'you@example.com',
          helperText: "We'll never share your email.",
        ),
        SizedBox(height: theme.spacing.md),
        ElogirTextField(
          label: 'Password',
          obscureText: true,
          errorText: 'Password must be at least 8 characters',
        ),
        SizedBox(height: theme.spacing.md),
        Row(
          children: [
            ElogirCheckbox(
              value: _checkboxValue,
              onChanged: (v) => setState(() => _checkboxValue = v),
              label: ElogirText('Accept terms'),
            ),
          ],
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Segmented Control')),
        SizedBox(height: theme.spacing.md),
        ElogirSegmentedControl<String>(
          segments: const [
            ElogirSegment(value: 'all', label: 'All'),
            ElogirSegment(value: 'active', label: 'Active'),
            ElogirSegment(value: 'archived', label: 'Archived'),
          ],
          selected: _selectedSegment,
          onChanged: (v) => setState(() => _selectedSegment = v),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Search')),
        SizedBox(height: theme.spacing.md),
        ElogirSearchField(
          hint: 'Search components…',
          onChanged: (v) {},
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Radio Group')),
        SizedBox(height: theme.spacing.md),
        ElogirRadioGroup<String>(
          options: const [
            ElogirRadioOption(value: 'apple', label: Text('Apple')),
            ElogirRadioOption(value: 'banana', label: Text('Banana')),
            ElogirRadioOption(value: 'cherry', label: Text('Cherry')),
          ],
          value: _selectedFruit,
          onChanged: (v) => setState(() => _selectedFruit = v),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Slider')),
        SizedBox(height: theme.spacing.md),
        ElogirSlider(
          value: _sliderValue,
          onChanged: (v) => setState(() => _sliderValue = v),
          label: (v) => '${(v * 100).round()}%',
        ),
        SizedBox(height: theme.spacing.md),
        ElogirSlider(
          value: _sliderValue,
          onChanged: (v) => setState(() => _sliderValue = v),
          min: 0,
          max: 10,
          divisions: 10,
          label: (v) => v.round().toString(),
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Date Picker')),
        SizedBox(height: theme.spacing.md),
        ElogirText('Single', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirDatePicker(
          value: _selectedDate,
          onChanged: (date) => setState(() => _selectedDate = date),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030, 12, 31),
          width: 220,
        ),
        SizedBox(height: theme.spacing.md),
        ElogirText('Range', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirDatePicker(
          selectionMode: ElogirDateSelectionMode.range,
          rangeStart: _rangeStart,
          rangeEnd: _rangeEnd,
          onRangeChanged: (s, e) => setState(() {
            _rangeStart = s;
            _rangeEnd = e;
          }),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030, 12, 31),
          width: 280,
        ),
        SizedBox(height: theme.spacing.md),
        ElogirText('Multiple', variant: ElogirTextVariant.labelSmall),
        SizedBox(height: theme.spacing.xs),
        ElogirDatePicker(
          selectionMode: ElogirDateSelectionMode.multiple,
          selectedDates: _multiDates,
          onMultiChanged: (dates) =>
              setState(() => _multiDates = dates),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030, 12, 31),
          width: 260,
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Dropdown')),
        SizedBox(height: theme.spacing.md),
        ElogirDropdown<String>(
          options: const [
            ElogirDropdownOption(value: 'flutter', label: 'Flutter'),
            ElogirDropdownOption(value: 'react', label: 'React Native'),
            ElogirDropdownOption(value: 'swift', label: 'SwiftUI'),
            ElogirDropdownOption(value: 'kotlin', label: 'Jetpack Compose'),
          ],
          value: _selectedDropdown,
          placeholder: 'Select a framework…',
          onChanged: (v) => setState(() => _selectedDropdown = v),
          width: 260,
        ),

        SizedBox(height: theme.spacing.xl),
        ElogirDivider(label: ElogirText('Multi Dropdown')),
        SizedBox(height: theme.spacing.md),
        ElogirMultiDropdown<String>(
          options: const [
            ElogirMultiDropdownOption(value: 'dart', label: 'Dart'),
            ElogirMultiDropdownOption(value: 'kotlin', label: 'Kotlin'),
            ElogirMultiDropdownOption(value: 'swift', label: 'Swift'),
            ElogirMultiDropdownOption(value: 'rust', label: 'Rust'),
            ElogirMultiDropdownOption(value: 'go', label: 'Go'),
            ElogirMultiDropdownOption(value: 'ts', label: 'TypeScript'),
          ],
          values: _selectedMulti,
          placeholder: 'Select languages…',
          onChanged: (v) => setState(() => _selectedMulti = v),
          width: 260,
        ),
      ],
    );
  }
}
