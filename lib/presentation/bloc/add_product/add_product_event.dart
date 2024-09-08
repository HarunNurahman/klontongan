part of 'add_product_bloc.dart';

sealed class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddNewProductEvent extends AddProductEvent {
  final ProductModel product;
  const AddNewProductEvent(this.product);

  @override
  List<Object> get props => [product];
}
