import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klontongan/core/services/product/delete-product_service.dart';

part 'delete_product_event.dart';
part 'delete_product_state.dart';

class DeleteProductBloc extends Bloc<DeleteProductEvent, DeleteProductState> {
  DeleteProductBloc() : super(DeleteProductInitial()) {
    on<DeleteProductEvent>((event, emit) async {
      if (event is DeleteProduct) {
        try {
          emit(DeleteProductLoading());
          await DeleteProductService().deleteProduct(event.productId);
          emit(DeleteProductSuccess());
        } catch (e) {
          emit(DeleteProductFailed(e.toString()));
        }
      }
    });
  }
}
