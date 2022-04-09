import 'dart:io';

import 'package:birdgo/mappage.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:birdgo/widget_copy/button_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import '../location copy.dart';
import '../photo_copy.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TextfieldGeneralWidget extends StatefulWidget {
  final Function uploadCallback;
  TextfieldGeneralWidget(this.uploadCallback);
  @override
  _TextfieldGeneralWidgetState createState() => _TextfieldGeneralWidgetState();
}

class _TextfieldGeneralWidgetState extends State<TextfieldGeneralWidget> {
  bool pressGeoON = false;
  final NameController = TextEditingController();
  final DescriptionController = TextEditingController();
  final numberController = TextEditingController();
  String password = '';
  bool isPasswordVisible = false;
  Location location = new Location();
  var position;
  var ListOfBirds = [
    'King Quail',
    'Red Junglefowl',
    'Wandering Whistling Duck',
    'Lesser Whistling Duck',
    'Cotton Pygmy Goose',
    'Garganey',
    'Northern Shoveler',
    'Gadwall',
    'Eurasian Wigeon',
    'Northern Pintail',
    'Tufted Duck',
    'Malaysian Eared Nightjar',
    'Grey Nightjar',
    'Large-tailed Nightjar',
    'Savanna Nightjar',
    'Grey-rumped Treeswift',
    'Whiskered Treeswift',
    'Plume-toed Swiftlet',
    'Black-nest Swiftlet',
    "Germain's Swiftlet",
    'Silver-rumped Spinetail',
    'White-throated Needletail',
    'Silver-backed Needletail',
    'Brown-backed Needletail',
    'Asian Palm Swift',
    'Common Swift',
    'Pacific Swift',
    'House Swift',
    'Greater Coucal',
    'Lesser Coucal',
    'Chestnut-bellied Malkoha',
    'Chestnut-winged Cuckoo',
    'Jacobin Cuckoo',
    'Asian Koel',
    'Asian Emerald Cuckoo',
    'Violet Cuckoo',
    "Horsfield's Bronze Cuckoo",
    'Little Bronze Cuckoo',
    'Banded Bay Cuckoo',
    'Plaintive Cuckoo',
    'Rusty-breasted Cuckoo',
    'Square-tailed Drongo-Cuckoo',
    'Large Hawk-Cuckoo',
    'Malaysian Hawk-Cuckoo',
    "Hodgson's Hawk-Cuckoo",
    'Indian Cuckoo',
    'Himalayan Cuckoo',
    'Oriental Turtle Dove',
    'Red Collared Dove',
    'Common Emerald Dove',
    'Zebra Dove',
    'Cinnamon-headed Green Pigeon',
    'Little Green Pigeon',
    'Orange-breasted Green Pigeon',
    'Thick-billed Green Pigeon',
    'Jambu Fruit Dove',
    'Green Imperial Pigeon',
    'Mountain Imperial Pigeon',
    'Pied Imperial Pigeon',
    'Masked Finfoot',
    'Red-legged Crake',
    'Slaty-legged Crake',
    'Slaty-breasted Rail',
    'White-breasted Waterhen',
    "Baillon's Crake",
    'Ruddy-breasted Crake',
    'Band-bellied Crake',
    'White-browed Crake',
    'Watercock',
    'Grey-headed Swamphen',
    'Common Moorhen',
    'Eurasian Coot',
    'Little Grebe',
    'Barred Buttonquail',
    'Beach Stone-curlew',
    'Black-winged Stilt',
    'Pied Stilt',
    'Grey-headed Lapwing',
    'Red-wattled Lapwing',
    'Pacific Golden Plover',
    'Grey Plover',
    'Common Ringed Plover',
    'Little Ringed Plover',
    'Kentish Plover',
    'White-faced Plover',
    'Malaysian Plover',
    'Lesser Sand Plover',
    'Greater Sand Plover',
    'Oriental Plover',
    'Greater Painted-snipe',
    'Pheasant-tailed Jacana',
    'Eurasian Whimbrel',
    'Little Curlew',
    'Far Eastern Curlew',
    'Eurasian Curlew',
    'Bar-tailed Godwit',
    'Black-tailed Godwit',
    'Ruddy Turnstone',
    'Great Knot',
    'Red Knot',
    'Ruff',
    'Broad-billed Sandpiper',
    'Sharp-tailed Sandpiper',
    'Curlew Sandpiper',
    "Temminck's Stint",
    'Long-toed Stint',
    'Spoon-billed Sandpiper',
    'Red-necked Stint',
    'Sanderling',
    'Little Stint',
    'Pectoral Sandpiper',
    'Asian Dowitcher',
    'Pin-tailed Snipe',
    "Swinhoe's Snipe",
    'Common Snipe',
    'Terek Sandpiper',
    'Red-necked Phalarope',
    'Common Sandpiper',
    'Green Sandpiper',
    'Grey-tailed Tattler',
    'Common Redshank',
    'Marsh Sandpiper',
    'Wood Sandpiper',
    'Spotted Redshank',
    'Common Greenshank',
    "Nordmann's Greenshank",
    'Oriental Pratincole',
    'Small Pratincole',
    'Brown-headed Gull',
    'Black-headed Gull',
    'Gull-billed Tern',
    'Caspian Tern',
    'Greater Crested Tern',
    'Lesser Crested Tern',
    'Little Tern',
    'Aleutian Tern',
    'Bridled Tern',
    'Black-naped Tern',
    'Common Tern',
    'Whiskered Tern',
    'White-winged Tern',
    'Parasitic Jaeger',
    'Long-tailed Jaeger',
    "Swinhoe's Storm Petrel",
    'Short-tailed Shearwater',
    'Asian Openbill',
    'Lesser Adjutant',
    'Lesser Frigatebird',
    'Red-footed Booby',
    'Brown Booby',
    'Oriental Darter',
    'Glossy Ibis',
    'Yellow Bittern',
    "Von Schrenck's Bittern",
    'Cinnamon Bittern',
    'Black Bittern',
    'Malayan Night Heron',
    'Black-crowned Night Heron',
    'Striated Heron',
    'Indian Pond Heron',
    'Chinese Pond Heron',
    'Javan Pond Heron',
    'Eastern Cattle Egret',
    'Grey Heron',
    'Great-billed Heron',
    'Purple Heron',
    'Great Egret',
    'Intermediate Egret',
    'Little Egret',
    'Pacific Reef Heron',
    'Chinese Egret',
    'Western Osprey',
    'Black-winged Kite',
    'Crested Honey Buzzard',
    "Jerdon's Baza",
    'Black Baza',
    'Himalayan Vulture',
    'Crested Serpent Eagle',
    'Short-toed Snake Eagle',
    'Bat Hawk',
    'Changeable Hawk-Eagle',
    'Rufous-bellied Eagle',
    'Greater Spotted Eagle',
    'Booted Eagle',
    'Steppe Eagle',
    'Eastern Imperial Eagle',
    'Crested Goshawk',
    'Shikra',
    'Chinese Sparrowhawk',
    'Japanese Sparrowhawk',
    'Besra',
    'Eurasian Sparrowhawk',
    'Eastern Marsh Harrier',
    'Pied Harrier',
    'Black Kite',
    'Brahminy Kite',
    'White-bellied Sea Eagle',
    'Grey-headed Fish Eagle',
    'Grey-faced Buzzard',
    'Common Buzzard',
    'Eastern Barn Owl',
    'Sunda Scops Owl',
    'Oriental Scops Owl',
    'Barred Eagle-owl',
    'Buffy Fish Owl',
    'Spotted Wood Owl',
    'Brown Wood Owl',
    'Brown Hawk-Owl',
    'Northern Boobook',
    'Short-eared Owl',
    'Oriental Pied Hornbill',
    'Black Hornbill',
    'Oriental Dollarbird',
    'Stork-billed Kingfisher',
    'Ruddy Kingfisher',
    'White-throated Kingfisher',
    'Black-capped Kingfisher',
    'Blue-eared Kingfisher',
    'Common Kingfisher',
    'Oriental Dwarf Kingfisher',
    'Pied Kingfisher',
    'Blue-tailed Bee-eater',
    'Blue-throated Bee-eater',
    'Lineated Barbet',
    'Red-crowned Barbet',
    'Coppersmith Barbet',
    'Sunda Pygmy Woodpecker',
    'White-bellied Woodpecker',
    'Banded Woodpecker',
    'Crimson-winged Woodpecker',
    'Laced Woodpecker',
    'Common Flameback',
    'Rufous Woodpecker',
    'Buff-rumped Woodpecker',
    'Great Slaty Woodpecker',
    'Lesser Kestrel',
    'Common Kestrel',
    'Amur Falcon',
    'Eurasian Hobby',
    'Peregrine Falcon',
    'Tanimbar Corella',
    'Yellow-crested Cockatoo',
    'Blue-rumped Parrot',
    'Red-breasted Parakeet',
    'Long-tailed Parakeet',
    'Rose-ringed Parakeet',
    'Coconut Lorikeet',
    'Blue-crowned Hanging Parrot',
    'Black-and-red Broadbill',
    'Green Broadbill',
    'Hooded Pitta',
    'Fairy Pitta',
    'Blue-winged Pitta',
    'Mangrove Pitta',
    'Golden-bellied Gerygone',
    'Black-winged Flycatcher-shrike',
    'Large Woodshrike',
    'Common Iora',
    'Scarlet Minivet',
    'Ashy Minivet',
    'Pied Triller',
    'Lesser Cuckooshrike',
    'Mangrove Whistler',
    'Tiger Shrike',
    'Brown Shrike',
    'Long-tailed Shrike',
    'White-bellied Erpornis',
    'Black Drongo',
    'Ashy Drongo',
    'Crow-billed Drongo',
    'Hair-crested Drongo',
    'Greater Racket-tailed Drongo',
    'Malaysian Pied Fantail',
    'Black-naped Monarch',
    'Indian Paradise Flycatcher',
    "Blyth's Paradise Flycatcher",
    'Amur Paradise Flycatcher',
    'Japanese Paradise Flycatcher',
    'House Crow',
    'Large-billed Crow',
    'Japanese Tit',
    'Eurasian Skylark',
    'Straw-headed Bulbul',
    'Black-and-white Bulbul',
    'Black-headed Bulbul',
    'Black-crested Bulbul',
    'Red-whiskered Bulbul',
    'Sooty-headed Bulbul',
    'Olive-winged Bulbul',
    'Cream-vented Bulbul',
    'Asian Red-eyed Bulbul',
    'Buff-vented Bulbul',
    'Streaked Bulbul',
    'Cinereous Bulbul',
    'Sand Martin',
    'Pacific Swallow',
    'Asian House Martin',
    'Red-rumped Swallow',
    'Yellow-browed Warbler',
    'Dusky Warbler',
    'Eastern Crowned Warbler',
    'Sakhalin Leaf Warbler',
    'Arctic Warbler',
    'Oriental Reed Warbler',
    'Black-browed Reed Warbler',
    'Booted Warbler',
    "Pallas's Grasshopper Warbler",
    'Lanceolated Warbler',
    'Zitting Cisticola',
    'Yellow-bellied Prinia',
    'Common Tailorbird',
    'Dark-necked Tailorbird',
    'Rufous-tailed Tailorbird',
    'Ashy Tailorbird',
    'Chestnut-winged Babbler',
    'Pin-striped Tit-babbler',
    "Abbott's Babbler",
    'Moustached Babbler',
    'Short-tailed Babbler',
    'White-chested Babbler',
    'White-crested Laughingthrush',
    'Chinese Hwamei',
    "Swinhoe's White-eye",
    'Asian Fairy-bluebird',
    'Velvet-fronted Nuthatch',
    'Common Hill Myna',
    'Crested Myna',
    'Common Myna',
    'Black-winged Starling',
    'Red-billed Starling',
    'White-cheeked Starling',
    'Daurian Starling',
    'Chestnut-cheeked Starling',
    'White-shouldered Starling',
    'Brahminy Starling',
    'Rosy Starling',
    'Orange-headed Thrush',
    'Siberian Thrush',
    'Chinese Blackbird',
    'Eyebrowed Thrush',
    'Oriental Magpie-Robin',
    'White-rumped Shama',
    'Grey-streaked Flycatcher',
    'Dark-sided Flycatcher',
    'Asian Brown Flycatcher',
    'Brown-streaked Flycatcher',
    'Ferruginous Flycatcher',
    'Chinese Blue Flycatcher',
    'Mangrove Blue Flycatcher',
    'Brown-chested Jungle Flycatcher',
    'Blue-and-white Flycatcher',
    "Zappey's Flycatcher",
    'Verditer Flycatcher',
    'Siberian Blue Robin',
    'Yellow-rumped Flycatcher',
    'Narcissus Flycatcher',
    'Green-backed Flycatcher',
    'Mugimaki Flycatcher',
    'Taiga Flycatcher',
    'Daurian Redstart',
    'Blue Rock Thrush',
    'White-throated Rock Thrush',
    "Stejneger's Stonechat",
    'Greater Green Leafbird',
    'Lesser Green Leafbird',
    'Blue-winged Leafbird',
    'Scarlet-breasted Flowerpecker',
    'Thick-billed Flowerpecker',
    'Yellow-vented Flowerpecker',
    'Orange-bellied Flowerpecker',
    'Scarlet-backed Flowerpecker',
    'Ruby-cheeked Sunbird',
    'Brown-throated Sunbird',
    "Van Hasselt's Sunbird",
    'Copper-throated Sunbird',
    'Olive-backed Sunbird',
    'Crimson Sunbird',
    'Little Spiderhunter',
    'Thick-billed Spiderhunter',
    'Yellow-eared Spiderhunter',
    'House Sparrow',
    'Eurasian Tree Sparrow',
    'Streaked Weaver',
    'Baya Weaver',
    'Red Avadavat',
    'White-rumped Munia',
    'Javan Munia',
    'Scaly-breasted Munia',
    'Chestnut Munia',
    'White-headed Munia',
    'Forest Wagtail',
    'Eastern Yellow Wagtail',
    'Citrine Wagtail',
    'Grey Wagtail',
    'White Wagtail',
    'Paddyfield Pipit',
    'Olive-backed Pipit',
    'Red-throated Pipit'
  ];
  String url = "";
  String SelectedBird = "";
  CollectionReference _birdss = FirebaseFirestore.instance.collection('Birds');

  // get key => null; // added this to fix button widget below

  @override
  void initState() {
    super.initState();

    NameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    NameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/canva-photo-editor.png'),
              // image: AssetImage('assets/uploadbg1.png'),
              // image: AssetImage('assets/uploadbg2.png'),
            ),
          ),
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(32),
              children: [
                IconButton(
                  alignment: Alignment.topLeft,
                  color: Colors.white,
                  icon:
                      const Icon(Icons.arrow_back_ios_new_rounded, size: 35.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  "UPLOAD YOUR SIGHTING",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  color: Colors.white,
                  child: DropdownSearch<String>(
                    //mode of dropdown
                    mode: Mode.DIALOG,
                    //to show search box
                    showSearchBox: true,
                    showSelectedItems: true,
                    //list of dropdown items
                    items: ListOfBirds,
                    // label: "Country",
                    selectedItem: NameController.text,
                    onChanged: (data) {
                      print(data);
                      NameController.text = data!;
                    },
                    //show selected item
                  ),
                ),
                // buildEmail(),
                const SizedBox(height: 24),
                description(),
                const SizedBox(height: 24),
                // buildNumber(),
                // const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffFEAA9C),
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () async {
                        await uploadImage();
                        /* Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UploadImageDemo()),*/
                      },
                      icon: Icon(Icons.add_photo_alternate, size: 24),
                      label: Text("Photo"),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: position == null
                            ? Color(0xffFEAA9C)
                            : Color(0xff75E6E7),
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      onPressed: () async {
                        var pos = await location.getLocation();
                        setState(() {
                          position = pos;
                        });
                        /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeoListenPage()),
                      );*/
                      },
                      icon: position == null
                          ? Icon(Icons.add_location_alt_rounded, size: 24)
                          : Icon(Icons.check_circle_outline_rounded, size: 24),
                      label: position == null
                          ? Text("Upload Location")
                          : Text("Upload Success"),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ButtonWidget(
                  text: 'Submit',
                  onClicked: () async {
                    await uploadForm();
                    // final String? name = NameController.text;
                    // final String? description = DescriptionController.text;
                    // if (name != null && position != null && url != null) {
                    //   //var pos = await location.getLocation();
                    //   await _birdss.add({
                    //     "name": NameController.text,
                    //     "timestamp": Timestamp.now(),
                    //     "lat": position.latitude,
                    //     'lng': position.longitude,
                    //     'imgurl': url,
                    //     'description': description
                    //   });
                    // }
                    // // print('Email: ${NameController.text}');
                    // // //print('Password: ${password}');
                    // // print('Description: ${DescriptionController.text}');
                    // // await uploadForm();
                    // await showDialog<String>(
                    //     context: context,
                    //     builder: (BuildContext context) => AlertDialog(
                    //           title: const Text('Submitted Successfully!'),
                    //           content: const Text(
                    //               'Thank you for your submission!\nHappy Birdwatching :)'),
                    //           actions: <Widget>[
                    //             // TextButton(
                    //             //   onPressed: () =>
                    //             //       Navigator.pop(context, 'Cancel'),
                    //             //   child: const Text('Cancel'),
                    //             // ),
                    //             TextButton(
                    //               onPressed: () => Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => MapPage(
                    //                           streamController.stream))),
                    //               child: const Text('OK'),
                    //             ),
                    //           ],
                    //         ));
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildEmail() => TextField(
        //controller: NameController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.black38, width: 1.0),
          ),

          // hintText: 'name@example.com',
          labelText: 'Name of Bird Species',
          labelStyle: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Color(0xffFEAA9C)),
          filled: true,
          fillColor: Colors.white,
          // prefixIcon: Icon(Icons.mail),
          // icon: Icon(Icons.mail),
          //  suffixIcon: emailController.text.isEmpty
          //    ? Container(width: 0)
          //     : IconButton(
          //        icon: Icon(Icons.close),
          //      onPressed: () => emailController.clear(),
          //   ),

          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      );
  // autofocus: true,

  Widget description() => TextField(
        controller: DescriptionController,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderSide: const BorderSide(color: Colors.black38, width: 1.0),
          ),
          hintText:
              'Example: Corner of Carpark C, on highest branch of tallest tree.',
          labelText: 'Specific Description of Location',
          labelStyle: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Color(0xffFEAA9C)),
          filled: true,
          fillColor: Colors.white,
          // prefixIcon: Icon(Icons.mail),
          // icon: Icon(Icons.mail),
          //  suffixIcon: emailController.text.isEmpty
          //    ? Container(width: 0)
          //     : IconButton(
          //        icon: Icon(Icons.close),
          //      onPressed: () => emailController.clear(),
          //   ),
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        // autofocus: true,
      );

  /* Widget buildPassword() => TextField(
        onChanged: (value) => setState(() => this.password = value),
        onSubmitted: (value) => setState(() => this.password = value),
        decoration: InputDecoration(
          hintText: 'Your Password...',
          labelText: 'Password',
          errorText: 'Password is wrong',
          suffixIcon: IconButton(
            icon: isPasswordVisible
                ? Icon(Icons.visibility_off)
                : Icon(Icons.visibility),
            onPressed: () =>
                setState(() => isPasswordVisible = !isPasswordVisible),
          ),
          border: OutlineInputBorder(),
        ),
        obscureText: isPasswordVisible,
      ); */

  /* Widget buildNumber() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Number', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: numberController,
            decoration: InputDecoration(
              hintText: 'Enter number...',
              hintStyle: TextStyle(color: Colors.white70),
              filled: true,
              fillColor: Colors.black,
              border: OutlineInputBorder(),
            ),
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
          ),
        ],
      );*/
  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();

    //Select Image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    var file = File(image!.path);

    if (image != null) {
      var snapshot = await _storage.ref().child(image.name).putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        url = downloadUrl;
      });
    } else {
      print("NO IMAGE RECEIVED");
    }

    //Upload to Firebase
  }

  uploadForm() async {
    final String? name = NameController.text;
    final String? description = DescriptionController.text;
    if (name != null && position != null && url != null) {
      //var pos = await location.getLocation();
      // await _birdss.add({

      widget.uploadCallback(position.latitude, position.longitude,
          NameController.text, description);

      FirebaseFirestore.instance
          .collection("Birds")
          .doc(NameController.text)
          .set({
        "name": NameController.text,
        "timestamp": Timestamp.now(),
        "lat": position.latitude,
        'lng': position.longitude,
        'imgurl': url,
        'description': description
      });
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Submitted Successfully!'),
                content: const Text(
                    'Thank you for your submission!\n\nHappy Birdwatching :)'),
                actions: <Widget>[
                  // TextButton(
                  //   onPressed: () =>
                  //       Navigator.pop(context, 'Cancel'),
                  //   child: const Text('Cancel'),
                  // ),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MapPage(streamController.stream))),
                    child: const Text('OK'),
                  ),
                ],
              ));
    } else if (name != null || position != null || url != null) {
      await showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('Upload Failed!'),
                content: const Text('Please fill up the required inputs!'),
                actions: <Widget>[
                  // TextButton(
                  //   onPressed: () =>
                  //       Navigator.pop(context, 'Cancel'),
                  //   child: const Text('Cancel'),
                  // ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    }
  }
}
