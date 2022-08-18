import 'package:flutter_google_sheet_test/domain/model/book_data/book_data.dart';
import 'package:flutter_google_sheet_test/domain/model/book_intro/book_intro.dart';
import 'package:gsheets/gsheets.dart';

class BookSheetsApi {
  static const String _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheet-359708",
  "private_key_id": "99410497df89515bd163acf71bdedd5866320927",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCingNx8q1+Rcr9\n/FGwLNGQruvORGwylUQcDV1w8o8xIGKOBTFIyySk+2brK1qDzTUtwZXXcFjWjdM8\nbTJKBHEkEDP0yXl/rvuS3ERLIugXV64ZBzRFWgYEc9TVLdv6/S4+DdIg/k6w8X6n\n5IF32ujJk+mZzLrfgaL8ZEoxNE2ltG1Gsq6p6zJqVVmwE6wvAdGestSz8ijIl9HE\nTB0lOB+qspoF59KBLTtxIqLTHO4D8MMLBhUVFb/bSQZY3ToUdy2RtXnOhyejr1us\nO6ZOMq61S/f4eY0gDLdBy8cgw7tjJ84TA77zvVgmRjRbj5lvDVbjg5SzcFHAjTSu\nXLRCzUrlAgMBAAECggEACikzb+hI/O3hfDNK62YxhgfYBiByXkrDYblYEFmnptsu\nLU+Xv8Opu4FV8fXYhwnIe95vvXFwq59bBpiQHt3eL/GvPWllZRwK7idDQSqiM+sv\nnrK7imXQoHCYaOWfrDQrsobsjVE2m4nLbzQw/ss35niOjSSkvJh+FaUymZZ6D5N4\nBLJQU5jj2ae8Sdbg1aj+28ix0Zd0gG4nzFSMTv5/iBAOaf+QKTxzDe7mcTFUsY6P\nA72wSAlmgsGIvNek4ZA3ouXC3M0Ln6K54UjPp6Ia9woqVCAUV9Vlk2jRkrCpGClH\nxyftSzTWe7rJi4cINbbd40T/QS9d4JI+RiC/ZWhKtQKBgQDWmaopZe7Zcz3d/RXN\neUANAMJdvbj0jVHijBfUUQS9EicVyUzcGKnw3bgYBj2ksp+SxhueHMBlqEEa/GYq\nS6AAtA+UkC4tX63ZBPsWb80fV+YdZ3f8Hwz+RpX+vTa1dsi2vIzZ0g/G88lLGUW9\n+8voiPUNq8ysSQVgJYndpQi53wKBgQDB/Rg14HKpM2HhQCQGT54aFs8rPOk9vbOS\naqHldVCMAii2bt54E9Q6/FHTP+ob0EUWXoDQAksQy/DCA9tqezC/RPX+Fuf8aT4+\nMs45sead2/uuCZKSknz6QmPrjZvqTX8qUKtBNUywG1cigNSIUh4ig6Lv60fuvRpA\nKZyK1o0buwKBgBSvWRyGa8BgAE2ecHSOxGK8eP+qIuLHoGXy1PUtHgTPdB8AeT0Z\nz3+dD3qZV2XBpeny2ISkBtOFpUjhnUNkaLbIpFvQjfLnrw0lEsK14hKsWUzqRUFz\nCMCVsy2LtXNGUNB0WitAuS6XHwbzF6rZU21FjkFUFvVgUHlVBPXtS2sHAoGAfusW\ncfl9S1KA0ZzjdPWWXT9bH9DkUS7SVBNMBRJyNogbFvEGwM1IZ6c56drBUp069l2y\nLWWyszSbOnTHk60xwZJe13UpJq28uXkIEBti5RlOWxmMOjV5a0sQkMa/odY+QvMw\neKNknzvkEID1jJMdgDtb2Vi4YWx7xkrzTqr8+40CgYBf1B2M+4nVL47Cnoehw7k0\nw6Ja3O4w6954GMpGdCVJGFSuQV/br7RIbvHmEjBLLOo29eR+Mj81AlqAg/ky0Cfj\niY5KoiSbkgOszVqBvrfWspoVq1zoUsxn8zB3PJS3Eg04vPyP19oNwK1R6CQMG/Bd\nnfn9C1v0+qBlyxE6UHg68w==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheet-359708.iam.gserviceaccount.com",
  "client_id": "103955355096935848868",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheet-359708.iam.gserviceaccount.com"
}
''';
  final _spreadSheetId = '1q23lpmVSB1aJ25GWaneramV8HxqcxeRMxSZ_ZGKUy2s';
  final _gSheets = GSheets(_credentials);
  static Worksheet? _introSheet;
  Worksheet? _bookSheet;

  Future<void> init() async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
      _introSheet = await _getWorkSheet(spreadsheet, title: 'INTRO');
    } catch (e) {
      print('Init error $e');
    }
  }

  Future<void> initPage(String page) async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(_spreadSheetId);
      _bookSheet = await _getWorkSheet(spreadsheet, title: page);
    } catch (e) {
      print('Init error $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  Future<List<BookIntro>> getIntroAll() async {
    if (_introSheet == null) return <BookIntro>[];
    final users = await _introSheet!.values.map.allColumns();
    return users == null
        ? <BookIntro>[]
        : users.map(BookIntro.fromJson).toList();
  }

  Future<List<BookData>> getBookData() async {
    if (_bookSheet == null) return <BookData>[];
    final book = await _bookSheet!.values.map.allRows();
    return book == null ? <BookData>[] : book.map(BookData.fromJson).toList();
  }
}
