import 'package:minor_digital/controllers/regeister_controller.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> routeMultiProvider() {
  return [
    ChangeNotifierProvider(create: (_) => RegisterController()),
  ];
}
