List<T> shuffle<T>(List<T> list) {
  if (list == null) return [];
  List<T> newList = [];
  List<int> intList = [];
  for (int i = 0; i < list.length; i++) intList.add(i);
  intList.shuffle();
  for (int i = 0; i < list.length; i++) newList.add(list[intList[i]]);
  return newList;
}
