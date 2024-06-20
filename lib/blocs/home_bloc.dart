

import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/graphql_service.dart';
import 'home_events.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  late GraphQLService service;

  HomeBloc() : super(const Loading()) {
    service = GraphQLService();

    on<FetchHomeData>((event,emit) => mapFetchHomeDataToStates(event,emit));
  }
  mapFetchHomeDataToStates(FetchHomeData event,Emitter emit) async {
    final query = event.query;
    final variables = event.variables ?? {};
    try {
      final result = await service.performMutation(query, variables: variables);
      if (result.hasException) {
        emit(LoadDataFail(result.exception?.graphqlErrors[0]));
      } else {
        emit(LoadDataSuccess(result.data));
      }
    } catch (e) {
      emit(LoadDataFail(e.toString()));
    }
  }
}
