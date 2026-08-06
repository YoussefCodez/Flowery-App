import 'package:bloc/bloc.dart';
import 'package:flowery/featuers/home/domain/home_enitiy/home_entity.dart';
import 'package:flowery/featuers/home/presentation/view_model/state_event.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../domain/home_use_case/get_home_data_use_case.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel(this._getHomeDataUseCase) : super(const HomeState());

  final GetHomeDataUseCase _getHomeDataUseCase;

  Future<void> loadHomeData() async {
    emit(state.copyWith(
      isLoading: true,
      categoryState: const BaseState.loading(),
      bestSellerState: const BaseState.loading(),
      occasionState: const BaseState.loading(),
    ));

    final response = await _getHomeDataUseCase();
    switch (response) {
      case Success<HomeEntity>():
        emit(state.copyWith(
          categoryState: BaseState.success(response.data?.categories),
          bestSellerState: BaseState.success(response.data?.bestSeller),
          occasionState: BaseState.success(response.data?.occasions),
        ));
        break;
      case Error<HomeEntity>(:final exception):
        emit(state.copyWith(
          categoryState: BaseState.error(exception),
          bestSellerState: BaseState.error(exception),
          occasionState: BaseState.error(exception),
        ));
        break;
    }

    emit(state.copyWith(isLoading: false));
  }
}
