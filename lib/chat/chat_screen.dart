import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errands_boys/auth_service.dart';
import 'package:errands_boys/chat/button_chat_page.dart';
import 'package:errands_boys/chat/chat_page.dart';
import 'package:errands_boys/chat/chat_service.dart';
import 'package:errands_boys/chat/user_tile.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _activeIndex = 0;
  // chat & auth service
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  Widget _buildServiceProviderList() {
    final currentUserId = _authService.getCurrentUser()!.uid;

    return FutureBuilder(
      future:
          FirebaseFirestore.instance
              .collection('customer_request')
              .doc(currentUserId)
              .collection('selected_service')
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No providers found."));
        }

        final serviceDocs = snapshot.data!.docs;
        print(
          "Selected services found: ${serviceDocs.map((doc) => doc.id).toList()}",
        );

        final List<Widget> tiles = [];

        for (var serviceDoc in snapshot.data!.docs) {
          final serviceName = serviceDoc.id;

          tiles.add(
            FutureBuilder(
              future:
                  FirebaseFirestore.instance
                      .collection('customer_request')
                      .doc(currentUserId)
                      .collection('selected_service')
                      .doc(serviceName)
                      .collection('providerID')
                      .get(),
              builder: (context, providerSnapshot) {
                if (!providerSnapshot.hasData ||
                    providerSnapshot.data!.docs.isEmpty) {
                  return const SizedBox(); // or "No providers"
                }

                print("Loading providers for service: $serviceName");
                print(
                  "Provider IDs found: ${providerSnapshot.data!.docs.map((d) => d.id).toList()}",
                );

                return Column(
                  children:
                      providerSnapshot.data!.docs.map((doc) {
                        final userData = doc.data() as Map<String, dynamic>;

                        print("providerID: ${doc.id}, userData: $userData");

                        return _serviceBuildUserListItem(userData, context);
                      }).toList(),
                );
              },
            ),
          );
        }

        return ListView(children: tiles);
      },
    );
  }

  Widget _buildCustomerList() {
    final currentUserId = _authService.getCurrentUser()!.uid;

    return FutureBuilder(
      future:
          FirebaseFirestore.instance
              .collection('provider_request')
              .doc(currentUserId)
              .collection('selected_service')
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No customers found."));
        }

        final serviceDocs = snapshot.data!.docs;
        print(
          "Selected services found: ${serviceDocs.map((doc) => doc.id).toList()}",
        );

        final List<Widget> tiles = [];

        for (var serviceDoc in snapshot.data!.docs) {
          final serviceName = serviceDoc.id;

          tiles.add(
            FutureBuilder(
              future:
                  FirebaseFirestore.instance
                      .collection('provider_request')
                      .doc(currentUserId)
                      .collection('selected_service')
                      .doc(serviceName)
                      .collection('customerID')
                      .get(),
              builder: (context, customerSnapshot) {
                if (!customerSnapshot.hasData ||
                    customerSnapshot.data!.docs.isEmpty) {
                  return const SizedBox();
                }

                print("Loading customers for service: $serviceName");
                print(
                  "Customer IDs found: ${customerSnapshot.data!.docs.map((d) => d.id).toList()}",
                );

                return Column(
                  children:
                      customerSnapshot.data!.docs.map((doc) {
                        final userData = doc.data() as Map<String, dynamic>;

                        print("customerID: ${doc.id}, userData: $userData");

                        return _workBuildUserListItem(userData, context);
                      }).toList(),
                );
              },
            ),
          );
        }

        return ListView(children: tiles);
      },
    );
  }

  Widget _buildUserList() {
    if (_activeIndex == 1) {
      return _buildServiceProviderList();
    } else if (_activeIndex == 2) {
      return _buildCustomerList();
    } else if (_activeIndex == 0) {
      return Column(
        children: [
          Expanded(child: _buildServiceProviderList()),
          const Divider(height: 1),
          Expanded(child: _buildCustomerList()),
        ],
      );
    } else {
      return const Center(child: Text("Select a category"));
    }
  }

  void _onButtonTap(int index) {
    if (_activeIndex != index) {
      // Prevent unnecessary rebuilds
      setState(() {
        _activeIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(91, 158, 158, 158),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ButtonChatPage(
                          index: 0,
                          nameCategories: 'All',
                          heightCategories: 40,
                          widthCategories: 100,
                          onButtonTap: _onButtonTap,
                          isButtonActive: _activeIndex == 0,
                        ),

                        const SizedBox(width: 25),

                        ButtonChatPage(
                          index: 1,
                          nameCategories: 'Service',
                          heightCategories: 40,
                          widthCategories: 110,
                          onButtonTap: _onButtonTap,
                          isButtonActive: _activeIndex == 1,
                        ),

                        const SizedBox(width: 25),

                        ButtonChatPage(
                          nameCategories: 'Work',
                          index: 2,
                          heightCategories: 40,
                          widthCategories: 100,
                          onButtonTap: _onButtonTap,
                          isButtonActive: _activeIndex == 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            Expanded(child: _buildUserList()),
          ],
        ),
      ),
    );
  }

  Widget _workBuildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    final currentUserID = _authService.getCurrentUser()!.uid;
    final otherUserID = userData['ordered_by_uid'];

    print('currentUserID: $currentUserID + otherUserID: $otherUserID');

    if (currentUserID == otherUserID) {
      print('user: ${userData['email']}');
      print('service provider: ${userData['provider_ID']}');
      print('here is wrong');
      return Container(); // skip current user
    }

    return StreamBuilder(
      stream: _chatService.getMessages(currentUserID, otherUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading message');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final lastMessageDoc =
            snapshot.data?.docs.isNotEmpty == true
                ? snapshot.data!.docs.last
                : null;

        Timestamp? lastTimestamp = lastMessageDoc?['timestamp'];
        String? lastMessage = lastMessageDoc?['message'];

        // Format time to simple hh:mm or date if needed (optional)
        String formattedTime = '';
        if (lastTimestamp != null) {
          final dt = lastTimestamp.toDate();
          formattedTime = TimeOfDay.fromDateTime(dt).format(context);
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChatPage(
                        receiverName: userData['customer_name'],
                        receiverID: userData['ordered_by_uid'],
                        timestamp: lastTimestamp,
                        message: lastMessage,
                      ),
                ),
              );
            },
            title: Text('${userData['customer_name'] ?? 'No Name'}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lastMessage != null)
                  Text(
                    lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                    ),
                  ),
                //const SizedBox(height: 4),
                //Text('Phone: ${userData['phone_number'] ?? 'N/A'}'),
                //Text('Price: \$${userData['price'] ?? 'N/A'}'),
                //Text('Preferred contact: ${userData['preferred_contact'] ?? 'N/A'}'),
              ],
            ),
            trailing: Text(formattedTime),
          ),
        );
      },
    );
  }

  Widget _serviceBuildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    final currentUserID = _authService.getCurrentUser()!.uid;
    final otherUserID = userData['provider_ID'];

    print('currentUserID: $currentUserID + otherUserID: $otherUserID');

    if (currentUserID == otherUserID) {
      print('user: ${userData['email']}');
      print('service provider: ${userData['provider_ID']}');
      print('here is wrong');
      return Container(); // skip current user
    }

    return StreamBuilder(
      stream: _chatService.getMessages(currentUserID, otherUserID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error loading message');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }

        final lastMessageDoc =
            snapshot.data?.docs.isNotEmpty == true
                ? snapshot.data!.docs.last
                : null;

        Timestamp? lastTimestamp = lastMessageDoc?['timestamp'];
        String? lastMessage = lastMessageDoc?['message'];

        // Format time to simple hh:mm or date if needed (optional)
        String formattedTime = '';
        if (lastTimestamp != null) {
          final dt = lastTimestamp.toDate();
          formattedTime = TimeOfDay.fromDateTime(dt).format(context);
        }

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => ChatPage(
                        receiverName: userData['provider_name'],
                        receiverID: userData['provider_ID'],
                        timestamp: lastTimestamp,
                        message: lastMessage,
                      ),
                ),
              );
            },
            title: Text('${userData['provider_name'] ?? 'No Name'}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lastMessage != null)
                  Text(
                    lastMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                    ),
                  ),
                //const SizedBox(height: 4),
                //Text('Phone: ${userData['phone_number'] ?? 'N/A'}'),
                //Text('Price: \$${userData['price'] ?? 'N/A'}'),
                //Text('Preferred contact: ${userData['preferred_contact'] ?? 'N/A'}'),
              ],
            ),
            trailing: Text(formattedTime),
          ),
        );
      },
    );
  }
}
