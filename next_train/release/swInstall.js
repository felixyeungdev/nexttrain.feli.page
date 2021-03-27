function installServiceWorker() {
    if ("serviceWorker" in navigator) {
        window.addEventListener("load", function() {
            navigator.serviceWorker
                .register("/sw.js", { scope: "/" })
                .then(function(registration) {
                    console.log("Service Worker Registered");
                    registration.addEventListener("updatefound", e => {
                        console.log("New Service Worker Found");

                        let newWorker = registration.installing;
                        newWorker.addEventListener("statechange", e => {
                            if (newWorker.state === "installed") {
                                console.log("New Service Installed");
                                if (navigator.serviceWorker.controller) {
                                    newWorker.postMessage({
                                        action: "skipWaiting"
                                    });
                                    console.log(
                                        "New Service Worker Skip Waiting"
                                    );
                                }
                            }
                        });
                    });
                });

            navigator.serviceWorker.ready.then(function(registration) {
                console.log("Service Worker Ready");
            });
        });
    }
}

installServiceWorker();
