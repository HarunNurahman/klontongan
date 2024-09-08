part of 'edit_product_bloc.dart';

sealed class EditProductEvent extends Equatable {
  const EditProductEvent();

  @override
  List<Object> get props => [];
}

class EditProduct extends EditProductEvent {
  final ProductModel product;
  const EditProduct(this.product);

  @override
  List<Object> get props => [product];
}
