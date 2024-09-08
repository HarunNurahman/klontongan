part of 'delete_product_bloc.dart';

sealed class DeleteProductEvent extends Equatable {
  const DeleteProductEvent();

  @override
  List<Object> get props => [];
}

class DeleteProduct extends DeleteProductEvent {
  final String productId;
  const DeleteProduct(this.productId);

  @override
  List<Object> get props => [productId];
}
