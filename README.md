Tweetswift
===========

Client for Twitter in Swift, for Codepath, with Profiles.

(To change Twitter app Consumer Key / Secret, modify the top of tweetswift/models/TwitterClient.swift)

![Screenshot 1](https://raw.githubusercontent.com/vjkaruna/tweetswift/profiles/profile1.gif)
![Screenshot 2](https://raw.githubusercontent.com/vjkaruna/tweetswift/profiles/profile2.gif)

Time spent: approx. 12 hours

Implementation
===========
Used the BDBOAuth1RequestOperationManager extension to AFNetworking, for OAuth 1.0a requests.
Used the NSUserDefaults dictionary to save user data between instances.
Used TTTAttributedText category for tweet text.
Used a separate xib for PullToRefresh in the table header.


Required Tasks
============

- Tray with spring animation.
- Gesture recognizer for opening and closing tray.
- Profile pages with bio and recent tweets.
- Mentions page.
- Tap on avatars to bring up profile.
