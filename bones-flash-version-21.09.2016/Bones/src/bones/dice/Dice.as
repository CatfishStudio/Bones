package bones.dice 
{
	import starling.display.MovieClip;
	
	import bones.data.Atlases;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Dice extends MovieClip 
	{
		
		public function Dice() 
		{
			Atlases.setTextureAtlasEmbeddedAsset(Atlases.AtlasDice1, Atlases.XmlAtlasDice1);
			super(Atlases.textureAtlas.getTextures("dice_"), 12);
			loop = true;
		}
		
	}

}