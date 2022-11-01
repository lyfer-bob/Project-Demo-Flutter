// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';
// import 'package:/screen/AboutUs/provider/globalURL_provider.dart';
// import 'package:provider/provider.dart';

// class ShowPDF extends StatefulWidget {
//   const ShowPDF({Key? key}) : super(key: key);

//   @override
//   _ShowPDFState createState() => _ShowPDFState();
// }

// class _ShowPDFState extends State<ShowPDF> {
//   bool _isLoading = true;

//   late PDFDocument document;

//   String? pdfURL;
//   @override
//   void initState() {
//     super.initState();
//     loadDocument();
//   }

//   loadDocument() async {
//     pdfURL =
//         await Provider.of<GlobalURLProvider>(context, listen: false).urlPolicy;
//     document = await PDFDocument.fromURL(pdfURL!);

//     setState(() => _isLoading = false);
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Client App Policy'),
//       ),
//       body: Center(
//           child: _isLoading
//               ? Center(child: CircularProgressIndicator())
//               : PDFViewer(document: document)),
//     );
//   }
// }
