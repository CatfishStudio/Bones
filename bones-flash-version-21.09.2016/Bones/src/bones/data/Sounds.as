package bones.data 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import bones.Config;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Sounds 
	{
		public static var musicMelody:Sound;
		public static var musicChannel:SoundChannel;
		public static var sound:Sound;
		
		[Embed(source = '../../../assets/sounds/sound1.mp3')]
		public static var Sound1:Class;
		
		[Embed(source = '../../../assets/sounds/sound2.mp3')]
		public static var Sound2:Class;
		
		[Embed(source = '../../../assets/sounds/sound3.mp3')]
		public static var Sound3:Class;
		
		[Embed(source = '../../../assets/sounds/sound4.mp3')]
		public static var Sound4:Class;
		
		public static function PlaySound(SoundClass:Class):void
		{
			if (Config.soundOn)
			{
				sound = new SoundClass() as Sound;
				sound.play();
			}
		}
		
		public static function StopSound():void
		{
			
		}
	}

}