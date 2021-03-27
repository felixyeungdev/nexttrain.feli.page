function installServiceWorker() {
    function sleep(ms) {
        return new Promise((resolve) => setTimeout(resolve, ms));
    }
    if ("serviceWorker" in navigator) {
        window.addEventListener("load", function () {
            navigator.serviceWorker
                .register("/sw.js", { scope: "/" })
                .then(function (registration) {
                    console.log("Service Worker Registered");
                    registration.addEventListener("updatefound", (e) => {
                        console.log("New Service Worker Found");

                        let newWorker = registration.installing;
                        newWorker.addEventListener("statechange", (e) => {
                            if (newWorker.state === "installed") {
                                console.log("New Service Installed");
                                if (navigator.serviceWorker.controller) {
                                    newWorker.postMessage({
                                        action: "skipWaiting",
                                    });
                                    console.log(
                                        "New Service Worker Skip Waiting"
                                    );
                                    sleep(1000).then((e) => {
                                        if (false && getAutoUpdate())
                                            window.location.reload();
                                        else if (
                                            confirm(
                                                "Update installed.\nClick OK to use the newer version of NextTrain"
                                            )
                                        )
                                            window.location.reload();
                                    });
                                }
                            }
                        });
                    });
                });

            navigator.serviceWorker.ready.then(function (registration) {
                console.log("Service Worker Ready");
            });
        });
    }
}

installServiceWorker();

function getAutoUpdate() {
    if (window.localStorage.nexttrain_auto_update) {
        return JSON.parse(window.localStorage.nexttrain_auto_update);
    } else return false;
}
