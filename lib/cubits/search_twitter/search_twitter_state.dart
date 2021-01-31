part of 'search_twitter_cubit.dart';

abstract class SearchTwitterState extends Equatable {
  const SearchTwitterState();

  @override
  List<Object> get props => [];
}

class SearchTwitterInitial extends SearchTwitterState {}

class SearchTwitterLoading extends SearchTwitterState {}

class SearchTwitterLoaded extends SearchTwitterState {
  final List<TwitterProfile> results;
  const SearchTwitterLoaded(this.results) : super();

  @override
  List<Object> get props => [results];
}
