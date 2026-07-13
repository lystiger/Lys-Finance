import 'package:uuid/uuid.dart';

abstract interface class UuidGenerator {
  String v4();
}

final class RandomUuidGenerator implements UuidGenerator {
  RandomUuidGenerator({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  @override
  String v4() => _uuid.v4();
}
