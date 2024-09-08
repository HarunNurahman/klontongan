part of 'add_product_bloc.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {}

final class AddProductLoading extends AddProductState {}

final class AddProductSuccess extends AddProductState {
  final ProductModel product;
  const AddProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

final class AddProductFailed extends AddProductState {
  final String errorMessage;
  const AddProductFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
