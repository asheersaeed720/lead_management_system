import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lead_management_system/src/users/users_service.dart';
import 'package:lead_management_system/widgets/page_title.dart';
import 'package:responsive_table/responsive_table.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late List<DatatableHeader> _headers;

  final List<int> _perPages = [10, 20, 50, 100];
  int _total = 100;
  int? _currentPerPage = 10;
  List<bool>? _expanded;
  String? _searchKey = "id";

  int _currentPage = 1;
  bool _isSearch = false;
  final List<Map<String, dynamic>> _sourceOriginal = [];
  List<Map<String, dynamic>> _sourceFiltered = [];
  List<Map<String, dynamic>> _source = [];
  List<Map<String, dynamic>> _selecteds = [];
  // ignore: unused_field
  final String _selectableKey = "id";

  String? _sortColumn;
  bool _sortAscending = true;
  bool _isLoading = true;
  final bool _showSelect = true;
  var random = math.Random();

  Future<List<Map<String, dynamic>>> _generateData() async {
    final userList = await UserServices().getAllUsers();
    final source = List.filled(10, userList);
    log('source $source');
    List<Map<String, dynamic>> temps = [];
    var i = 1;
    print(i);
    // ignore: unused_local_variable
    for (var data in source) {
      temps.add({
        "id": i,
        "sku": "$i 000$i",
        "name": data[0].name, // "Product $i",
        "category": "Category-$i",
        "price": i * 10.00,
        "cost": "20.00",
        "margin": "${i}0.20",
        "in_stock": "${i}0",
        "alert": "5",
        "received": [i + 20, 150]
      });
      i++;
    }
    return temps;
  }

  // Future<List<Map<String, dynamic>>> _generateData() async {
  //   final List<UserModel> source = await UserServices().getAllUsers();
  //   log('source $source');
  //   List<Map<String, dynamic>> temps = [];
  //   var i = 1;
  //   print(i);
  //   // ignore: unused_local_variable
  //   for (var data in source) {
  //     temps.add({
  //       // "id": i,
  //       // "sku": "$i 000$i",
  //       "name": data.name,
  //       // "category": "Category-$i",
  //       // "price": i * 10.00,
  //       // "cost": "20.00",
  //       // "margin": "${i}0.20",
  //       // "in_stock": "${i}0",
  //       // "alert": "5",
  //       // "received": [i + 20, 150]
  //     });
  //     i++;
  //   }
  //   return temps;
  // }

  _initializeData() async {
    _mockPullData();
  }

  _mockPullData() async {
    _expanded = List.generate(_currentPerPage!, (index) => false);

    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      _sourceOriginal.clear();
      _sourceOriginal.addAll(await _generateData());
      _sourceFiltered = _sourceOriginal;
      _total = _sourceFiltered.length;
      _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
      setState(() => _isLoading = false);
    });
  }

  _resetData({start = 0}) async {
    setState(() => _isLoading = true);
    var expandedLen = _total - start < _currentPerPage! ? _total - start : _currentPerPage;
    Future.delayed(const Duration(seconds: 0)).then((value) {
      _expanded = List.generate(expandedLen as int, (index) => false);
      _source.clear();
      _source = _sourceFiltered.getRange(start, start + expandedLen).toList();
      setState(() => _isLoading = false);
    });
  }

  _filterData(value) {
    setState(() => _isLoading = true);

    try {
      if (value == "" || value == null) {
        _sourceFiltered = _sourceOriginal;
      } else {
        _sourceFiltered = _sourceOriginal
            .where((data) =>
                data[_searchKey!].toString().toLowerCase().contains(value.toString().toLowerCase()))
            .toList();
      }

      _total = _sourceFiltered.length;
      var rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
      _expanded = List.generate(rangeTop, (index) => false);
      _source = _sourceFiltered.getRange(0, rangeTop).toList();
    } catch (e) {
      print(e);
    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();

    /// set headers
    _headers = [
      DatatableHeader(
          text: "ID", value: "id", show: true, sortable: true, textAlign: TextAlign.center),
      DatatableHeader(
          text: "Name",
          value: "name",
          show: true,
          flex: 2,
          sortable: true,
          editable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "SKU", value: "sku", show: true, sortable: true, textAlign: TextAlign.center),
      DatatableHeader(
          text: "Category",
          value: "category",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Price", value: "price", show: true, sortable: true, textAlign: TextAlign.left),
      DatatableHeader(
          text: "Margin", value: "margin", show: true, sortable: true, textAlign: TextAlign.left),
      DatatableHeader(
          text: "In Stock",
          value: "in_stock",
          show: true,
          sortable: true,
          textAlign: TextAlign.left),
      DatatableHeader(
          text: "Alert", value: "alert", show: true, sortable: true, textAlign: TextAlign.left),
      DatatableHeader(
          text: "Received",
          value: "received",
          show: true,
          sortable: false,
          sourceBuilder: (value, row) {
            List list = List.from(value);
            return Column(
              children: [
                SizedBox(
                  width: 85,
                  child: LinearProgressIndicator(
                    value: list.first / list.last,
                  ),
                ),
                Text("${list.first} of ${list.last}")
              ],
            );
          },
          textAlign: TextAlign.center),
    ];

    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const PageTitle(
              title: 'Users',
              iconData: Icons.person,
            ),
            const SizedBox(height: 20.0),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 700,
              ),
              child: Card(
                elevation: 1,
                shadowColor: Colors.black,
                clipBehavior: Clip.none,
                child: ResponsiveDatatable(
                  title: TextButton.icon(
                    onPressed: () => {},
                    icon: const Icon(Icons.add),
                    label: const Text("new item"),
                  ),
                  // reponseScreenSizes: const [ScreenSize.xs],
                  actions: [
                    if (_isSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            hintText:
                                'Enter search term based on ${_searchKey!.replaceAll(RegExp('[\\W_]+'), ' ').toUpperCase()}',
                            prefixIcon: IconButton(
                                icon: const Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    _isSearch = false;
                                  });
                                  _initializeData();
                                }),
                            suffixIcon:
                                IconButton(icon: const Icon(Icons.search), onPressed: () {})),
                        onSubmitted: (value) {
                          _filterData(value);
                        },
                      )),
                    if (!_isSearch)
                      IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              _isSearch = true;
                            });
                          })
                  ],
                  headers: _headers,
                  source: _source,
                  selecteds: _selecteds,
                  showSelect: _showSelect,
                  autoHeight: false,
                  dropContainer: (data) {
                    if (int.tryParse(data['id'].toString())!.isEven) {
                      return const Text("is Even");
                    }
                    return _DropDownContainer(data: data);
                  },
                  onChangedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onSubmittedRow: (value, header) {
                    /// print(value);
                    /// print(header);
                  },
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() => _isLoading = true);

                    setState(() {
                      _sortColumn = value;
                      _sortAscending = !_sortAscending;
                      if (_sortAscending) {
                        _sourceFiltered
                            .sort((a, b) => b["$_sortColumn"].compareTo(a["$_sortColumn"]));
                      } else {
                        _sourceFiltered
                            .sort((a, b) => a["$_sortColumn"].compareTo(b["$_sortColumn"]));
                      }
                      var rangeTop = _currentPerPage! < _sourceFiltered.length
                          ? _currentPerPage!
                          : _sourceFiltered.length;
                      _source = _sourceFiltered.getRange(0, rangeTop).toList();
                      _searchKey = value;

                      _isLoading = false;
                    });
                  },
                  expanded: _expanded,
                  sortAscending: _sortAscending,
                  sortColumn: _sortColumn,
                  isLoading: _isLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value!) {
                      setState(() => _selecteds.add(item));
                    } else {
                      setState(() => _selecteds.removeAt(_selecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value!) {
                      setState(() => _selecteds = _source.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => _selecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: const Text("Rows per page:"),
                    ),
                    if (_perPages.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton<int>(
                          value: _currentPerPage,
                          items: _perPages
                              .map((e) => DropdownMenuItem<int>(
                                    value: e,
                                    child: Text("$e"),
                                  ))
                              .toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              _currentPerPage = value;
                              _currentPage = 1;
                              _resetData();
                            });
                          },
                          isExpanded: false,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("$_currentPage - $_currentPerPage of $_total"),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: _currentPage == 1
                          ? null
                          : () {
                              var nextSet = _currentPage - _currentPerPage!;
                              setState(() {
                                _currentPage = nextSet > 1 ? nextSet : 1;
                                _resetData(start: _currentPage - 1);
                              });
                            },
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: _currentPage + _currentPerPage! - 1 > _total
                          ? null
                          : () {
                              var nextSet = _currentPage + _currentPerPage!;

                              setState(() {
                                _currentPage =
                                    nextSet < _total ? nextSet : _total - _currentPerPage!;
                                _resetData(start: nextSet - 1);
                              });
                            },
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                    )
                  ],
                  headerDecoration: const BoxDecoration(
                      color: Colors.grey,
                      border: Border(bottom: BorderSide(color: Colors.red, width: 1))),
                  selectedDecoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.green[300]!, width: 1)),
                    color: Colors.green,
                  ),
                  headerTextStyle: const TextStyle(color: Colors.white),
                  rowTextStyle: const TextStyle(color: Colors.green),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          const Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Column(
      /// children: [
      ///   Expanded(
      ///       child: Container(
      ///     color: Colors.red,
      ///     height: 50,
      ///   )),
      /// ],
      children: children,
    );
  }
}

// class UsersScreen extends StatefulWidget {
//   const UsersScreen({Key? key}) : super(key: key);
//   @override
//   State<UsersScreen> createState() => _UsersScreenState();
// }

// class _UsersScreenState extends State<UsersScreen> {
//   late List<DatatableHeader> _headers;

//   final List<int> _perPages = [10, 20, 50, 100];
//   int _total = 100;
//   int? _currentPerPage = 10;
//   List<bool>? _expanded;
//   String? _searchKey = "id";

//   int _currentPage = 1;
//   bool _isSearch = false;
//   final List<Map<String, dynamic>> _sourceOriginal = [];
//   List<Map<String, dynamic>> _sourceFiltered = [];
//   List<Map<String, dynamic>> _source = [];
//   List<Map<String, dynamic>> _selecteds = [];
//   // ignore: unused_field
//   final String _selectableKey = "id";

//   String? _sortColumn;
//   bool _sortAscending = true;
//   bool _isLoading = true;
//   final bool _showSelect = true;
//   var random = math.Random();

//   List<Map<String, dynamic>> _generateData({int n = 100}) {
//     final List source = List.filled(n, math.Random.secure());
//     List<Map<String, dynamic>> temps = [];
//     var i = 1;
//     print(i);
//     // ignore: unused_local_variable
//     for (var data in source) {
//       temps.add({
//         "id": i,
//         "sku": "$i 000$i",
//         "name": "Product $i",
//         "category": "Category-$i",
//         "price": i * 10.00,
//         "cost": "20.00",
//         "margin": "${i}0.20",
//         "in_stock": "${i}0",
//         "alert": "5",
//         "received": [i + 20, 150]
//       });
//       i++;
//     }
//     return temps;
//   }

//   _initializeData() async {
//     _mockPullData();
//   }

//   _mockPullData() async {
//     _expanded = List.generate(_currentPerPage!, (index) => false);

//     setState(() => _isLoading = true);
//     Future.delayed(const Duration(seconds: 3)).then((value) {
//       _sourceOriginal.clear();
//       _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
//       _sourceFiltered = _sourceOriginal;
//       _total = _sourceFiltered.length;
//       _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _resetData({start: 0}) async {
//     setState(() => _isLoading = true);
//     var expandedLen = _total - start < _currentPerPage! ? _total - start : _currentPerPage;
//     Future.delayed(const Duration(seconds: 0)).then((value) {
//       _expanded = List.generate(expandedLen as int, (index) => false);
//       _source.clear();
//       _source = _sourceFiltered.getRange(start, start + expandedLen).toList();
//       setState(() => _isLoading = false);
//     });
//   }

//   _filterData(value) {
//     setState(() => _isLoading = true);

//     try {
//       if (value == "" || value == null) {
//         _sourceFiltered = _sourceOriginal;
//       } else {
//         _sourceFiltered = _sourceOriginal
//             .where((data) =>
//                 data[_searchKey!].toString().toLowerCase().contains(value.toString().toLowerCase()))
//             .toList();
//       }

//       _total = _sourceFiltered.length;
//       var rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
//       _expanded = List.generate(rangeTop, (index) => false);
//       _source = _sourceFiltered.getRange(0, rangeTop).toList();
//     } catch (e) {
//       print(e);
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();

//     /// set headers
//     _headers = [
//       DatatableHeader(
//           text: "ID", value: "id", show: true, sortable: true, textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "Name",
//           value: "name",
//           show: true,
//           flex: 2,
//           sortable: true,
//           editable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "SKU", value: "sku", show: true, sortable: true, textAlign: TextAlign.center),
//       DatatableHeader(
//           text: "Category",
//           value: "category",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Price", value: "price", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Margin", value: "margin", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "In Stock",
//           value: "in_stock",
//           show: true,
//           sortable: true,
//           textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Alert", value: "alert", show: true, sortable: true, textAlign: TextAlign.left),
//       DatatableHeader(
//           text: "Received",
//           value: "received",
//           show: true,
//           sortable: false,
//           sourceBuilder: (value, row) {
//             List list = List.from(value);
//             return Column(
//               children: [
//                 SizedBox(
//                   width: 85,
//                   child: LinearProgressIndicator(
//                     value: list.first / list.last,
//                   ),
//                 ),
//                 Text("${list.first} of ${list.last}")
//               ],
//             );
//           },
//           textAlign: TextAlign.center),
//     ];

//     _initializeData();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             const PageTitle(
//               title: 'Users',
//               iconData: Icons.person,
//             ),
//             const SizedBox(height: 20.0),
//             Container(
//               constraints: const BoxConstraints(
//                 maxHeight: 700,
//               ),
//               child: Card(
//                 elevation: 1,
//                 shadowColor: Colors.black,
//                 clipBehavior: Clip.none,
//                 child: ResponsiveDatatable(
//                   title: TextButton.icon(
//                     onPressed: () => {},
//                     icon: const Icon(Icons.add),
//                     label: const Text("new item"),
//                   ),
//                   // reponseScreenSizes: const [ScreenSize.xs],
//                   actions: [
//                     if (_isSearch)
//                       Expanded(
//                           child: TextField(
//                         decoration: InputDecoration(
//                             hintText:
//                                 'Enter search term based on ${_searchKey!.replaceAll(RegExp('[\\W_]+'), ' ').toUpperCase()}',
//                             prefixIcon: IconButton(
//                                 icon: const Icon(Icons.cancel),
//                                 onPressed: () {
//                                   setState(() {
//                                     _isSearch = false;
//                                   });
//                                   _initializeData();
//                                 }),
//                             suffixIcon:
//                                 IconButton(icon: const Icon(Icons.search), onPressed: () {})),
//                         onSubmitted: (value) {
//                           _filterData(value);
//                         },
//                       )),
//                     if (!_isSearch)
//                       IconButton(
//                           icon: const Icon(Icons.search),
//                           onPressed: () {
//                             setState(() {
//                               _isSearch = true;
//                             });
//                           })
//                   ],
//                   headers: _headers,
//                   source: _source,
//                   selecteds: _selecteds,
//                   showSelect: _showSelect,
//                   autoHeight: false,
//                   dropContainer: (data) {
//                     if (int.tryParse(data['id'].toString())!.isEven) {
//                       return const Text("is Even");
//                     }
//                     return _DropDownContainer(data: data);
//                   },
//                   onChangedRow: (value, header) {
//                     /// print(value);
//                     /// print(header);
//                   },
//                   onSubmittedRow: (value, header) {
//                     /// print(value);
//                     /// print(header);
//                   },
//                   onTabRow: (data) {
//                     print(data);
//                   },
//                   onSort: (value) {
//                     setState(() => _isLoading = true);

//                     setState(() {
//                       _sortColumn = value;
//                       _sortAscending = !_sortAscending;
//                       if (_sortAscending) {
//                         _sourceFiltered
//                             .sort((a, b) => b["$_sortColumn"].compareTo(a["$_sortColumn"]));
//                       } else {
//                         _sourceFiltered
//                             .sort((a, b) => a["$_sortColumn"].compareTo(b["$_sortColumn"]));
//                       }
//                       var rangeTop = _currentPerPage! < _sourceFiltered.length
//                           ? _currentPerPage!
//                           : _sourceFiltered.length;
//                       _source = _sourceFiltered.getRange(0, rangeTop).toList();
//                       _searchKey = value;

//                       _isLoading = false;
//                     });
//                   },
//                   expanded: _expanded,
//                   sortAscending: _sortAscending,
//                   sortColumn: _sortColumn,
//                   isLoading: _isLoading,
//                   onSelect: (value, item) {
//                     print("$value  $item ");
//                     if (value!) {
//                       setState(() => _selecteds.add(item));
//                     } else {
//                       setState(() => _selecteds.removeAt(_selecteds.indexOf(item)));
//                     }
//                   },
//                   onSelectAll: (value) {
//                     if (value!) {
//                       setState(() => _selecteds = _source.map((entry) => entry).toList().cast());
//                     } else {
//                       setState(() => _selecteds.clear());
//                     }
//                   },
//                   footers: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: const Text("Rows per page:"),
//                     ),
//                     if (_perPages.isNotEmpty)
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: DropdownButton<int>(
//                           value: _currentPerPage,
//                           items: _perPages
//                               .map((e) => DropdownMenuItem<int>(
//                                     value: e,
//                                     child: Text("$e"),
//                                   ))
//                               .toList(),
//                           onChanged: (dynamic value) {
//                             setState(() {
//                               _currentPerPage = value;
//                               _currentPage = 1;
//                               _resetData();
//                             });
//                           },
//                           isExpanded: false,
//                         ),
//                       ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                       child: Text("$_currentPage - $_currentPerPage of $_total"),
//                     ),
//                     IconButton(
//                       icon: const Icon(
//                         Icons.arrow_back_ios,
//                         size: 16,
//                       ),
//                       onPressed: _currentPage == 1
//                           ? null
//                           : () {
//                               var nextSet = _currentPage - _currentPerPage!;
//                               setState(() {
//                                 _currentPage = nextSet > 1 ? nextSet : 1;
//                                 _resetData(start: _currentPage - 1);
//                               });
//                             },
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.arrow_forward_ios, size: 16),
//                       onPressed: _currentPage + _currentPerPage! - 1 > _total
//                           ? null
//                           : () {
//                               var nextSet = _currentPage + _currentPerPage!;

//                               setState(() {
//                                 _currentPage =
//                                     nextSet < _total ? nextSet : _total - _currentPerPage!;
//                                 _resetData(start: nextSet - 1);
//                               });
//                             },
//                       padding: const EdgeInsets.symmetric(horizontal: 15),
//                     )
//                   ],
//                   headerDecoration: const BoxDecoration(
//                       color: Colors.grey,
//                       border: Border(bottom: BorderSide(color: Colors.red, width: 1))),
//                   selectedDecoration: BoxDecoration(
//                     border: Border(bottom: BorderSide(color: Colors.green[300]!, width: 1)),
//                     color: Colors.green,
//                   ),
//                   headerTextStyle: const TextStyle(color: Colors.white),
//                   rowTextStyle: const TextStyle(color: Colors.green),
//                   selectedTextStyle: const TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _DropDownContainer extends StatelessWidget {
//   final Map<String, dynamic> data;
//   const _DropDownContainer({Key? key, required this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> children = data.entries.map<Widget>((entry) {
//       Widget w = Row(
//         children: [
//           Text(entry.key.toString()),
//           const Spacer(),
//           Text(entry.value.toString()),
//         ],
//       );
//       return w;
//     }).toList();

//     return Column(
//       /// children: [
//       ///   Expanded(
//       ///       child: Container(
//       ///     color: Colors.red,
//       ///     height: 50,
//       ///   )),
//       /// ],
//       children: children,
//     );
//   }
// }
