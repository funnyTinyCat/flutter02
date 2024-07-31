import 'package:flutter/material.dart';
import 'package:flutter_web_api/add_user.dart';
import 'package:flutter_web_api/api_handler.dart';
import 'package:flutter_web_api/edit_page.dart';
import 'package:flutter_web_api/find_user.dart';
import 'package:flutter_web_api/model.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<User> data = [];
  void getData() async {
    //
    data = await apiHandler.getUserDate();
    setState(() {
      //
    });
  }

  void deleteUser(int userId) async {
    //
    final response = await apiHandler.deleteUser(userId: userId);
    setState(() {
      //
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
    //
  }

  ApiHandler apiHandler = ApiHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("FlutterApi"),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text("Refresh"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => const FindUser(),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              //
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUser(),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditPage(
                        user: data[index],
                      ),
                    ),
                  );
                },
                leading: Text("${data[index].userId}"),
                title: Text(data[index].name),
                subtitle: Text(data[index].address),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () {
                    deleteUser(data[index].userId);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
