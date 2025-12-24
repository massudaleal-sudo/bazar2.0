import 'package:flutter/material.dart';
import '../pages/vendedor/registrar_venda_page.dart';

class AppRoutes {
  static const venda = '/venda';

  static Map<String, WidgetBuilder> routes = {
    venda: (context) => const RegistrarVendaPage(),
  };
}
