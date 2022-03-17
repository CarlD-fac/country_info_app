import 'package:country_info_app/presentation/pages/base_page.dart';
import 'package:country_info_app/presentation/pages/country_info/country_info_page.dart';
import 'package:country_info_app/presentation/pages/favourites/favourites_scoped_model.dart';
import 'package:country_info_app/presentation/pages/view_state.dart';
import 'package:country_info_app/presentation/utils/navigation_util.dart';
import 'package:flutter/material.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage<FavouritesScopedModel>(
        initialState: ViewState.ready,
        builder: (context, child, scopedModel) => Scaffold(
                body: Container(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    if (scopedModel.state == ViewState.loading)
                      const Center(child: CircularProgressIndicator())
                    else if (scopedModel.state == ViewState.empty)
                      const Center(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "You don't have any favourite country !")))
                    else if (scopedModel.state == ViewState.ready)
                      Expanded(
                          child: GridView.builder(
                              itemCount: scopedModel.countriesList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 10.0,
                                      childAspectRatio: 45 / 60),
                              itemBuilder: (context, i) {
                                return InkWell(
                                    onTap: () => NavigationUtil.navigateTo(
                                        context,
                                        CountryInfoPage(
                                            scopedModel.countriesList[i])),
                                    child: Card(
                                      color: Colors.amberAccent,
                                      child: Column(
                                        children: <Widget>[
                                          ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(4.0)),
                                              child: (Uri.parse(scopedModel
                                                          .countriesList[i]
                                                          .flag)
                                                      .isAbsolute)
                                                  ? Column(children: [
                                                      Image.network(
                                                          scopedModel
                                                              .countriesList[i]
                                                              .flag,
                                                          errorBuilder: (c, e,
                                                                  s) =>
                                                              const Icon(
                                                                  Icons
                                                                      .error_outline,
                                                                  size: 100.0)),
                                                      Text(scopedModel
                                                          .countriesList[i]
                                                          .name)
                                                    ])
                                                  : Column(children: [
                                                      const Icon(
                                                          Icons.error_outline,
                                                          size: 100.0),
                                                      Text(scopedModel
                                                          .countriesList[i]
                                                          .name)
                                                    ])),
                                        ],
                                      ),
                                    ));
                              }))
                  ]
                      //scopedModel.onFavouritesLoad()
                      )),
            )));
  }
}
/*StreamBuilder(
stream: locator<LoadFavouritesUseCase>().execute(),
builder: (context, AsyncSnapshot snapshot) {
if (snapshot.hasData) {
return GridView.builder(
itemCount: scopedModel.countriesList.length,
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,
crossAxisSpacing: 10.0,
mainAxisSpacing: 10.0,
childAspectRatio: 45 / 60),
itemBuilder: (context, i) {
return InkWell(
onTap: () => NavigationUtil.navigateTo(
context, CountryInfoPage(scopedModel.countriesList[i])),
child: Card(
color: Colors.white60,
child: Column(
children: <Widget>[
ClipRRect(
borderRadius: const BorderRadius.vertical(
top: Radius.circular(4.0)),
child: (Uri.parse(scopedModel.countriesList[i].flag)
    .isAbsolute)
? Column(children: [
Image.network(scopedModel.countriesList[i].flag,
errorBuilder: (c, e, s) =>
const Icon(Icons.error_outline,
size: 100.0)),
Text(scopedModel.countriesList[i].name)
])
    : Column(children: [
const Icon(Icons.error_outline,
size: 100.0),
Text(scopedModel.countriesList[i].name)
])),
],
),
));
});
} else {
return const Center(
child: CircularProgressIndicator(),
);
}
},
),*/
