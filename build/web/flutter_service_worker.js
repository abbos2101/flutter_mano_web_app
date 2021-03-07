'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "e77bf25a2e52ac8395591608294c751d",
"assets/assets/background.jpg": "772810d6d61a41931380a3c02c9d6a59",
"assets/assets/comment_solid.png": "60d100cbdfeb253eaf6806f3262cb369",
"assets/assets/error_gif/empty.gif": "82ed03d41241bf01b01a0862b6d0e0aa",
"assets/assets/error_gif/img1.gif": "c686c89177f288cefc5228b01e68ecef",
"assets/assets/error_gif/img2.gif": "ecd9d393162e7564053848c1e825db2a",
"assets/assets/error_gif/img3.gif": "66dc51f7dd063a41e97593be804e2c9f",
"assets/assets/error_gif/img4.gif": "0e7c2eaf0089908c8648beef0c7d5638",
"assets/assets/error_gif/img5.gif": "54599d8d8d6fadfc0a45e0fe38dae5d9",
"assets/assets/error_gif/win.gif": "de386180de84192a63b1c6186bd6e46c",
"assets/assets/icon_back.svg": "d2a7947dfba5cbc246bb96a0a58fe4ea",
"assets/assets/icon_folder.svg": "2028f1860c58845f59a92ffc807385b9",
"assets/assets/icon_help.svg": "1cc8adb32c6a37cbc10d7b50c0d5fff9",
"assets/assets/icon_learn.svg": "b773839a5c94f56c82ac009892b05a3d",
"assets/assets/icon_lesson.svg": "df4fbfd0165afeac0ba595486e2d989c",
"assets/assets/icon_settings.svg": "bfa37adb734535b38d02c58579c18423",
"assets/assets/image_error.png": "b01192deb57d3bee4e8b313901234391",
"assets/assets/img_content_example.png": "7e3101ee5c84fc8dc0835c325f59edca",
"assets/assets/img_content_progress_active.png": "15c9bce82633875e8324b2abfcf9ef1b",
"assets/assets/img_content_progress_inactive.png": "f8d73c0425823ddf78aca549573f083b",
"assets/assets/img_main_progress_active.png": "432481894c16d1f39675889cf732b465",
"assets/assets/img_main_progress_inactive.png": "e6c63651c252fb3e687101061ee5efd2",
"assets/assets/img_page_background.png": "5543a0920747b13027e749e11d2050b6",
"assets/assets/img_splash_background.png": "4375aa7e833415a6d82cbd34089bb977",
"assets/assets/screen1.png": "1bc0aea6e92fdbabe76ad64d7cbafc26",
"assets/assets/screen2.png": "14c7d801e000dbf24630bfbfb3bc3b4f",
"assets/assets/screen3.png": "09c1abd70ecee6c6e0a4c02a83920bbe",
"assets/assets/welcome_result.png": "30103f99f719251f11a50ec1f761d552",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "825b80a33d9f1ad22bf4e0c9ccf39953",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "acfb820120d1b867738b28b78163e97d",
"/": "acfb820120d1b867738b28b78163e97d",
"main.dart.js": "712f7bf44af10f009ae186099f4d035a",
"manifest.json": "f02bbe5cf4ccee2b80a754e6a2419f83",
"version.json": "355b22f848756dc30c55ec7659c77015"
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
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
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
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
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
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
