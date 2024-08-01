import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

class ProjectFunctionalites {
  Future<String?> pickImageWeb() async {
    final completer = Completer<String?>();

    final input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.onChange.listen((e) async {
      final files = input.files;
      if (files!.isEmpty) {
        completer.complete(null);
        return;
      }
      final reader = html.FileReader();
      reader.onLoadEnd.listen((e) {
        final base64String = reader.result as String?;
        if (base64String != null) {
          final base64Data = base64String.split(',').last; // Extract only base64 part
          completer.complete(base64Data);
        } else {
          completer.complete(null);
        }
      });
      reader.readAsDataUrl(files[0]);
    });

    input.click();
    return completer.future;
  }
}
