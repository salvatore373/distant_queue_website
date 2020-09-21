'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "f33ec2138756f0082a98a95a9c9468b5",
"/": "f33ec2138756f0082a98a95a9c9468b5",
"main.dart.js": "e5546ea25a6fab69c2ef443127a00048",
"favicon.png": "238c8b4889c565b09e38f8e1c9648b23",
"icons/Icon-192.png": "2f11e8cdcbfb73cfa2e4d47ecef4dd64",
"icons/Icon-512.png": "a0204fca46170374b7ede46efa5f1dfe",
"manifest.json": "e92e57791731ceaa41e64a63c28ad037",
"assets/AssetManifest.json": "252bb1aa0ed296dda5f991dd6dfebc17",
"assets/NOTICES": "3ff32cfc525eda0f5dd00b74b63b6668",
"assets/FontManifest.json": "9e0649c90f16a7be3d51ab27d6089604",
"assets/packages/flutter_neumorphic/fonts/NeumorphicIcons.ttf": "32be0c4c86773ba5c9f7791e69964585",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.otf": "a68d2a28c526b3b070aefca4bac93d25",
"assets/assets/images/customer.png": "64087c915f0fc8fa373e43ad5972d829",
"assets/assets/illustrations/create_shop.png": "4a74dcc1135600ae0308cd09e77f1c4c",
"assets/assets/illustrations/download_customer.png": "7e4056f8409988c2328967ba3f5e3e38",
"assets/assets/illustrations/download_owner.png": "9cf3e62978a0c45778a3bb3cb554568b",
"assets/assets/illustrations/scan_qr.png": "8ea8668819e8c5e8a4e2b3c180ae28a3",
"assets/assets/illustrations/search.png": "00d732a515d7dd34ef4ab851cee932f8",
"assets/assets/illustrations/show_ticket.png": "1231e9030daffacb538d71878d8ead0f",
"assets/assets/illustrations/contacts.png": "b4dd776325fbb98650bacb40e6a90dfb",
"assets/assets/icons/clinic.png": "439b8b0aaf2195dfd0abeee73840edf7",
"assets/assets/icons/doctor.png": "e06fe736fa5e42d39f7a8a4760b8f229",
"assets/assets/icons/shop.png": "50125ab4c50b2dbd4a89e67d32f4ba13",
"assets/assets/icons/user.png": "ae6d93a2be77d982e82e16abeb8a1c8c",
"assets/assets/icons/restaurant.png": "9548f9720040bff8df841d8e46c68897",
"assets/assets/icons/hairdresser.png": "ef7b8b1068d9d96431aa7211335f1e7a",
"assets/assets/icons/office.png": "32edf3cd5ea57e9e05af6818b2fb24f8",
"assets/assets/icons/supermarket.png": "1e50c7b04b3349ce14f6f037a7c4ce79",
"assets/assets/icons/bank.png": "fc465b11fa5b45ebc55c4926799758ce",
"assets/assets/icons/more.png": "5cb6570b990d7a161bb78f76aec66d1b",
"assets/assets/app-store-badges/app-store-badge-en.png": "57c9331579871f796b50a2cd2da42136",
"assets/assets/app-store-badges/google-play-badge-it.png": "c701b48ca94ef5c3bbdb11c272c27afc",
"assets/assets/app-store-badges/google-play-badge-en.png": "db9b21a1c41f3dcd9731e1e7acfdbb57",
"assets/assets/app-store-badges/app-store-badge-it.png": "781b738f8d0552f574f47f79de46b1e2",
"manifest-original.json": "7caf8d4272b0b8b88840f192f8ac2bf5"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      // Provide a 'reload' param to ensure the latest version is downloaded.
      return cache.addAll(CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');

      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }

      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#')) {
    key = '/';
  }
  // If the URL is not the RESOURCE list, skip the cache.
  if (!RESOURCES[key]) {
    return event.respondWith(fetch(event.request));
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache. Ensure the resources are not cached
        // by the browser for longer than the service worker expects.
        var modifiedRequest = new Request(event.request, {'cache': 'reload'});
        return response || fetch(modifiedRequest).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    return self.skipWaiting();
  }

  if (event.message === 'downloadOffline') {
    downloadOffline();
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey in Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
