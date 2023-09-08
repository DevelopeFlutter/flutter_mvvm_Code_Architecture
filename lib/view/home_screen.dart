import 'package:flutter/material.dart';
import 'package:flutter_mvvm/data/response/status.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/view_model/home_view_model.dart';
import 'package:flutter_mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  @override
  void initState() {
    homeViewViewModel.getApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _userPrefrences = Provider.of<UserViewModel>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              InkWell(
                  onTap: () {
                    _userPrefrences.remove().then((value) {
                      Navigator.pushNamed(context, RoutesName.login);
                    });
                  },
                  child: const Center(child: Text('Log Out'))),
              const SizedBox(
                width: 20,
              )
            ],
          ),
          body: ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context) => homeViewViewModel,
            child: Consumer<HomeViewViewModel>(
              builder: (context, value, child) {
                switch (value.moviesList.status) {
                  case Status.LOADING:
                    return const Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return Center(child: Text(value.moviesList.message.toString()));
                  case Status.COMPLETED:
                    return ListView.builder(
                      itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          leading: Image.network(
                            value.moviesList.data!.movies![index].posterurl
                                .toString(),
                            errorBuilder: (context, error, stack) {
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                              );
                            },
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(value
                              .moviesList.data!.movies![index].title
                              .toString()),
                          subtitle: Text(value
                              .moviesList.data!.movies![index].year
                              .toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(Utils.averageRating(value
                                      .moviesList.data!.movies![index].ratings!)
                                  .toStringAsFixed(1)),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ],
                          ),
                        ));
                      },
                    );
                }
                return const Text('');
              },
            ),
          )),
    );
  }
}
