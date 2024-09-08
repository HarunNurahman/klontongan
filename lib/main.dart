import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontongan/core/services/bloc_observer.dart';
import 'package:klontongan/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:klontongan/presentation/bloc/delete_product/delete_product_bloc.dart';
import 'package:klontongan/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:klontongan/presentation/bloc/product/product_bloc.dart';
import 'package:klontongan/presentation/pages/dashboard/dashboard_page.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc()..add(FetchProduct()),
        ),
        BlocProvider(
          create: (context) => AddProductBloc(),
        ),
        BlocProvider(
          create: (context) => EditProductBloc(),
        ),
        BlocProvider(
          create: (context) => DeleteProductBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardPage(),
      ),
    );
  }
}
