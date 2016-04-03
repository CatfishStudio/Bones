/// <reference path="./src/menu/menu.ts" />
/// <reference path="./src/sevens/sevens.ts" />
/// <reference path="./src/thousand/thousand.ts" />
/// <reference path="./src/preloader/preloader.ts" />

var sound: boolean = true;
var avatar: string = null;

class Game extends Phaser.Game {
    constructor() {
        super(860, 730, Phaser.CANVAS, "content", PreloaderState);
        this.state.add("MenuState", MenuState);
        this.state.add("SevensState", SevensState);
        this.state.add("ThousandState", ThousandState);
    }
}

window.onload = () => {
    /*
    VK.init(function() {
        apiId: 5380703;
    });

    VK.api("photos.get", {album_id: 'profile'}, function(data) { 
        avatar = data.response[data.response.length-1]['src'];
        var game = new Game();
    });
     */
    var game = new Game();
};