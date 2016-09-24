package bones.data 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Catfish Studio
	 */
	public class Atlases 
	{
		
		[Embed(source = '../../../assets/atlas/dice_1_atlas.png')]
		public static var AtlasDice1:Class;
		[Embed(source = '../../../assets/atlas/dice_1_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice1:Class;
		
		[Embed(source = '../../../assets/atlas/dice_2_atlas.png')]
		public static var AtlasDice2:Class;
		[Embed(source = '../../../assets/atlas/dice_2_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice2:Class;
		
		[Embed(source = '../../../assets/atlas/dice_3_atlas.png')]
		public static var AtlasDice3:Class;
		[Embed(source = '../../../assets/atlas/dice_3_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice3:Class;
		
		[Embed(source = '../../../assets/atlas/dice_4_atlas.png')]
		public static var AtlasDice4:Class;
		[Embed(source = '../../../assets/atlas/dice_4_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice4:Class;
		
		[Embed(source = '../../../assets/atlas/dice_5_atlas.png')]
		public static var AtlasDice5:Class;
		[Embed(source = '../../../assets/atlas/dice_5_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice5:Class;
		
		[Embed(source = '../../../assets/atlas/dice_6_atlas.png')]
		public static var AtlasDice6:Class;
		[Embed(source = '../../../assets/atlas/dice_6_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDice6:Class;
		
		[Embed(source = '../../../assets/atlas/dice_black_atlas.png')]
		public static var AtlasDiceBlack:Class;
		[Embed(source = '../../../assets/atlas/dice_black_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDiceBlack:Class;
		
		[Embed(source = '../../../assets/atlas/dice_blue_atlas.png')]
		public static var AtlasDiceBlue:Class;
		[Embed(source = '../../../assets/atlas/dice_blue_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDiceBlue:Class;
		
		[Embed(source = '../../../assets/atlas/dice_win_atlas.png')]
		public static var AtlasDiceWin:Class;
		[Embed(source = '../../../assets/atlas/dice_win_atlas.xml', mimeType='application/octet-stream')]
		public static var XmlAtlasDiceWin:Class;
		
		public static var textureAtlas:TextureAtlas;
		public static var textureAtlasAnimation:TextureAtlas;
		
		public static function setTextureAtlasFromBitmap(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			var bitmap:Bitmap = new ClassAtlasSprite();
			
			if (textureAtlas == null)
			{
				textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			}
			else
			{
				textureAtlas.dispose();
				textureAtlas = null;
				textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
			bitmap = null;
			
			trace("[ATLASES] Загрузка Атласа: Ftom Bitmap");
		}
		
		public static function setTextureAtlasEmbeddedAsset(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			
			if (textureAtlasAnimation == null)
			{
				textureAtlasAnimation = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			else
			{
				textureAtlasAnimation.dispose();
				textureAtlasAnimation = null;
				textureAtlasAnimation = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
			
			trace("[ATLASES] Загрузка Атласа: Ftom Bitmap");
		}
		
		public static function disposeTextureAtlas():void
		{
			if (textureAtlas != null)
			{
				textureAtlas.dispose();
				textureAtlas = null;
			}
			if (textureAtlasAnimation != null)
			{
				textureAtlasAnimation.dispose();
				textureAtlasAnimation = null;
			}
			trace("[ATLASES] Очистка: глобальных атласов");
		}
		
	}

}