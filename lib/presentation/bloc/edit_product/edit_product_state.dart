part of 'edit_product_bloc.dart';

sealed class EditProductState extends Equatable {
  const EditProductState();

  @override
  List<Object> get props => [];
}

final class EditProductInitial extends EditProductState {}

final class EditProductLoading extends EditProductState {}

final class EditProductSuccess extends EditProductState {
  final ProductModel product;
  const EditProductSuccess(this.product);

  @override
  List<Object> get props => [product];
}

final class EditProductFailed extends EditProductState {
  final String errorMessage;
  const EditProductFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
