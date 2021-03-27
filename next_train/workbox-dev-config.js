module.exports = {
    globDirectory: "build/web/",
    globPatterns: ["**/*.{html,css,png,js,json,ttf}"],
    globIgnores: ["**/404.html"],
    swDest: "build/web/sw.js",
    maximumFileSizeToCacheInBytes: 5000000,
    swSrc: "src-sw.js",
};
