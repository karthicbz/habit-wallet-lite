import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'navigation_index_provider.g.dart';

@riverpod
class NavigationIndexNotifier extends _$NavigationIndexNotifier{
  @override
  int build(){
    return 0;
  }

  void updateIndex(int index){
    state = index;
  }
}