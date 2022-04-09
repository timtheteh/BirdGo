<img src = "App\android\app\src\main\res\mipmap-hdpi\ic_launcher.png" />


# BirdGO


## What is BirdGO?
BirdGO is a companion app to both budding and experienced birdwatchers alike! Use BirdGO to track recent bird sightings, share your own sightings, and see predictions for the most likely birds in sectors.

# Functions

1. **Fully functional and interactive map**
    - Based on Google Maps API
2. **Hotspot Flags**
    - Where several birds have previously been sighted
    - Clicking on flags reveals pictures of birds which have been sighted in the area
    - All these pictures are clickable to reveal indepth information about bird
    - Small info window above flag indicates address of hotspot and most recent bird sighted
3. **Upload your sightings of birds**
    - Choose from list of bird (List is text searchable)
    - Input the bird's location description and photo of that bird
    - Upload your location
4. **View other people's uploads of birds**
    - Pins indicate such occurences
    - Info window tells you bird name and location description
    - Shows bird information panel (See 5)
5. **Bird Information Panel**
    - See a picture and name of bird!
    - Rarity ratings based on NParks classification
    - Prediction of sighting based on trained algorithm (See predictions)
6. **Predictions**
    - New mappage populated with 8 most popular birdwatching hotspots in Singapore
    - For more, see how these predictions were calculated in Predictions
7. **Top 3 Birds**
    - On startup, see our Top 3 birds, sorted by their rarity and chance of occurence
8. **Encylopedia and Search**
    - With encylopedia, see all the birds in Singapore, with an info page generated for each bird showing number of occurences
    - With search, find and see the info panel of birds
    - Both functions have links to Wikipedia for more indepth reading


## Predictions
The predictions are calculated simply by using a 1/2^x, where x is the number of years since the occurence. Data is filtered by the time period (which is considered a bimonthly cycle, which is considered a high enough resolution to accurately pick out the likelyhood of birds occuring). 

### General Prediction Accuracy
Achieved ***86.341% Accuracy*** based on 398 birds. Tested on the year 2020, by training the algorithm on years before 2020. Success is calculated based on if bird is sighted in 2020 within the allocated time period.
To run this test, use
``` 
$ python3 BirdPredictAlgo2.py # Generate predictions based on data < 2020
$ python3 testingPredGeneral.py
```

### Hotspot Prediciton Testing
Hotspot predictions managed a ***60% accuracy*** out of the 10 hotspots identified for testing on 2020 data while trained on data before 2020. Success is based on whether the most popular bird is sighted again within a 4km radius of the hotspot (Approximate range of the largest hotspot, MacRitchie Reservoir Park, and the training data that used for the algorithm)

To run this test, use
``` 
$ python3 BirdPredictAlgo3.py # Trains on data < 2020
$ python3 testingPredHotspotMax.py
```

### Improvements to predictions
- Refine the model, and use statistical methods to build a better prediction equation
- Use a simple neural net to train on this dataset


## Tech Stack
BirdGO is built on the flutterfire stack, and uses python to parse code from the eBirds API.


## Team
Bryan Ong, Chua Yong Xuan, Tan Jia Min, Timothy Teh, Lim Xin Yi, Jared Tan

---
Nanyang Technological University | SCSE

2021/2022

CZ2006 Software Engineering
