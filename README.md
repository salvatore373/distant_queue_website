<center> <img height=116px alt='DistantQueue logo' src='https://github.com/salvatore373/distant_queue_website/raw/master/assets/images/customer_icon.png'/></center>

# DistantQueue - website ([link](http://distant-queue.com))
This is the project of a website to introduce potential users to the DistantQueue service. It was developed with Flutter, but only for web purpose.

## The DistantQueue service
DistantQueue is a service that allows its users to "skip the line" in any kind of business. It is made up of two apps: *DistantQueue - Customer* that you can use to book the "jump-the-line" tickets that allow you to avoid queues, and *DistantQueue - Owner* that you can use to manage your business registered to DistantQueue. The apps are available on both Google Play and the App Store.

| **DistantQueue - Customer** | <a href='https://play.google.com/store/apps/details?id=com.distant_queue.customer'><img height=64 alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a> | [![customer app on app store](https://raw.githubusercontent.com/salvatore373/distant_queue_website/master/assets/app-store-badges/app-store-badge-en.png =x56)](https://apps.apple.com/app/id1523551412) |
|--|--|--|
| **DistantQueue - Owner** | <a href='https://play.google.com/store/apps/details?id=com.distant_queue.owner'><img height=64px alt='Get it on Google Play' src='https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png'/></a> | [![owner app on app store](https://raw.githubusercontent.com/salvatore373/distant_queue_website/master/assets/app-store-badges/app-store-badge-en.png =x56)](https://apps.apple.com/app/id1523553911) |



## The structure
### The website structure
The website structure is very simple and contains only 4 routes. The first one is the home route ([`lib/routes/home_route.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/routes/home_route.dart)), which briefly explains what the product is meant to do and why users should choose it, and redirects the two categories of potential users to the appropriate route: either the "For Businesses" route or the "For Customers" route.
In the "For Businesses" route ([`lib/routes/for_businesses.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/routes/for_businesses_route.dart)) I explain to the business owners how they should use DistantQueue in their business. In the "For Customers" route ([`lib/routes/for_customers.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/routes/for_customers_route.dart)) I explain the customers how to skip the line in the businesses that use DistantQueue.
Moreover, there is a "Contacts" route ([`lib/routes/contacts_route.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/routes/contacts_route.dart)), that users can use to contact me if they have any question.

### The code structure
All the routes are built upon a base route ([`lib/commons/base_route.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/commons/base_route.dart)). It consists of the base structure of a route in this project, with a navigation bar on top, a footer at the bottom and the content of the route in between. The base route structure evolves in a more complex structure used for the "For Customers" and "For Businesses" routes, that takes the name of `IllustratedBaseRoute` and resides in [`lib/commons/users_base_route.dart`](https://github.com/salvatore373/distant_queue_website/blob/master/lib/commons/users_base_route.dart). It re-uses the base structure of the base route, but adds a header and a sub-header at the top, and a series of described illustrations below.

## Flutter web
The whole DistantQueue service is built upon Flutter, but, while the *Customer* and *Owner* apps use the stable version of the framework, the website uses a beta version with web support. For this reason, you could experience some problems while visiting the website. I am committed to update this project to the stable version as soon as it is available.
I decided to use Flutter web anyway to start exploring and to get confidence with this new platform, that will surely expand in the near future.

### Purpose of this project
The main purpose of this website, as I stated at the beginning of this README, is to introduce potential users to the DistantQueue service. However, I decided to make it open source and to publish it on GitHub to provide the community with a nice Flutter Web real-life experiment, that anyone can play with. This is not a playground meant only for development purposes, but a website that was developed for real reasons and will have a real feedback, and that anyone can use to get in touch with a new platform.
As any other GitHub project, anyone can contribute to this project, providing any kind of help or suggestions.

### Issues
 - [ ] **Neumorphic design slows up home page**
While testing the website I found out that the home page is much slower than the other routes, and you can check this just by scrolling the page down. I suppose that this problem is related to the neumorphic widgets that I use in the home route, because everything's fine in the routes that are not using them.