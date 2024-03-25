// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:finalyear/components/constants.dart';

import 'package:finalyear/presentation/screens/admin_main/adminside/addstaff/ui/staffform.dart';
import 'package:finalyear/presentation/screens/signup/widgets/methods.dart';

import 'package:finalyear/widgets/appBarWithDrawer/user_appbarWithDrawer.dart';
import 'package:finalyear/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:http/http.dart' as http;

class UserReportPage extends StatefulWidget {
  const UserReportPage({super.key});

  @override
  State<UserReportPage> createState() => _UserReportPageState();
}

class _UserReportPageState extends State<UserReportPage> {
  // List<AddStaff> addstaff = []; // Define addstaff list here

  TextEditingController locationController = TextEditingController();
  TextEditingController wardnoController = TextEditingController();
  TextEditingController filterWardController = TextEditingController();
  TextEditingController reportdetailsCOntroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeydrpdwn = GlobalKey<FormState>();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Map<String, String>> staffList = []; // Store staff details acc to ward

  int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshStaffMembers() async {}
  final imagePicker = ImagePicker();
  XFile? pickedImage;

  pickImage() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        this.pickedImage = pickedImage;
      });
    } else {
      print("no images selected");
    }
  }

  // Future<void> uploadImages() async {
  //   if (pickedImage != null) {
  //     try {
  //       String downloadUrl = await postImages(pickedImage);
  //       setState(() {
  //         imageUrls = downloadUrl; // Update imageUrls with the download URL
  //       });
  //     } catch (e) {
  //       print('Error uploading image: $e');
  //     }
  //   }
  // }

  //   Future postImages(XFile? imageFile) async {
  //   setState(() {
  //     isUploading = true;
  //   });
  //   String? urls;
  //   Reference ref = FirebaseStorage.instance
  //       .ref()
  //       .child("userImages")
  //       .child(imageFile!.name);

  //   await ref.putData(
  //     await imageFile.readAsBytes(),
  //     SettableMetadata(contentType: "image/jpeg"),
  //   );
  //   urls = await ref.getDownloadURL();
  //   setState(() {
  //     isUploading = false;
  //     imageUrls = urls!;
  //   });
  //   return urls;
  // }
  @override
  void dispose() {
    locationController.dispose();
    wardnoController.dispose();

    super.dispose();
  }

  // Future<void> fetchStaffByWard(int ward) async {
  //   try {
  //     staffList.clear(); //yo herna parchha

  //     final response =
  //         await http.get(Uri.parse(baseUrl + getStaffByWard + '?wardno=$ward'));
  //     if (response.statusCode == 200) {
  //       print("staffbyward res");
  //       final data = jsonDecode(response.body);
  //       // Extract staff members' names, locations, and emails
  //       final List<dynamic> staffMembers = data['staffMembers'];

  //       staffMembers.forEach((staff) {
  //         final int id = staff['id'];
  //         final String name = staff['name'];
  //         final String? location = staff['location'];
  //         final String? email = staff['email'];
  //         final int? wardno = staff['wardno'];
  //         final String? phone = staff['phone'];
  //         print(
  //             'ID: $id, Name: $name, Location: $location, Email: $email, Ward: $wardno, Phone:$phone,');
  //         // Add staff details to the staff list
  //         staffList.add({
  //           'Id': id.toString(),
  //           'Name': name,
  //           'Location': location!,
  //           'Email': email!,
  //           'Ward': wardno.toString(),
  //           'Phone': phone.toString(),
  //         });
  //       });
  //       setState(() {}); // Notify that the state has changed
  //     } else {
  //       // ignore: use_build_context_synchronously
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Please try again")),
  //       );
  //       print('Failed to fetch staff members: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error fetching staff members: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please try again")),
  //     );
  //   }
  // }

//
//

//
//

  // Future<void> _refreshStaffMembersokk() async {
  //   try {
  //     await fetchStaffByWard(int.parse(filterWardController.text));
  //   } catch (error) {
  //     print('Error refreshing staff members: $error');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Failed to refresh staff members")),
  //     );
  //   }
  // }

  void _showImageDialog(XFile image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Image.file(
              File(image.path)), // Show the selected image in the dialog
        );
      },
    );
  }

  List<XFile> selectedImages = [];

  // Function to add or remove selected images
  void toggleImage(XFile image) {
    if (selectedImages.contains(image)) {
      setState(() {
        selectedImages.remove(image);
      });
    } else {
      setState(() {
        selectedImages.add(image);
      });
    }
  }

  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: UserAppBarWithDrawer(
        title: 'USER',
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshStaffMembers,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, bottom: 16.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Report",
                        style: kBodyText2.copyWith(
                          color: const Color(0xFF365307),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.h),
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(82, 183, 136, 0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Select Ward no:", style: kHeadline),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  child: MyTextField(
                                    hintText: 'Ward no...',
                                    controller: filterWardController,
                                    inputType: TextInputType.text,
                                    onDropdownPressed: () {
                                      wardno(context, filterWardController);
                                    },
                                    // formKey: formKeydrpdwn,
                                    showDropdownIcon: true,
                                    // validator: (name) => name!.isEmpty
                                    //     ? 'Please select your location'
                                    //     : null,
                                    isEditable: false,
                                    onChanged: (value) {
                                      // Update locationController when location is selected
                                      filterWardController.text = value;
                                      print(
                                          "filterwardController: ${filterWardController.text}");
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 5.h),
                          child: const Row(
                            children: [
                              Text(
                                "Report Details",
                                style: subhead,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.h, vertical: 5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(82, 183, 136, 0.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            height: 130.h,
                            width: double.maxFinite,
                            // color: const Color.fromRGBO(82, 183, 136, 0.5),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15.h, horizontal: 11.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.white,
                                ),
                                height: double.infinity,
                                child: TextField(
                                  controller: reportdetailsCOntroller,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText: 'Type here...',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(12.0),
                                        ),
                                        borderSide: BorderSide.none),
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Container for displaying the picked image
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.h, vertical: 5.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Add Photo button
                              CustomAddButton(
                                name: "Add photo or image from gallery",
                                onPressed: () async {
                                  final XFile? image = await imagePicker
                                      .pickImage(source: ImageSource.gallery);
                                  if (image != null) {
                                    toggleImage(image);
                                  } else {
                                    print("No image selected");
                                  }
                                },
                              ),
                              SizedBox(
                                  height: 10
                                      .h), // Add spacing between buttons and selected images
                              // Display selected images with cancel icon
                              Wrap(
                                children: selectedImages.map((image) {
                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          _showImageDialog(
                                              image); // Show the image in a dialog when tapped
                                        },
                                        child: Container(
                                          height: 50.h,
                                          width: 50.w,
                                          margin: EdgeInsets.only(right: 10.w),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            image: DecorationImage(
                                              image:
                                                  FileImage(File(image.path)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            toggleImage(image);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.black,
                                              size: 18.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),

                        CustomAddButton(
                          name: "Submit Report",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
