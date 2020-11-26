import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/catalog/catalog.dart';

class MyCatalog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is CatalogLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is CatalogLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _MyListItem(
                      state.catalog.getByPosition(index),
                    ),
                  ),
                );
              }
              return const Text('Something went wrong!');
            },
          ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Catalog'),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.of(context).pushNamed('/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  const _MyListItem(this.item, {Key key}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(aspectRatio: 1, child: ColoredBox(color: item.color)),
            const SizedBox(width: 24),
            Expanded(child: Text(item.name, style: textTheme)),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
