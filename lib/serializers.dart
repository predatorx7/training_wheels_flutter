import 'package:handle/handle.dart';

import 'logging.dart';

void setupHandleJsonModelSerializer() {
  logging('setupHandleJsonModelSerializer').fine('adding deserializers');
  JsonModelSerializer.common.addDeserializers({});
}
