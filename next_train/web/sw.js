importScripts(
	"https://storage.googleapis.com/workbox-cdn/releases/4.3.1/workbox-sw.js"
);

workbox.setConfig({ debug: false });

self.addEventListener("message", function(event) {
	if (event.data.action === "skipWaiting") {
		self.skipWaiting();
	}
});

workbox.routing.registerRoute(
	/^https:\/\/fonts\.gstatic\.com/,
	new workbox.strategies.CacheFirst({
		cacheName: "google-fonts-webfonts",
		plugins: [
			new workbox.cacheableResponse.Plugin({
				statuses: [0, 200]
			}),
			new workbox.expiration.Plugin({
				maxEntries: 30
			})
		]
	})
);

workbox.precaching.precacheAndRoute([
  {
    "url": "assets/AssetManifest.json",
    "revision": "2efbb41d7877d10aac9d091f58ccd7b9"
  },
  {
    "url": "assets/FontManifest.json",
    "revision": "01700ba55b08a6141f33e168c4a6c22f"
  },
  {
    "url": "assets/images/icons/icon_144x144.png",
    "revision": "2690030c3406d89b777368bd4a4633d8"
  },
  {
    "url": "assets/images/icons/icon_192x192.png",
    "revision": "6d0c6a4bbd91bad2bf65b16c5661346b"
  },
  {
    "url": "assets/images/icons/icon_48x48.png",
    "revision": "899073b52fea5492c80a4cf48b4d1238"
  },
  {
    "url": "assets/images/icons/icon_72x72.png",
    "revision": "69ef993af5613dc39d46b36286d37470"
  },
  {
    "url": "assets/images/icons/icon_96x96.png",
    "revision": "6518a89a40f969b86786ad3f5515b5fe"
  },
  {
    "url": "index.html",
    "revision": "1f8de38b02fa4b95b7de3160de053335"
  },
  {
    "url": "index2.html",
    "revision": "07c405c64060e0b0f11e5fd89df4aca9"
  },
  {
    "url": "main.dart.js",
    "revision": "9f1639a84590f86e5cfd51f50a86d237"
  },
  {
    "url": "manifest.json",
    "revision": "52fbfdbd6473fbed38ad81dfecc91c98"
  },
  {
    "url": "swInstall.js",
    "revision": "8f323611b986e9240af8901b18742ede"
  }
]);
