import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/search/data/repos/search_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepo) : super(SearchInitial());

  final SearchRepo searchRepo;

  Future<void> searchBooks({required String query}) async {
    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    var result = await searchRepo.searchBooks(query: query);
    result.fold(
      (failure) {
        emit(SearchFailure(failure.errorMessage));
      },
      (books) {
        emit(SearchSuccess(books));
      },
    );
  }
}
