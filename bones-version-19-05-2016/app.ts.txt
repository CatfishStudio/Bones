/// <reference path="./src/menu/menu.ts" />
/// <reference path="./src/sevens/sevens.ts" />
/// <reference path="./src/thousand/thousand.ts" />
/// <reference path="./src/preloader/preloader.ts" />

var sound: boolean = true;
var avatar: string = null;
var userFirstName: string = null;
var userLastName: string = null;
var userRatingThousand: number = 0;
var userRatingSevens: number = 0;

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

    VK.api("users.get", function(data) {
        userFirstName = data.response[0].first_name;
        userLastName = data.response[0].last_name;
    });

    VK.api("photos.get", {album_id: 'profile'}, function(data) { 
        avatar = data.response[data.response.length-1]['src'];
        var game = new Game();
    });
    
     */
    var game = new Game();
};