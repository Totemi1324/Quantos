import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationService extends Cubit<int> {
  final int numPages;

  NavigationService(this.numPages) : super(0);

  void navigateToPage(int index) {
    if (index < numPages) {
      emit(index);
    }
  }
}
