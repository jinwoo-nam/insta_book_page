import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sheet_test/presentation/footer/footer_widget.dart';
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
  final ScrollController controller = ScrollController();
  int curIndex = 11;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    context.read<HomeViewModel>().disposeData();
    super.dispose();
  }

  void init() async {
    // FirebaseFirestore.instance
    //     .collection('temp3')
    //     .doc('timestamp')
    //     .set(<String, dynamic>{
    //   'timestamp': FieldValue.serverTimestamp(),
    // });



    await context.read<HomeViewModel>().loadData();
  }

  @override
  Widget build(BuildContext context) {
    final length = max(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    const double mainPageHeight = 500;

    final viewModel = context.watch<HomeViewModel>();
    final state = viewModel.state;

    return Scaffold(
      backgroundColor: Colors.white,
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
        controller: controller,
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
                  top: 350,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        state.curBookInfo != null
                            ? state.curBookInfo!.main
                            : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14.0),
                          child: SizedBox(
                            width: 100,
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
                              dropdownSearchDecoration: const InputDecoration(
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusColor: Colors.transparent,
                                fillColor: Colors.transparent,
                              ),
                            ),
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
              ),
            if (!state.isLoading) const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
