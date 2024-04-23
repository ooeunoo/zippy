import 'package:zippy/domain/model/item.dart';
import 'package:zippy/domain/model/user_channel.dart';
import 'package:zippy/domain/repositories/interfaces/item_repository.dart';

class SubscribeItems {
  final ItemRepository repo;

  SubscribeItems(this.repo);

  Stream<List<Item>> execute(List<UserChannel> channels) {
    return repo.subscribeItems(channels);
  }
}
