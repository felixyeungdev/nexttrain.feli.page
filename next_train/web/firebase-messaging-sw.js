importScripts("https://www.gstatic.com/firebasejs/7.13.1/firebase-app.js");
importScripts(
    "https://www.gstatic.com/firebasejs/7.13.1/firebase-messaging.js"
);

var firebaseConfig = {
    apiKey: "AIzaSyCU6Di1Y-FZ0ncKQgSn8AwE02eZ-7wE4as",
    authDomain: "feli-page.firebaseapp.com",
    databaseURL: "https://feli-page.firebaseio.com",
    projectId: "feli-page",
    storageBucket: "feli-page.appspot.com",
    messagingSenderId: "140818689378",
    appId: "1:140818689378:web:37e101f2dddb0e850e903b",
    measurementId: "G-0Z6GGR1LGP",
};
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();
