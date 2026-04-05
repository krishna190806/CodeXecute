importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.0/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: 'AIzaSyCLh5RNHT13jS0McFKpzcf0C9WnQGtHx1s',
  authDomain: 'codexecute-5dbe8.firebaseapp.com',
  projectId: 'codexecute-5dbe8',
  storageBucket: 'codexecute-5dbe8.firebasestorage.app',
  messagingSenderId: '529708407713',
  appId: '1:529708407713:web:d053d3d85d2181e5f889e0',
});

const messaging = firebase.messaging();
