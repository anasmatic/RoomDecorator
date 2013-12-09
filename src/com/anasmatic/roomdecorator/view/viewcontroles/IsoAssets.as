package com.anasmatic.roomdecorator.view.viewcontroles
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class IsoAssets
	{
		[Embed(source="assets/graphics/isoroomart.png")]
		public static const AtlasTexture:Class;
		
		[Embed(source="assets/graphics/isoroomart.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		
		private static var gameTextureAtlas:TextureAtlas;
		private static var gameTextures:Dictionary = new Dictionary();
		
		
		/**
		 * returns the Texture Atlas of the game - one instance 
		 * @return TextureAtlas
		 */
		public static function getAtlas():TextureAtlas
		{
			if(gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTexture");
				var xml:XML = XML(new AtlasXML());
				gameTextureAtlas = new TextureAtlas(texture, xml);
			}
			return gameTextureAtlas;
		}
		
		public static function getTexture(textureName:String):Texture
		{
			if(gameTextures[textureName] == undefined)//not found : create it
			{
				var bitmap:Bitmap = new IsoAssets[textureName]();
				gameTextures[textureName] = Texture.fromBitmap(bitmap);
			}
			return gameTextures[textureName];
		}
	}
}