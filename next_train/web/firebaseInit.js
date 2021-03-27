document.addEventListener("DOMContentLoaded", async (e) => {
    console.log("Initalising Services");
    var firebaseConfig = {
        apiKey: "AIzaSyCU6Di1Y-FZ0ncKQgSn8AwE02eZ-7wE4as",
        authDomain: "feli-page.firebaseapp.com",
        databaseURL: "https://feli-page.firebaseio.com",
        projectId: "feli-page",
        storageBucket: "feli-page.appspot.com",
        messagingSenderId: "140818689378",
        appId: "1:140818689378:web:b50d04baa952c2ae0e903b",
        measurementId: "G-0Z6GGR1LGP",
    };
    firebase.initializeApp(firebaseConfig);

    const messaging = firebase.messaging();
    messaging
        .requestPermission()
        .then(function () {
            console.log("Notification Permission Granted");
            return messaging.getToken();
        })
        .then(function (token) {
            console.log(`Got Token: ${token}`);
        })
        .catch(function (err) {
            console.log("Notification Permission Denied");
        });

    messaging.onMessage(function (payload) {
        console.log(payload);
    });

    const analytics = firebase.analytics();

    const remoteConfig = firebase.remoteConfig();

    remoteConfig.settings = {
        minimumFetchIntervalMillis: 30000,
    };

    remoteConfig.defaultConfig = {
        nexttrain_auto_update: false,
    };

    await remoteConfig.fetchAndActivate();

    const autoUpdate = remoteConfig.getBoolean("nexttrain_auto_update");

    console.log(`Auto Update: ${autoUpdate}`);

    window.localStorage.nexttrain_auto_update = JSON.stringify(autoUpdate);
});
