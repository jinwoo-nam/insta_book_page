import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/presentation/home/components/book_data_widget.dart';
import 'package:flutter_google_sheet_test/presentation/home/components/book_intro_widget.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIndex = 11;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final length = max(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    const double mainPageHeight = 500;

    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 1200,
          child: Row(
            children: [
              Image.asset(
                'img/logo_InstaBooks_wh.png',
                color: Colors.black,
                height: 20,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                if (state.imageUrl.isNotEmpty)
                  Center(
                    child: Image.asset(
                      state.imageUrl,
                      width: length,
                      height: mainPageHeight,
                      fit: BoxFit.fill,
                    ),
                  ),
                ConstrainedBox(
                  constraints: BoxConstraints.tight(
                    Size(
                      length,
                      mainPageHeight,
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 400,
                  child: Center(
                    child: Text(
                      state.curBookInfo != null ? state.curBookInfo!.main : '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (state.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            if (!state.isLoading)
              SizedBox(
                width: 800,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 70,
                          child: DropdownSearch(
                            items: const [11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1],
                            selectedItem: curIndex,
                            menuHeight: 200,
                            onChanged: (val) {
                              int index = int.parse(val.toString());
                              viewModel.pageChange(index);
                              curIndex = index;
                            },
                            dropdownSearchTextAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      BookIntroWidget(bookIntro: state.curBookInfo),
                      const SizedBox(
                        height: 40,
                      ),
                      ...state.curBookData.map((e) {
                        return BookDataWidget(
                          data: e,
                        );
                      }).toList(),
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
