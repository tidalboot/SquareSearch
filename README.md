# SquareSearch

Search for venues in a particular location using the Foursquare API!

### Summary

I decided to go with a basic list of the most popular venues using the following endpoint from Foursquare:

https://api.foursquare.com/v2/venues/search? __*Location*__

I also limited it to the first ten results for now to keep it simple and easy to use. 

Once the venue data is retrieved the app then makes a call to:

https://api.foursquare.com/v2/venues/ __*Venue ID*__ [/photos?limit=1](https://www.Foursquare.com)

To retrieve data for the first image available for a particular venue. Once retrieved the full URL is constructed using the the prefix, the image size and the suffix, for example the following image:
```json
prefix: "https://igx.4sqi.net/img/general/"
suffix: "/48882870_rDAmyLTluuMOCHviQ5C_3w_9ItfEsoEzoSthJmjlxRU.jpg"
width: 420
height: 720
```

Would be available at:
https://igx.4sqi.net/img/general/420x720/48882870_rDAmyLTluuMOCHviQ5C_3w_9ItfEsoEzoSthJmjlxRU.jpg

These images are being requested and cached using SDWebImage to keep things efficient.

Bar the launch storyboard there are no XIB files and so everything is being built programatically since, going forward, this would make individual elements easier to test on their own rather than as a whole. 

### Testing

Because the data I want to retrieve and test changes often (The number of checkins in particular) I'm running my tests against local mocked versions of the responses for consisten results. 

UI Automation tests would be great to have set up but for time constraints and for such a simple app they've been omitted. 

