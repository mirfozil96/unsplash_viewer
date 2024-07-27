import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

import "../data/entity/get_all_image_model.dart";
import "../data/repository/main_repo.dart";

class MainVm with ChangeNotifier {
  MainVm() {
    scrollController.addListener(getScrollEnd);
  }
  List<GetAllImageModel> allImages = <GetAllImageModel>[];
  ScrollController scrollController = ScrollController();
  int page = 0;
  bool isLoading = false;

  Future<void> getScrollEnd() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      isLoading = true;
      notifyListeners();
      await getData();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getData() async {
    final List<GetAllImageModel> newImages =
        await MainRepo().getAllImages(page: page) ?? <GetAllImageModel>[];
    allImages.addAll(newImages);
    page++;
  }

  @override
  void dispose() {
    scrollController.removeListener(getScrollEnd);
    scrollController.dispose();
    super.dispose();
  }
}
