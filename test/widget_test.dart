import 'package:flutter/material.dart';
import 'package:red_max_anime/data/model/message.dart';
import 'package:red_max_anime/domain/controller/authentication_controller.dart';
import 'package:red_max_anime/domain/controller/chat_controller.dart';
import 'package:red_max_anime/ui/widgets/chat_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';

class MockChatController extends GetxService
    with Mock
    implements ChatController {
  @override
  var messages = <Message>[].obs;
  @override
  Future<void> sendMsg(String text) async {
    messages.add(Message('key', text, '001'));
  }
}

class MockAuthenticationController extends GetxService
    with Mock
    implements AuthenticationController {
  @override
  String getUid() {
    return '001';
  }
}

void main() {
  setUp(() {
    MockAuthenticationController mockAuthenticationController =
        MockAuthenticationController();
    Get.put<AuthenticationController>(mockAuthenticationController);

    MockChatController mockChatController = MockChatController();
    Get.put<ChatController>(mockChatController);
  });
  testWidgets('Simple chat test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ChatPage(),
        ),
      ),
    );

    await tester.pump();

    await tester.enterText(find.byKey(const Key('MsgTextField')), 'Juan');

    await tester.tap(find.byKey(const Key('sendButton')));

    await tester.pump();

    expect(find.text('Juan'), findsOneWidget);
  });
}
