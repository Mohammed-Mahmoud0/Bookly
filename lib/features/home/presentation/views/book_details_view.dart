import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/home/presentation/manager/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_detail_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({
    super.key, 
    required this.book, 
  });

  final BookModel book;

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    super.initState();
    String query = widget.book.volumeInfo.categories?.first ?? 'programming';
    BlocProvider.of<SimilarBooksCubit>(
      context,
      listen: false,
    ).fetchSimilarBooks(query: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BookDetailViewBody(book: widget.book));
  }
}
