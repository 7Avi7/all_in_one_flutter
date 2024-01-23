import 'package:exam_test/core/enums/view_state.dart';
import 'package:exam_test/core/models/list_model.dart';
import 'package:exam_test/core/services/list_api.dart';
import 'package:exam_test/locator.dart';

import 'base_view_model.dart';

class ListViewModel extends BaseViewModel {
  final ListApi _ListApi = locator<ListApi>();
  ListModel? listModel;
  // List<ListModel> profile = [];

  Future<void> getListAPI(String token) async {
    setViewState(ViewState.busy);

    listModel = await _ListApi.getAllList(token);

    print('-----------------------------------------------');

    setViewState(ViewState.idle);
  }
}
