import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class SearchPage extends ConsumerStatefulWidget {
  static const routeName = '/search';

  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final colorScheme = Theme.of(context).colorScheme;
    const horizontalPadding = EdgeInsets.symmetric(horizontal: 16.0);
    final cities = ref.watch(citiesProvider(cityName: _controller.text));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: scaffoldBackgroundColor,
          flexibleSpace: SafeArea(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 45.0,
                  margin: horizontalPadding,
                  padding: const EdgeInsets.only(left: 16.0, right: 50.0),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: TextFormField(
                    controller: _controller,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                        hintText: 'City name',
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        isCollapsed: true,
                        errorMaxLines: 0,
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          maxHeight: 40.0,
                        ),
                        contentPadding: EdgeInsets.only(bottom: 4.0)),
                    keyboardType: TextInputType.name,
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Visibility(
                    visible: _controller.text.isNotEmpty,
                    child: IconButton(
                      onPressed: () {
                        _controller.clear();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: cities.when(
          data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: Text('Search your city'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                const allRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                );

                const startRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.0),
                    topRight: Radius.circular(24.0),
                  ),
                );

                const endRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                );

                const midRadius = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                  ),
                );

                late RoundedRectangleBorder radius;
                if (data.length == 1) {
                  radius = allRadius;
                } else if (index == 0) {
                  radius = startRadius;
                } else if (index == data.length - 1) {
                  radius = endRadius;
                } else {
                  radius = midRadius;
                }

                return ListTile(
                  onTap: () {},
                  shape: radius,
                  title: Text(data[index].name),
                  subtitle: Text(data[index].id),
                  tileColor: colorScheme.primaryContainer,
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 0.0),
              itemCount: data.length,
            );
          },
          error: (_, __) => const Center(
            child: Text('Failed to load'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
