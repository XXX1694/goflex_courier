import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goflex_courier/common/colors.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text(
          'Уведомление',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.infinity,
            color: Colors.white24,
          ),
        ),
      ),
      body: SmartRefresher(
        header: CustomHeader(
          builder: (context, mode) => Platform.isAndroid
              ? CircularProgressIndicator(
                  color: mainColor,
                  strokeWidth: 3,
                )
              : CupertinoActivityIndicator(
                  color: mainColor,
                ),
        ),
        enablePullDown: true,
        enablePullUp: false,
        controller: refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Text('Нет уведомлений'),
            ),
          ),
        ),
      ),
    );
  }
}
