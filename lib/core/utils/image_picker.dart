import 'package:image_picker/image_picker.dart';

Future<XFile?> imagePicker() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return selectedImage;
}
