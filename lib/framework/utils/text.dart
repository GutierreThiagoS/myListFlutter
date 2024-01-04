

String getTitle(int index, bool isSwitch) {
  switch (index) {
    case 0:
      return isSwitch ? "Compras" : "Produtos";

/*
    case 1:
      return "Produtos";
*/

    case 1:
      return "Lembretes";

    case 2:
      return "Configurações";

  }
  return "";
}

extension IterableExtension<T> on Iterable<T> {

  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    forEach((element) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    });

    return result;
  }

}