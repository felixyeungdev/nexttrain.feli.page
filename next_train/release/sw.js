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
    "url": "index.html",
    "revision": "77d68fadb192137392180d9569b4e6b8"
  },
  {
    "url": "main.dart.js",
    "revision": "8c71f8949a773847564da3f0d9ac7189"
  },
  {
    "url": "swInstall.js",
    "revision": "8f323611b986e9240af8901b18742ede"
  }
]);
