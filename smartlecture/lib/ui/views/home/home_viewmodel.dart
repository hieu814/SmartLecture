import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<String> _listProduct = <String>[];

  List<String> get items => _listProduct;
  Future<void> more() async {
    notifyListeners();
    await fetchAndSetWorkouts();
  }

  Future<void> fetchAndSetWorkouts() async {
    notifyListeners();
  }

  Future load() async {
    _listProduct.add("bai giang 1");
    _listProduct.add("bai giang 2");
    _listProduct.add("bai giang 3");
    _listProduct.add("bai giang 4");
    _listProduct.add("bai giang 5");
    await fetchAndSetWorkouts();
  }
}
