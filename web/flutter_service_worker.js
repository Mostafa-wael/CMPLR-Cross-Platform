'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "aa726425352238006c96efc67c487670",
"assets/assets/fonts/favorit/favorit-85-cf2f6136.woff2": "8ff1c98609ef41db2b16727d71c2ed43",
"assets/assets/fonts/favorit/FavoritPro-Regular.ttf": "7227d22dc5e8d12716f1f1733f0b364c",
"assets/assets/fonts/helvetica_medium/Helvetica-Neue-Medium-Extended.ttf": "365834cfa7beb7ca64c00476397ddc32",
"assets/assets/fonts/helvitica_light/Helvetica-Neue-UltraLight.ttf": "513e00a92551c7f365c8d2d6cb475658",
"assets/assets/fonts/OpenSans/OpenSans-Bold.ttf": "5bc6b8360236a197d59e55f72b02d4bf",
"assets/assets/fonts/OpenSans/OpenSans-Light.ttf": "3dd221ea976bc4c617c40d366580bfe8",
"assets/assets/fonts/OpenSans/OpenSans-Regular.ttf": "3eb5459d91a5743e0deaf2c7d7896b08",
"assets/assets/images/1.png": "22fafb544818bf976f6e3c3f89ec2abd",
"assets/assets/images/2.png": "91ae2496aed4ff968b3c3fa8f2f622bd",
"assets/assets/images/3.png": "357f7829b3404a8f0f218cc94313d7d9",
"assets/assets/images/4.png": "4f00f0fe1e73f7e42ed20da520cdbcbd",
"assets/assets/images/404.png": "7cbb9dd8bebd0b60167bf03de98ffa5d",
"assets/assets/images/5.png": "9386db95a45f70edc7406dd4d65ce29a",
"assets/assets/images/6.png": "ccdd3ff15f81bb39443947a4cc2a4da8",
"assets/assets/images/7.png": "cd1a65804f8ddbf8e3dfeee42641ea74",
"assets/assets/images/8.png": "609ca4a22376d3ce39c8dda21702d8c2",
"assets/assets/images/9.png": "e0b3f435507c43268f47e8836c46706a",
"assets/assets/images/capital_letter.png": "44b52c9504e9f3c2333d90fd0992b9d6",
"assets/assets/images/cat.png": "4f6c3b373a3c654b89b6d38008dde982",
"assets/assets/images/confused-face.png": "6d855ab6417696e18e1331bdd727c150",
"assets/assets/images/create_post.png": "4c7bbbae38c7ac3a5971c8ba7e6d02b9",
"assets/assets/images/create_tumblr.png": "0330be81b9ae8cf656f809b2f698e424",
"assets/assets/images/empty-box.png": "0c8653b75358b39c5887b65255961f5b",
"assets/assets/images/error.png": "8a7c7ea711962934e8fcc84e1659bde3",
"assets/assets/images/express_ys.png": "8b1a518f5206a36b948b96916f2feeee",
"assets/assets/images/frustrated-face.png": "9bde9fb74a9a10c84f2577525809ebb9",
"assets/assets/images/gif.png": "e57214ae48b69eda9d8c3c79bf42114d",
"assets/assets/images/head_phone.png": "864bc92df80f79ae5da62bb5ef822517",
"assets/assets/images/icons8-add-15.png": "e19b1297635b24f3918b6c8202d34342",
"assets/assets/images/icons8-email-sign-15.png": "ce6b6b628e01ea3da1286388d0f04ff5",
"assets/assets/images/icons8-help-15.png": "54f4e4747cdd9fc94fcc2af857a5a240",
"assets/assets/images/icons8-love-circled-10.png": "352de982a382436d3fa335390cac15cd",
"assets/assets/images/icons8-love-circled-15.png": "5d73b7002a34385b50fbdcee86f991f7",
"assets/assets/images/icons8-love-circled-20.png": "ad0d0c9514b6bdf3c18279c77827c72b",
"assets/assets/images/icons8-love-circled-30.png": "a87d3225ab815702811f5ef7f9fe4bd9",
"assets/assets/images/icons8-love-circled-50.png": "bcf8c021a1017510e369f94042c4117b",
"assets/assets/images/icons8-plus-+-15.png": "f7ff0f3f74da41d653d7ef0b06518cf2",
"assets/assets/images/icons8-repeat-15.png": "d1d5fe5d9222e81d3f29960cfeaf8201",
"assets/assets/images/icons8-repeat-48.png": "9656030dbae2a8a89c82797008a58292",
"assets/assets/images/icons8-speech-15.png": "3ea00deff0c5538114acc97b5d2ffe1b",
"assets/assets/images/icons8-speech-50.png": "2b955bf60d1b6edbb269bc3f8c6248b6",
"assets/assets/images/icons8-sync-15.png": "a48a0d665ec0e841c90b2fe089af4633",
"assets/assets/images/interactions.jpeg": "70355e8fd19de1eed632b87178af4eaa",
"assets/assets/images/intro_1.gif": "28502d252f2ee372ef49158745672118",
"assets/assets/images/intro_2.gif": "34d0a0e7ff21a86245c35a30089c4c88",
"assets/assets/images/intro_2.webp": "34d0a0e7ff21a86245c35a30089c4c88",
"assets/assets/images/intro_2_delayed.gif": "d090f20924d33191081a1178130371fa",
"assets/assets/images/intro_3.jpg": "d50006c04231d1f3465b776cff88c915",
"assets/assets/images/intro_4.jpg": "115fe7fc625df13bb19217254b874a4a",
"assets/assets/images/intro_5.gif": "bf49f5ddc00d1d552841d68f8a312467",
"assets/assets/images/logo.png": "7472a9c1bc5c05e3224f240780ef1e1c",
"assets/assets/images/logo_letter.png": "8e5c10e9cf3a4f1df47a862cb41250af",
"assets/assets/images/profile_pic.png": "0ccfef106bc895e96a12b0de099154f6",
"assets/assets/images/profile_Placeholder.png": "77f5794e2eb49f7989b8f85e92cfa4e0",
"assets/assets/images/quote.png": "9d4dd1e5f5813cc7d58a8ef89a2f0d20",
"assets/assets/images/search_1.jpg": "c858ebc176310551d23d3d8033c71e66",
"assets/assets/images/search_2.jpg": "0cdfbf017fb38fbc7971c36cffeccd7a",
"assets/assets/images/search_3.jpg": "2ed2cc682f1f2a09e5fe4dabe046dbd6",
"assets/assets/images/search_4.jpg": "870feb1d9915514d026c4487b8d9ad38",
"assets/assets/images/search_5.png": "8adc17314dd5a5ab55dba1eed89043a2",
"assets/assets/images/search_6.jpg": "9bedc1e9739f15716ab7160ba199899f",
"assets/assets/images/search_7.jpg": "2280ffaa83ada32121e6498ddbc445a2",
"assets/assets/images/search_8.jpg": "c37995639a110d8a09baa37cc22bd613",
"assets/assets/images/search_9.jpg": "727b34256de67751ff04b4106c25618d",
"assets/assets/images/smile_chat.svg": "1f77d88b3fa3aa157880d281e27a9837",
"assets/assets/images/tumbler_logo.jpg": "b636af816e7611fe02754adc30364249",
"assets/assets/images/tumblr-24.png": "0e0c6a143050bec5f27c737b88acc437",
"assets/assets/images/video_camera.png": "8de4c5df99cfb3239372eb01ef6821aa",
"assets/assets/images/women.png": "d4f93918ad07d8532f3b8a06814eb082",
"assets/FontManifest.json": "80aa7a2a2f975f1f24d75195f16bdfb7",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/lib/mock.json": "4c469f7a6671c2ff77f2be9aba088055",
"assets/NOTICES": "d21d09a107836d94f6cd13a06cf4f691",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b37ae0f14cbc958316fac4635383b6e8",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5178af1d278432bec8fc830d50996d6f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "aa1ec80f1b30a51d64c72f669c1326a7",
"assets/packages/html_editor_enhanced/assets/font/summernote.eot": "f4a47ce92c02ef70fc848508f4cec94a",
"assets/packages/html_editor_enhanced/assets/font/summernote.ttf": "82fa597f29de41cd41a7c402bcf09ba5",
"assets/packages/html_editor_enhanced/assets/font/summernote.woff": "c1a96d26d30d9e0b2fd33c080d88c72e",
"assets/packages/html_editor_enhanced/assets/font/summernote.woff2": "f694db69cded200e4edd999fddef81b7",
"assets/packages/html_editor_enhanced/assets/jquery.min.js": "b61aa6e2d68d21b3546b5b418bf0e9c3",
"assets/packages/html_editor_enhanced/assets/plugins/summernote-at-mention/summernote-at-mention.js": "8d1a7c753cf1a4cd0058e31fa1e5376e",
"assets/packages/html_editor_enhanced/assets/summernote-lite-dark.css": "3f3cb618d1d51e3e6d0d4cce469b991b",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.css": "cadfcf986f26d830521e9a63350f4dbd",
"assets/packages/html_editor_enhanced/assets/summernote-lite.min.js": "4fe75f9b35f43da141d60d6a697db1c1",
"assets/packages/html_editor_enhanced/assets/summernote-no-plugins.html": "89ca56cd85a91f1dc39f5413204e24d0",
"assets/packages/html_editor_enhanced/assets/summernote.html": "8ce8915ee5696d3c568e94911eb0d9bf",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "c37e39c2459d9c86c2e2b374e8d7f585",
"/": "c37e39c2459d9c86c2e2b374e8d7f585",
"main.dart.js": "4c238bcb04b966a55677782dc949a296",
"manifest.json": "f6ce50a16053889876778134c2468e10",
"splash/img/dark-1x.png": "af532e82ab520cf92bdfde5e69295f7e",
"splash/img/dark-2x.png": "56fa193173d3dbbd0043565bc5bd2ab7",
"splash/img/dark-3x.png": "7391c22ef08e0ccfd5e7c6e7fc5fb0c7",
"splash/img/dark-4x.png": "9b654cd02cab6e28d3b422c3038335cc",
"splash/img/light-1x.png": "af532e82ab520cf92bdfde5e69295f7e",
"splash/img/light-2x.png": "56fa193173d3dbbd0043565bc5bd2ab7",
"splash/img/light-3x.png": "7391c22ef08e0ccfd5e7c6e7fc5fb0c7",
"splash/img/light-4x.png": "9b654cd02cab6e28d3b422c3038335cc",
"splash/style.css": "5f33209323f4491c1037d2d05339a86e",
"version.json": "8b5abcc57b166fbd1502541a51530aa2"
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
