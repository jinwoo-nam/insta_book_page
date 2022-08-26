import 'package:flutter_google_sheet_test/data/repository/firestore_repository_impl.dart';
import 'package:flutter_google_sheet_test/data/repository/sheet_repository_impl.dart';
import 'package:flutter_google_sheet_test/domain/use_case/firestore_use_case.dart';
import 'package:flutter_google_sheet_test/domain/use_case/sheet_use_case.dart';
import 'package:flutter_google_sheet_test/presentation/home/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> getProviders() {
  List<SingleChildWidget> viewModels = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        sheetUseCase: SheetUseCase(SheetRepositoryImpl()),
        firestoreUseCase: FirestoreUseCase(
          FirestoreRepositoryImpl(),
        ),
      ),
    ),
  ];
  return viewModels;
}
