import 'dart:io';
import 'dart:math';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klontongan/core/utils/image_picker.dart';
import 'package:klontongan/core/utils/styles.dart';
import 'package:klontongan/data/models/product_model.dart';
import 'package:klontongan/presentation/bloc/add_product/add_product_bloc.dart';
import 'package:klontongan/presentation/bloc/edit_product/edit_product_bloc.dart';
import 'package:klontongan/presentation/widgets/custom_button.dart';
import 'package:klontongan/presentation/widgets/custom_textform.dart';

class AddProductPage extends StatefulWidget {
  final ProductModel? product;
  const AddProductPage({super.key, this.product});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  // Image picker
  XFile? selectImage;
  final Cloudinary cloudinary = Cloudinary.signedConfig(
    cloudName: 'dtroaojfi',
    apiKey: '738995678963885',
    apiSecret: 'YhEpASye4basNiRLxXyf3AZA2ks',
  );
  String? imgUrl;

  // Upload image to cloudinary function
  Future<String> uploadImage() async {
    if (selectImage == null) return '';

    try {
      final response = await cloudinary.upload(
        file: selectImage!.path,
        resourceType: CloudinaryResourceType.image,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: blueColor,
          content: Text('Upload successful!', style: whiteTextStyle),
        ),
      );

      return response.secureUrl ?? '';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
      return '';
    }
  }

  // ID
  TextEditingController idController = TextEditingController(
    text: Random().nextInt(100).toString(),
  );

  // Product
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  // SKU
  TextEditingController skuController = TextEditingController();

  // Category
  TextEditingController categoryIdController = TextEditingController(
    text: Random().nextInt(100).toString(),
  );
  TextEditingController categoryNameController = TextEditingController();

  // Dimension
  TextEditingController weightController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void initState() {
    imgUrl = widget.product?.image;
    idController = TextEditingController(
      text: widget.product?.id ?? Random().nextInt(100).toString(),
    );
    productNameController = TextEditingController(
      text: widget.product?.name ?? '',
    );
    productDescriptionController = TextEditingController(
      text: widget.product?.description ?? '',
    );
    productPriceController = TextEditingController(
      text: widget.product?.harga.toString() ?? '',
    );
    skuController = TextEditingController(text: widget.product?.sku ?? '');
    categoryIdController = TextEditingController(
      text: widget.product?.categoryId.toString() ??
          Random().nextInt(100).toString(),
    );
    categoryNameController = TextEditingController(
      text: widget.product?.categoryName ?? '',
    );
    weightController = TextEditingController(
      text: widget.product?.weight.toString() ?? '',
    );
    lengthController = TextEditingController(
      text: widget.product?.length.toString() ?? '',
    );
    widthController = TextEditingController(
      text: widget.product?.width.toString() ?? '',
    );
    heightController = TextEditingController(
      text: widget.product?.height.toString() ?? '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          title: Text(
            'Add Product',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: medium,
            ),
          ),
        ),
        // Add form
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: [
              // Upload image
              GestureDetector(
                onTap: () async {
                  final image = await imagePicker();
                  setState(() {
                    selectImage = image;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(),
                    image: selectImage == null
                        ? null
                        : DecorationImage(
                            image: FileImage(File(selectImage!.path)),
                            fit: BoxFit.fitHeight,
                          ),
                  ),
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: selectImage == null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt_rounded),
                            const SizedBox(width: 8),
                            Text('Upload product image', style: blackTextStyle)
                          ],
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextForm(
                controller: idController,
                labelText: 'Product ID*',
                hintText: '',
                isEnabled: false,
              ),
              const SizedBox(height: 16),
              // Product name form
              CustomTextForm(
                controller: productNameController,
                labelText: 'Product Name*',
                keyboardType: TextInputType.text,
                hintText: 'Enter product name',
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Product description form
              CustomTextForm(
                controller: productDescriptionController,
                labelText: 'Product Description*',
                keyboardType: TextInputType.text,
                hintText: 'Enter product description',
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Product price form
              CustomTextForm(
                controller: productPriceController,
                labelText: 'Product Price*',
                keyboardType: TextInputType.number,
                hintText: 'Enter product price',
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextForm(
                controller: categoryIdController,
                labelText: 'Category ID*',
                keyboardType: TextInputType.number,
                hintText: '',
                isEnabled: false,
              ),
              const SizedBox(height: 16),
              // Product category name form
              CustomTextForm(
                controller: categoryNameController,
                labelText: 'Category Name*',
                keyboardType: TextInputType.text,
                hintText: 'Enter category name',
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Product category name form
              CustomTextForm(
                controller: skuController,
                labelText: 'SKU*',
                keyboardType: TextInputType.text,
                hintText: 'Enter SKU',
                errorMessage: _errorMessage,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter SKU';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Product dimension (weight, length, width, height) form
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Weight
                  Expanded(
                    child: CustomTextForm(
                      controller: weightController,
                      labelText: 'Weight*',
                      keyboardType: TextInputType.number,
                      hintText: 'gr',
                      errorMessage: _errorMessage,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter weight';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Length
                  Expanded(
                    child: CustomTextForm(
                      controller: lengthController,
                      labelText: 'Length*',
                      keyboardType: TextInputType.number,
                      hintText: 'cm',
                      errorMessage: _errorMessage,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter length';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Width
                  Expanded(
                    child: CustomTextForm(
                      controller: widthController,
                      labelText: 'Width*',
                      keyboardType: TextInputType.number,
                      hintText: 'cm',
                      errorMessage: _errorMessage,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter width';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Height
                  Expanded(
                    child: CustomTextForm(
                      controller: heightController,
                      labelText: 'Height*',
                      keyboardType: TextInputType.number,
                      hintText: 'cm',
                      errorMessage: _errorMessage,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter height';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Submit button
              CustomSubmitButton(
                onPressed: () async {
                  var url = await uploadImage();
                  if (widget.product == null) {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddProductBloc>().add(
                            AddNewProductEvent(
                              ProductModel(
                                id: idController.text,
                                name: productNameController.text,
                                description: productDescriptionController.text,
                                harga:
                                    double.parse(productPriceController.text),
                                categoryId:
                                    int.parse(categoryIdController.text),
                                categoryName: categoryNameController.text,
                                sku: skuController.text,
                                weight: double.parse(weightController.text),
                                length: double.parse(lengthController.text),
                                width: double.parse(widthController.text),
                                height: double.parse(heightController.text),
                                image: url.isEmpty ? '' : url,
                              ),
                            ),
                          );
                    }
                    Navigator.pop(context);
                  } else {
                    context.read<EditProductBloc>().add(
                          EditProduct(
                            ProductModel(
                              id: idController.text,
                              name: productNameController.text,
                              description: productDescriptionController.text,
                              harga: double.parse(productPriceController.text),
                              categoryId: int.parse(categoryIdController.text),
                              categoryName: categoryNameController.text,
                              sku: skuController.text,
                              weight: double.parse(weightController.text),
                              length: double.parse(lengthController.text),
                              width: double.parse(widthController.text),
                              height: double.parse(heightController.text),
                              image: url.isEmpty ? '' : url,
                            ),
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
