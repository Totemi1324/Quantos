import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

enum AgeClass {
  pupil,
  student,
  adult,
  elder,
}

Map<AgeClass, String> stringForAgeClass = {
  AgeClass.pupil: "15-18",
  AgeClass.student: "19-28",
  AgeClass.adult: "29-59",
  AgeClass.elder: "60+",
};

Map<int, AgeClass> ageClassForDivision = {
  0: AgeClass.pupil,
  1: AgeClass.student,
  2: AgeClass.adult,
  3: AgeClass.elder,
};

class AgeSelectForm extends StatefulWidget {
  const AgeSelectForm({super.key});

  @override
  State<AgeSelectForm> createState() => _AgeSelectFormState();
}

class _AgeSelectFormState extends State<AgeSelectForm> {
  double _selectedAge = 1;
  AgeClass? _selectedAgeClass = AgeClass.student;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 300,
            maxHeight: 400,
          ),
          child: const RiveAnimation.asset(
            'assets/animations/age_selection.riv',
            fit: BoxFit.fitWidth,
            stateMachines: ['AgeClasses'],
          ),
        ),
        Text(
          stringForAgeClass[_selectedAgeClass] ?? "NaN",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        SliderTheme(
          data: SliderThemeData.fromPrimaryColors(
            primaryColor: Theme.of(context).colorScheme.secondary,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.black,
            valueIndicatorTextStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          child: Slider(
            value: _selectedAge,
            divisions: 3,
            min: 0,
            max: 3,
            onChanged: (double value) {
              setState(() {
                _selectedAge = value;
                _selectedAgeClass = ageClassForDivision[value.round()];
              });
            },
          ),
        ),
      ],
    );
  }
}
