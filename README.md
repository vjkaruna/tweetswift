Tweetswift
===========

Client for Twitter in Swift, for Codepath.
(To change Twitter app Consumer Key / Secret, modify the top of tweetswift/models/TwitterClient.swift)

![Screenshot](https://raw.githubusercontent.com/vjkaruna/tweetswift/master/tweetswift.gif)

Time spent: approx. 12 hours

Implementation
===========
Used the BDBOAuth1RequestOperationManager extension to AFNetworking, for OAuth 1.0a requests.
Used the NSUserDefaults dictionary to save user data between instances.
Used TTTAttributedText category for tweet text.
Used a separate xib for PullToRefresh in the table header.


Required Tasks
============

- Pull to Refresh.
- Compose and reply to tweets.
- Tweet details page.
- Favoriting and native retweeting.
- User details saved between instances.
- Log out.
- Retweeted header on tweets (constraints added/removed when not applicable.)

- 
