import 'package:bookly/core/widgets/custom_error_widget.dart';
import 'package:bookly/core/widgets/custom_loading_indicator.dart';
import 'package:bookly/features/home/presentation/views/widgets/newest_books_list_view_item.dart';
import 'package:bookly/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          if (state.books.isEmpty) {
            return const Center(
              child: Text(
                'No books found. Try a different search term.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: state.books.length,
            itemBuilder: (context, index) {
              final book = state.books[index];
              if (book.volumeInfo.title != null && 
                  book.volumeInfo.authors != null && 
                  book.volumeInfo.authors!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: BookListViewItem(book: book),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        } else if (state is SearchFailure) {
          return CustomErrorWidget(errorMessage: state.errorMessage);
        } else if (state is SearchLoading) {
          return const CustomLoadingIndicator();
        } else {
          return const Center(
            child: Text(
              'Start searching for books!',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
      },
    );
  }
}
