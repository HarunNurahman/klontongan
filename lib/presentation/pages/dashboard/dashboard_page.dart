import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontongan/core/utils/currency_format.dart';
import 'package:klontongan/core/utils/styles.dart';
import 'package:klontongan/data/models/product_model.dart';
import 'package:klontongan/presentation/bloc/delete_product/delete_product_bloc.dart';
import 'package:klontongan/presentation/bloc/product/product_bloc.dart';
import 'package:klontongan/presentation/pages/product/add-product_page.dart';
import 'package:klontongan/presentation/widgets/custom_button.dart';
import 'package:klontongan/presentation/widgets/product_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        return context.read<ProductBloc>().add(FetchProduct());
      },
      child: Scaffold(
        appBar: appBar(),
        floatingActionButton: floatingAddButton(),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(color: blueColor),
              );
            }

            if (state is ProductError) {
              return Center(
                child: Text(state.errorMessage),
              );
            }

            if (state is ProductLoaded) {
              List<ProductModel> products = state.product;
              return ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                children: [
                  // Item shown
                  Text(
                    '${products.length} Product Shown',
                    style: grayTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 16),
                  // Product list
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    separatorBuilder: (context, index) => Divider(
                      color: grayColor,
                    ),
                    itemBuilder: (context, index) => ProductItem(
                      onTap: () => showBottomSheet(products[index]),
                      itemName: products[index].name!,
                      itemSKU: 'SKU: ${products[index].sku!}',
                      itemPrice: CurrencyFormat().formatCurrency(
                        products[index].harga!,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: whiteColor,
      title: Text(
        'Klontongan Inventory',
        style: blackTextStyle.copyWith(
          fontWeight: medium,
        ),
      ),
      elevation: 1,
    );
  }

  Widget floatingAddButton() {
    return FloatingActionButton(
      backgroundColor: blueColor,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddProductPage()),
      ),
      shape: const CircleBorder(),
      child: Icon(Icons.add, color: whiteColor),
    );
  }

  Future<dynamic> showBottomSheet(ProductModel product) {
    return showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Wrap(
            children: [
              // Item image
              product.image == null
                  ? Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: const DecorationImage(
                          image: AssetImage('assets/img_empty.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(product.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
              // Item Information
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: grayColor),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product SKU
                    itemList('SKU', product.sku!),
                    Divider(color: grayColor),
                    // Product name
                    itemList('Product Name', product.name!),
                    Divider(color: grayColor),
                    // Product description
                    itemList('Product Description', ''),
                    Text(
                      product.description!,
                      style: blackTextStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(color: grayColor),
                    // Category ID - name
                    itemList(
                      'Category',
                      '${product.categoryId} - ${product.categoryName}',
                    ),
                    Divider(color: grayColor),
                    // Product dimension
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dimension', style: grayTextStyle),
                            Text('Weight, L x W x H', style: grayTextStyle),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Value
                        Row(
                          children: [
                            const Spacer(),
                            itemList('', '${product.weight}g'),
                            itemList(' - ', '${product.length}cm'),
                            itemList(' x ', '${product.width}cm'),
                            itemList(' x ', '${product.height}cm'),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              // Item price
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: grayColor.withAlpha(50),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Product Price', style: blackTextStyle),
                    Text(
                      CurrencyFormat().formatCurrency(product.harga!),
                      style: blackTextStyle.copyWith(fontWeight: bold),
                    )
                  ],
                ),
              ),
              // Action buttons
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Edit product
                    CustomEditButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddProductPage(
                            product: product,
                          ),
                        ),
                      ),
                    ),
                    // Delete product
                    BlocListener<DeleteProductBloc, DeleteProductState>(
                      listener: (context, state) {
                        if (state is DeleteProductSuccess) {
                          setState(() {
                            context.read<ProductBloc>().add(FetchProduct());
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: blueColor,
                              content: Text(
                                'Product deleted successfully',
                                style: whiteTextStyle,
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: CustomDeleteButton(
                        onPressed: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Product'),
                              content: Text(
                                'Are you sure you want to delete this product?',
                                style: blackTextStyle,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text(
                                    'Cancel',
                                    style: blackTextStyle,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text(
                                    'Delete',
                                    style: whiteTextStyle.copyWith(
                                      color: redColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          if (shouldDelete ?? false) {
                            context
                                .read<DeleteProductBloc>()
                                .add(DeleteProduct(product.id!));
                          }
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget itemList(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: grayTextStyle,
        ),
        Text(
          value,
          style: blackTextStyle.copyWith(fontWeight: semibold),
        )
      ],
    );
  }
}
