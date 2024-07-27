import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../../../riverpod.dart";
import "../../../../../core/api/api.dart";
import "../../../../../core/api/api_constants.dart";
import "../../vm/main_vm.dart";
import "../entity/get_all_image_model.dart";

final FutureProvider<void> mainFetchData =
    FutureProvider<void>((FutureProviderRef<Object?> ref) async {
  final MainVm getResult = ref.read(mainVM);
  return getResult.getData();
});

final class MainRepo {
  Future<List<GetAllImageModel>?> getAllImages({required int page}) async {
    final String? result = await Api.get(
      ApiConstants.apiGetAllImages,
      ApiConstants.paramsGetAllImages(page: page),
    );
    if (result != null) {
      final List<GetAllImageModel> getAllImageModel =
          getAllImageModelFromJson(result);
      return getAllImageModel;
    } else {
      return null;
    }
  }
}
