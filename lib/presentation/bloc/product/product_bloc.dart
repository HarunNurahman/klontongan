import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klontongan/core/services/product/product_service.dart';
import 'package:klontongan/data/models/product_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is FetchProduct) {
        try {
          emit(ProductLoading());
          final products = await ProductService().getProducts();
          emit(ProductLoaded(products));
        } catch (e) {
          emit(ProductError(e.toString()));
        }
      }
    });
  }
}
