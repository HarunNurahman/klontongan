part of 'delete_product_bloc.dart';

sealed class DeleteProductState extends Equatable {
  const DeleteProductState();

  @override
  List<Object> get props => [];
}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {}

final class DeleteProductFailed extends DeleteProductState {
  final String errorMessage;
  const DeleteProductFailed(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
