import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klontongan/core/services/product/edit-product_service.dart';
import 'package:klontongan/data/models/product_model.dart';

part 'edit_product_event.dart';
part 'edit_product_state.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState> {
  EditProductBloc() : super(EditProductInitial()) {
    on<EditProductEvent>((event, emit) async {
      if (event is EditProduct) {
        try {
          emit(EditProductLoading());
          final result = await EditProductService().editProduct(event.product);
          print('Result: $result');
          emit(EditProductSuccess(result));
        } catch (e) {
          emit(EditProductFailed(e.toString()));
        }
      }
    });
  }
}
