import 'package:exam_test/core/enums/view_state.dart';
import 'package:exam_test/core/view_models/list_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_view.dart';

class ListDetailsView extends StatelessWidget {
  ///specific item details
  final String mobile_number;
  const ListDetailsView({super.key, required this.mobile_number});

  @override
  Widget build(BuildContext context) {
    return BaseView<ListDetailsViewModel>(
      onModelReady: (model) async {
        final SharedPreferences preferences =
            await SharedPreferences.getInstance();
        final String? accessToken = preferences.getString('access_token');

        if (accessToken != null) {
          model.getListAPI(accessToken, mobile_number);
        } else {
          print('Access token not found');
        }
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrange,
        ),
        body: SafeArea(
          child: Center(
            child: model.state == ViewState.idle
                ? ListView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                      'ID: ${model.listDetailsModel!.data!.id}'),
                                  Text(
                                      'Name:  ${model.listDetailsModel!.data!.name}'),
                                  Text(
                                      'Email: ${model.listDetailsModel!.data!.email}'),
                                  Text(
                                      'User Name: ${model.listDetailsModel!.data!.address}'),
                                  Text(
                                      'Mobile Number ${model.listDetailsModel!.data!.mobileNumber}')
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  )
                : const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
