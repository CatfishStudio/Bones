package bones.data 
{
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Utils 
	{
		
		public static function getRandomInt(min:int, max:int):int 
		{
			return Math.random() * max | 0;
		}
		
	}

}