import 'package:equatable/equatable.dart';

abstract class HomeStates extends Equatable {
  const HomeStates();

  @override
  List<Object> get props => [];
}

class Loading extends HomeStates {
  const Loading() : super();
}

class LoadDataSuccess extends HomeStates {
  final dynamic data;

  const LoadDataSuccess(this.data) : super();

  @override
  List<Object> get props => data;
}

class LoadDataFail extends HomeStates {
  final dynamic error;

  const LoadDataFail(this.error) : super();

  @override
  List<Object> get props => error;
}
