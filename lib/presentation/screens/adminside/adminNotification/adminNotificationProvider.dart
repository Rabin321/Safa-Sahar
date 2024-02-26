import 'package:finalyear/presentation/screens/adminside/adminNotification/adminNotificationModel.dart';
import 'package:flutter/material.dart';


/// A provider class for the AdminNotificationpagePage.
///
/// This provider manages the state of the AdminNotificationpagePage, including the
/// current adminNotificationpageModelObj
class AdminNotificationpageProvider extends ChangeNotifier {
  TextEditingController wardController = TextEditingController();

  TextEditingController streetController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  TextEditingController typeHereController = TextEditingController();

  AdminNotificationpageModel adminNotificationpageModelObj =
      AdminNotificationpageModel();

  @override
  void dispose() {
    super.dispose();
    wardController.dispose();
    streetController.dispose();
    timeController.dispose();
    typeHereController.dispose();
  }

  onSelected(dynamic value) {
    for (var element in adminNotificationpageModelObj.dropdownItemList) {
      element.isSelected = false;
      if (element.id == value.id) {
        element.isSelected = true;
      }
    }
    notifyListeners();
  }
}
