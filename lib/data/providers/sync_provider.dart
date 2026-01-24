import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sync_provider.g.dart';
@riverpod
class SyncNotifier extends _$SyncNotifier {
  String syncPath = dotenv.env['SYNC_ENDPOINT']!;
  @override
  void build(){}

  Future<bool> syncTransaction()async{
    print(syncPath);
    return false;
  }
}