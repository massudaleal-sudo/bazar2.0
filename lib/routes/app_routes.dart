import 'package:flutter/material.dart';
import 'package:bazar_app/pages/vendedor/registrar_venda_page.dart';
import 'package:bazar_app/pages/vendedor/admin/admin_home_page.dart';

class AppRoutes {
  static const adminHome = '/admin';
  static const registrarVenda = '/registrar-venda';

  static Map<String, WidgetBuilder> get routes => {
         adminHome: (_) => const AdminHomePage(),
         registrarVenda: (_) => const RegistrarVendaPage(),
      };
}
