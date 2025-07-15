import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ApiService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> fetchAPIData(String documentId) async {
    try {
      DocumentSnapshot document =
          await _firestore.collection('api').doc(documentId).get();

      if (document.exists) {
        return document.data() as Map<String, dynamic>;
      } else {
        throw Exception("Document not found");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}

class ApiController extends GetxController {
  final ApiService _apiService = ApiService();

  var backendAPI = "".obs;
  var backendApiKey = "".obs;
  var webSocket = "".obs;

  @override
  void onInit() {
    super.onInit();
    fetchAPIData().then((_) {
      print("API data loaded: ${backendAPI.value}");
    });
  }

  Future<void> fetchAPIData() async {
    const String documentId = 'IYUfKn86VPtOn6LIdCEy';
    try {
      final data = await _apiService.fetchAPIData(documentId);
      backendAPI.value = data['backend'] ?? "Not Available";
      backendApiKey.value = data['backendApiKey'] ?? "Not Available";
      webSocket.value = data['webSocket'] ?? "Not Available";
    } catch (e) {
      print("Error fetching API data: $e");
    }
  }
}
