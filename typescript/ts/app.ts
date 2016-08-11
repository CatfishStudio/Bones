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
    var game = new Game();
};