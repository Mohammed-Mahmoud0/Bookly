import 'package:bookly/core/widgets/custom_button.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksAction extends StatelessWidget {
  const BooksAction({super.key, required this.book});

  final BookModel book;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              text: 'Download',
              onPressed: () async {
                Uri uri = Uri.parse(getPdfOrWebLink(book)!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Expanded(
            child: CustomButton(
              onPressed: () async {
                Uri uri = Uri.parse(book.volumeInfo.previewLink!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              text: 'Free Preview',
              fontSize: 16,
              backgroundColor: Colors.grey[800] ?? Colors.grey,
              textColor: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? getPdfOrWebLink(BookModel book) {
    if (book.accessInfo?.pdf?.isAvailable == true &&
        book.accessInfo?.pdf?.acsTokenLink != null) {
      return book.accessInfo!.pdf!.acsTokenLink;
    }

    if (book.accessInfo?.webReaderLink != null) {
      return book.accessInfo!.webReaderLink;
    }

    return 'https://www.google.com';
  }
}
