import 'dart:async';
import 'package:atlanta_task/BlocFolder/user_bloc.dart';
import 'package:atlanta_task/Models/user_model_class.dart';
import 'package:atlanta_task/Resources/api_call.dart';
import 'package:atlanta_task/Screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  double deviceHeight = 0.0;
  double deviceWidth = 0.0;
  List<UserModel> userList = [];
  TextEditingController searchController = TextEditingController();
  List<UserModel> searchList = [];
  bool searchStarted = false;
  Timer? searchTimer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// function to SEARCH PRODUCT LIST
  Future searchProduct(String text) async {
    setState(() {
      searchList.clear();
      searchStarted = true;
    });
    for(var value in userList){
      if(value.name!.toLowerCase().contains(text)){
        searchList.add(value);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => UserBloc(
        RepositoryProvider.of<Util>(context),
      )..add(UserLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
          actions: [
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen(),));
              },
              icon: const Icon(Icons.notifications_active_rounded),
            ),
          ],
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state){
            if(state is UserLoadingState){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is UserLoadedState){
              userList = state.users;
              /// this line will sort the user list in ascending order
              userList.sort((a, b) => a.name!.compareTo(b.name!));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value){
                            if(value.trim().isNotEmpty){
                              if(searchTimer != null && searchTimer!.isActive){
                                setState(() {
                                  searchTimer!.cancel();
                                });
                              }
                              searchTimer = Timer(const Duration(milliseconds: 300), () {
                                searchProduct(value.trim());
                              });
                            }
                            else{
                              setState(() {
                                searchTimer!.cancel();
                                FocusManager.instance.primaryFocus?.unfocus();
                                searchStarted = false;
                                searchController.clear();
                                searchList.clear();
                              });
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            prefixIcon: Icon(Icons.search, size: deviceHeight*0.026, color: Colors.black.withOpacity(0.35),),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                setState(() {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  searchStarted = false;
                                  searchController.clear();
                                  searchList.clear();
                                });
                              },
                              child: Icon(Icons.cancel_outlined, size: deviceHeight*0.026, color: Colors.black.withOpacity(0.35),),
                            ),
                            filled: true,
                            fillColor: Colors.grey.withOpacity(0.3),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            hintText: "Search User",
                          ),
                        ),
                      ),
                      searchStarted == true && searchList.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("No User Found"),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: searchStarted == true ? searchList.length : userList.length,
                        itemBuilder: (BuildContext context, int index){
                          var data = searchStarted == true ? searchList[index] : userList[index];
                          return Container(
                            color: Colors.blue.withOpacity(0.2),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: Text(data.name!),
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
            if(state is UserErrorState){
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}

