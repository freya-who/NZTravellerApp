NZTravellerApp
==============

App for people travelling to New Zealand containing a map with points of Interest, including a description of the POI, a rating, some photos and the coordingates. The app is in German at the moment, because it is intenden for my parents.


I started with the [How To Use UIScrollView to Scroll and Zoom Content](http://www.raywenderlich.com/10518/) tutorial by Ray Wenderlich to create a zoomable map, which can be accessed by clicking on "Maps and Points of Interest".


On the map are shown stars in some locations that are worth visiting, clicking these leads to a description of the location, stars for rating, coordinates and a preview of the photos, which can be clicked to enlarge to picture. 

Screenshots:

![First View](screenshots/first.png "First View is a TableView") ![Map](screenshots/map.png "Scrollable Map with clickable Stars")

![Close Up](screenshots/mapCloseUp.png "Close Up of map when zoomed in") ![Information](screenshots/info.png "Clicking the Star leads to info on the POI")

App is functional, although there still are several bugs.


Things to fix:

- positioning when rotating iPhone/iPad to landscape orientation

- rescale buttons during zoom, differently than zoom/rescale level of map, so that buttons are visible when map zoomed out, but get a lot smaller when zoomed in

- when going from POI info back to map, map is at different position and zoom level

- when clicking on a star while not zoomed in at all before, and then going back to the map, map is completely zoomed in and no zoom is possible. you have to go back to the table view or to a POI info and then back to the map to be able to zoom again

- make first screen not a table view but two nicely designed custom buttons

- make a nice custom background for the POI info pages

- maybe add a switch to switch language from German to English
