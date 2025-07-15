import 'package:blink_talk/shared/widgets/buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/app_menu_controller.dart';

class AppMenuView extends GetView<AppMenuController> {
  const AppMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F8),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Get.toNamed('/profile');
                    },
                    child: Container(
                        width: 375,
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(19),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 0.2))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(controller.img.value),
                                  radius: 25,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.firstName.value,
                                      style: const TextStyle(
                                        color: Color(0xff496173),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      controller.email.value,
                                      style:
                                          const TextStyle(color: Colors.grey),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: Text(
                //     "Histori penggunaan aplikasi",
                //     style: const TextStyle(color: Colors.black),
                //     textAlign: TextAlign.start,
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(16.0),
                //   child: SizedBox(
                //     height: 120,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         Column(
                //           children: [
                //             Row(
                //               children: [
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //                 Padding(
                //                   padding: const EdgeInsets.all(8.0),
                //                   child: Container(
                //                       width: 100,
                //                       height: 100,
                //                       decoration: BoxDecoration(
                //                           color: Colors.white,
                //                           borderRadius:
                //                               BorderRadius.circular(19),
                //                           boxShadow: [
                //                             BoxShadow(
                //                                 color: Colors.grey,
                //                                 spreadRadius: 1,
                //                                 blurRadius: 10,
                //                                 offset: Offset(0, 0.2))
                //                           ]),
                //                       child: Icon(Icons.access_time)),
                //                 ),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Pengaturan",
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                ),
                Center(
                    child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/edit-profile', arguments: {
                          'name': controller.firstName.value,
                          'email': controller.email.value,
                          'image': controller.img.value,
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 375,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.manage_accounts),
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Edit profil",
                                        style: const TextStyle(
                                          color: Color(0xff496173),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/user-history');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 375,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.manage_history),
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Riwayat login",
                                        style: const TextStyle(
                                          color: Color(0xff496173),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/detection-history');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 375,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.manage_history),
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Riwayat deteksi",
                                        style: const TextStyle(
                                          color: Color(0xff496173),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/edit-profile');
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 375,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.password),
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Keamanan akun",
                                        style: const TextStyle(
                                          color: Color(0xff496173),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed("/about");
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 375,
                            height: 65,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(0, 0.2))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(Icons.info),
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tentang aplikasi",
                                        style: const TextStyle(
                                          color: Color(0xff496173),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        controller.showLogoutSnackbar(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 375,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0xFFE2E5EA),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Log Out",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  )),
                            )),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
