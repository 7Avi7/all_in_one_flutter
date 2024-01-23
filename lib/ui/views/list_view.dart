import 'package:exam_test/core/enums/view_state.dart';
import 'package:exam_test/core/view_models/list_view_model.dart';
import 'package:exam_test/ui/route_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_view.dart';

class LIstView extends StatelessWidget {
  const LIstView({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseView<ListViewModel>(
      onModelReady: (model) async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final String? accessToken = preferences.getString('access_token');

        if (accessToken != null) {
          model.getListAPI(accessToken);
        } else {
          print('Access token not found');
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('List of All User'),
          backgroundColor: Colors.deepOrange,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteNavigation.signIn,
                );
              },
              child: const Text(
                'Log Out',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
        body: Center(
          child: model.state == ViewState.idle
              ? Container(
                  margin: EdgeInsets.all(29),
                  height: 600,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: model.listModel!.data!.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Container(
                              color: Colors.green,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(1),
                                        color: Colors.black,
                                        child: Text(
                                          'Name : ${model.listModel?.data?[index].name ?? "Not found"} '
                                          '\n Mobile Number: ${model.listModel?.data?[index]?.mobileNumber ?? "Not found"} '
                                          '\n ',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          Navigator.pushNamed(
                                            context,
                                            RouteNavigation.listDetails,
                                            arguments: model.listModel!
                                                .data![index].mobileNumber,
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.red,
                                          side: const BorderSide(
                                            color: Colors.yellow,
                                            width: 1,
                                          ),
                                          elevation: 4,
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.blue,

                                          // minimumSize: const Size(double.infinity, 10),

                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        child: const Text('Details Page'),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 4,
                        ),
                      );
                    },
                  ),
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
