import 'package:flutter/widgets.dart';
import 'package:flutter_utils/main.dart';

abstract class CommonStageStateful<T extends StatefulWidget> extends State<T> {
  bool isLoaded = false;
  final List<String> errorMessages = List<String>.empty(growable: true);
  final scrollController = ScrollController();
  late int currentPage;
  late bool reachedPageEnd;

  getErrors() => errorMessages;

  hasErrors() => errorMessages.isNotEmpty;

  clearErrors() => errorMessages.clear();

  Widget showErrors() {
    // toastError(_errorMessages.join('\r\n'));
    return Center(
      child: ListView.builder(
        itemCount: errorMessages.length,
        itemBuilder: (context, index) {
          return Text(errorMessages[index]);
        },
      ),
    );
  }

  addError(String errorMessage) => errorMessages.add(errorMessage);

  loadPage() => setState(() => isLoaded = true);

  unloadPage() => setState(() => isLoaded = false);

  isPageLoaded() => mounted && isLoaded;

  reloadPage() {
    unloadPage();
    loadPage();
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    destroy();
  }

  init() {}

  destroy() {}

  bool validateScrollPosition() {
    if (scrollController.positions.isNotEmpty) {
      // addDebug('pixels ${scrollController.position.pixels} == maxScrollExtent ${scrollController.position.maxScrollExtent}');
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        return true;
      }
    }
    return false;
  }

  void checkAndLoadPostFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (validateViewportPosition()) {
        checkAndLoadNextPage();
      }
    });
  }

  bool validateViewportPosition() {
    if (scrollController.positions.isNotEmpty) {
      if (scrollController.position.viewportDimension >= scrollController.position.maxScrollExtent) {
        // addDebug('viewportDimension ${scrollController.position.viewportDimension} >= maxScrollExtent ${scrollController.position.maxScrollExtent}');
        return true;
      }
    }
    return false;
  }

  Future<void> checkAndLoadNextPage() async {
    if (reachedPageEnd) {
    } else if (validateScrollPosition()) {
      loadNextPage();
    } else {
      addDebug("Skipped loading page, currently at $currentPage");
    }
    // load();
  }

  loadNextPage() {}
}
