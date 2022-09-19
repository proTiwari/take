import 'package:flutter/material.dart';
import 'package:take/Widgets/cards.dart';
import 'package:take/Widgets/search_BAR.dart';
import 'Widgets/google_map_circle.dart';
import 'Widgets/list_view_filter.dart';
import 'globar_variables/globals.dart' as globals;
import 'Widgets/filter_card.dart';
import 'package:filter_list/filter_list.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<User>? selectedUserList = [];

  final Map<int, Color?> _yellow700Map = {
    50: const Color(0xFFFFD7C2),
    100: Colors.red[200],
  };

  Future<void> openFilterDialog() async {
    await FilterListDialog.display<User>(
      context,
      hideSelectedTextCount: true,
      themeData: FilterListThemeData(context),
      headlineText: 'Filter',
      height: 500,
      listData: userList,
      selectedListData: selectedUserList,
      choiceChipLabel: (item) => item!.name,
      validateSelectedItem: (list, val) => list!.contains(val),
      controlButtons: [ControlButtonType.Reset],
      onItemSearch: (user, query) {
        return user.name!.toLowerCase().contains(query.toLowerCase());
      },
      onApplyButtonClick: (list) {
        setState(() {
          selectedUserList = List.from(list!);
        });
        Navigator.pop(context);
      },
      choiceChipBuilder: (context, item, isSelected) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(
            color: isSelected! ? Colors.red[200]! : Colors.grey[300]!,
          )),
          child: Text(
            item.name,
            style: TextStyle(
                color: isSelected ? Colors.red[200] : Colors.grey[500]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    globals.width = width * 0.87;
    var height = MediaQuery.of(context).size.height;
    globals.height = height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SearchBar(),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(13.0, 0, 0, 0),
                  child: SizedBox(
                    height: 35.0,
                    width: width * 0.67,
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: [
                                ListViewFilter("niva"),
                                ListViewFilter("sainik colony"),
                                ListViewFilter("niva"),
                                ListViewFilter("sainik colony"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: InkWell(
                    onTap: openFilterDialog,
                    child: const FilterCard(),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Column(
                        children: [

                          const CardsWidget(),
                          const CardsWidget(),
                          // const CardsWidget(),
                          // const CardsWidget(),
                          // const CardsWidget(),
                          // const CardsWidget(),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: const GoogleMapCircle()
      ),
    );
  }
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

List<User> userList = [
  User(name: "High to Low", avatar: "user.png"),
  User(name: "Low to High", avatar: "user.png"),
  User(name: "less than 5000/month", avatar: "user.png"),
  User(name: "less than 10,000/month", avatar: "user.png"),
  User(name: "more than 10,000/month", avatar: "user.png"),
  User(name: "Within 10km", avatar: "user.png"),
  User(name: "Within 5km", avatar: "user.png"),
  User(name: "Within 1km", avatar: "user.png"),
  User(name: "House On Sale", avatar: "user.png"),
  User(name: "House/Room On Rent", avatar: "user.png"),
  User(name: "Hotel Service", avatar: "user.png"),
  User(name: "PG Service", avatar: "user.png"),
  User(name: "Hostel Service", avatar: "user.png"),
  User(name: "Home Service", avatar: "user.png"),
  User(name: "No Sharing", avatar: "user.png"),
  User(name: "Two Sharing", avatar: "user.png"),
  User(name: "Three Sharing", avatar: "user.png"),
  User(name: "Many Sharing", avatar: "user.png"),
];
