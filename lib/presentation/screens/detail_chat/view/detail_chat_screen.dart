import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_bloc.dart';
import 'package:shamoapps/presentation/screens/detail_chat/bloc/chat_event.dart';
import 'package:shamoapps/presentation/screens/detail_chat/view/detail_chat_view.dart';

class DetailChatScreen extends StatelessWidget {
  const DetailChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatBloc()..add(LoadInitialMessages()),
      child: const DetailChatView(),
    );
  }
}
