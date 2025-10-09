import 'dart:developer';

import 'package:bookly/core/errors/failures.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/search/data/repos/search_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SearchRepoImplementation implements SearchRepo {
  final ApiService apiService;

  SearchRepoImplementation(this.apiService);

  @override
  Future<Either<Failure, List<BookModel>>> searchBooks({
    required String query,
  }) async {
    try {
      var data = await apiService.searchBooks(query: query);
      List<BookModel> books = [];
      
      // Check if the response contains items
      if (data['items'] != null) {
        for (var item in data['items']) {
          try {
            books.add(BookModel.fromJson(item));
          } catch (e) {
            // Skip individual books that can't be parsed
            log('Skipping book due to parsing error: $e');
            continue;
          }
        }
      }
      
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
