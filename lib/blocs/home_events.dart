import 'package:equatable/equatable.dart';

abstract class HomeEvents extends Equatable {
  const HomeEvents();
  @override
  List<Object> get props => [];
}

class FetchHomeData extends HomeEvents {
  final String query;
  final Map<String, dynamic> variables;
  const FetchHomeData(this.query, {required this.variables}) : super();
  @override
  List<Object> get props => [query, variables];
}
