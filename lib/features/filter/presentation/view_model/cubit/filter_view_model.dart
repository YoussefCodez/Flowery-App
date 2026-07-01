import 'package:flowery/features/filter/presentation/view_model/events/filter_events.dart';
import 'package:flowery/features/filter/presentation/view_model/state/filter_base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FilterViewModel extends Cubit<FilterBaseState> {
  FilterViewModel() : super(const FilterBaseState());

  void doEvent(FilterEvents event) {
    switch (event) {
      case UpdateSortOptionEvent():
        _updateSortOption(event);
    }
  }

  void _updateSortOption(UpdateSortOptionEvent event) {
    emit(state.copyWith(selectedSortOption: event.sortOption));
  }
}