import 'package:bookly/features/home/presentation/views/widgets/book_detail_view_body.dart';
import 'package:flutter/material.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BookDetailViewBody());
  }
}
