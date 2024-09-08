import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klontongan/core/services/product/add-product_service.dart';
import 'package:klontongan/data/models/product_model.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductInitial()) {
    on<AddProductEvent>((event, emit) async {
      if (event is AddNewProductEvent) {
        try {
          emit(AddProductLoading());
          final newProduct =
              await AddProductService().addProduct(event.product);
          emit(AddProductSuccess(newProduct));
        } catch (e) {
          emit(AddProductFailed(e.toString()));
        }
      }
    });
  }
}
