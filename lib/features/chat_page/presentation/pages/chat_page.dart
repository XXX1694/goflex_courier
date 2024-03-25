import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goflex_courier/common/colors.dart';
import 'package:goflex_courier/features/chat_page/presentation/bloc/chat_page_bloc.dart';
import 'package:goflex_courier/features/get_user_id/presentation/bloc/get_user_id_bloc.dart';
import 'package:goflex_courier/features/message/presentation/pages/message_page.dart';
import 'package:goflex_courier/providers/home_provider.dart';

import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatPageBloc bloc;
  late GetUserIdBloc bloc1;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    bloc = BlocProvider.of<ChatPageBloc>(context);
    bloc1 = BlocProvider.of<GetUserIdBloc>(context);
    bloc1.add(GetuserId());
    // bloc.add(GetAllChats());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // bloc.add(GetAllChats());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'go',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: 'flex',
                style: TextStyle(
                  color: mainColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
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
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: BlocConsumer<GetUserIdBloc, GetUserIdState>(
                  listener: (context, state1) {
                    if (state1 is GotUserId) {
                      bloc.add(GetAllChats());
                    }
                  },
                  builder: (context, state1) {
                    if (state1 is GotUserId) {
                      return BlocConsumer<ChatPageBloc, ChatPageState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ChatListGot) {
                            return SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: false,
                              controller: _refreshController,
                              onRefresh: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 500));
                                bloc1.add(GetuserId());
                                bloc.add(GetAllChats());
                              },
                              child: ListView.builder(
                                itemCount: state.chats.length,
                                itemBuilder: (context, index) =>
                                    CupertinoButton(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                          create: (context) => HomeProvider(),
                                          child: MessagePage(
                                            chatId: state.chats[index].id,
                                            userId: state1.userId,
                                            name: state.chats[index].participants[0]
                                                        ['id'] !=
                                                    state1.userId
                                                ? (state.chats[index].participants[0]
                                                            ['name'] ??
                                                        state.chats[index]
                                                                .participants[1]
                                                            ['name'])
                                                    .toString()
                                                : (state.chats[index]
                                                                .participants[1]
                                                            ['name'] ??
                                                        state.chats[index]
                                                                .participants[0]
                                                            ['name'])
                                                    .toString(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state
                                                    .chats[index]
                                                    .delivery['order']
                                                        ['tracking_number']
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                state.chats[index].participants[0]
                                                            ['id'] !=
                                                        state1.userId
                                                    ? (state.chats[index]
                                                                    .participants[0]
                                                                ['name'] ??
                                                            state.chats[index]
                                                                    .participants[1]
                                                                ['name'])
                                                        .toString()
                                                    : (state.chats[index]
                                                                    .participants[1]
                                                                ['name'] ??
                                                            state.chats[index]
                                                                    .participants[0]
                                                                ['name'])
                                                        .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else if (state is ChatListGetting) {
                            return Center(
                              child: Platform.isAndroid
                                  ? CircularProgressIndicator(
                                      color: mainColor,
                                      strokeWidth: 3,
                                    )
                                  : CupertinoActivityIndicator(
                                      color: mainColor,
                                    ),
                            );
                          } else {
                            return const Center(
                              child: Text('Пусто'),
                            );
                          }
                        },
                      );
                    } else {
                      return Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: mainColor,
                                strokeWidth: 3,
                              )
                            : CupertinoActivityIndicator(
                                color: mainColor,
                              ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
