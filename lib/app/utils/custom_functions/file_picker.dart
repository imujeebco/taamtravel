// // ignore_for_file: avoid_print

// import 'package:file_picker/file_picker.dart';
// // file picker from local storage
// class PickFiles {
//   pickfile(files) async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.any);
//     if (result != null) {
//       if (files != null) {
//         for (var i = 0; i < result.files.length; i++) {
//           List<String> charactersToReplace = ["&", "\$", "+", ",", ":", ";", "=", "?", "@", "#", " ", "<", ">", "[", "]", "{", "}", "|", "^", "%"];
//           String pattern = "[${charactersToReplace.map((char) => RegExp.escape(char)).join()}]";
//           RegExp unsafeCharactersPattern = RegExp(pattern);

//           var safename = result.files[i].name.replaceAll(unsafeCharactersPattern, '_');

//           files.add(<String, dynamic>{
//             'name': safename,
//             'path': result.files[i].path,
//           });
//         }
//       } else {
//         files = result.files;
//       }

//       return files;
//     }
//   }
// }
