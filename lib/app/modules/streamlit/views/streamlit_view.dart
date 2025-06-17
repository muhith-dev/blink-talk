import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/streamlit_controller.dart';

class StreamlitView extends GetView<StreamlitController> {
  const StreamlitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Streamlit'),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: controller.controller));
  }
}
