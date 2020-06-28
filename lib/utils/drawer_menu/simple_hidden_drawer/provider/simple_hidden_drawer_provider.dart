import 'package:flutter/material.dart';
import 'package:shoppingapp/utils/drawer_menu/simple_hidden_drawer/bloc/simple_hidden_drawer_bloc.dart';

class SimpleHiddenDrawerProvider extends InheritedWidget {
  final SimpleHiddenDrawerBloc hiddenDrawerBloc;

  SimpleHiddenDrawerProvider({
    Key key,
    @required this.hiddenDrawerBloc,
    Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SimpleHiddenDrawerBloc of(BuildContext context) =>
      // ignore: deprecated_member_use
      (context.inheritFromWidgetOfExactType(SimpleHiddenDrawerProvider)
              as SimpleHiddenDrawerProvider)
          .hiddenDrawerBloc;
}
