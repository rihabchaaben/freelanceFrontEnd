import 'package:flutter/material.dart';
import 'package:freelance/models/freelancerModel.dart';
import 'package:freelance/services/marketplaceService.dart';
import 'package:flutter/cupertino.dart';

class MarketplaceFreelancers extends StatefulWidget {
  const MarketplaceFreelancers({Key? key}) : super(key: key);

  @override
  State<MarketplaceFreelancers> createState() => _MarketplaceState();
}

class _MarketplaceState extends State<MarketplaceFreelancers> {
  @override
  void initState() {
    super.initState();
    // ignore: unnecessary_cast
    MarketplaceController().fetchFreelancers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FreelancerModel>>(
      future: MarketplaceController().fetchFreelancers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
              itemBuilder: (context, index) {
                var freelancer =
                    (snapshot.data as List<FreelancerModel>)[index];
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // ignore: prefer_const_constructors

                      Text(freelancer.username!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22)),
                      SizedBox(height: 5),
                      Text(freelancer.subcategory!.designation),
                      SizedBox(height: 5),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: (snapshot.data as List<FreelancerModel>).length);
        } else if (snapshot.hasError) {
          return Center(child: Text('${snapshot.error}'));
        }
        return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.cyanAccent),
        );
      },
    ));
  }
}
