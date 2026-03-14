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
      ],
    );
  }
}
