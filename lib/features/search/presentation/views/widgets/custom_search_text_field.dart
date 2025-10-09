import 'package:bookly/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();
    return TextField(
      controller: textController,
      onChanged: (value) {
        if (value.isEmpty) {
          BlocProvider.of<SearchCubit>(context).searchBooks(query: '');
          return;
        }
        BlocProvider.of<SearchCubit>(context).searchBooks(query: value);
      },
      decoration: InputDecoration(
        hintText: 'Search for books',
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        suffixIcon: IconButton(
            onPressed: () {
            
            BlocProvider.of<SearchCubit>(context).searchBooks(query: textController.text);
          },
          icon: Opacity(
            opacity: 0.8,
            child: const Icon(FontAwesomeIcons.magnifyingGlass, size: 24),
          ),
        ),
      ),
      style: TextStyle(color: Colors.white),
      cursorColor: Colors.white,
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(color: Colors.white),
    );
  }
}
