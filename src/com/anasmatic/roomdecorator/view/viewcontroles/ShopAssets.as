package com.anasmatic.roomdecorator.view.viewcontroles
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class ShopAssets
	{
		[Embed(source="assets/graphics/gamemenus.png")]
		public static const AtlasTexture:Class;
		
		[Embed(source="assets/graphics/gamemenus.xml", mimeType="application/octet-stream")]
		public static const AtlasXML:Class;
		
		private static var shopTextureAtlas:TextureAtlas;
		private static var shopTextures:Dictionary = new Dictionary();
		
		
		/**
		 * returns the Texture Atlas of the game - one instance 
		 * @return TextureAtlas
		 */
		public static function getAtlas():TextureAtlas
		{
			if(shopTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTexture");
				var xml:XML = XML(new AtlasXML());
				shopTextureAtlas = new TextureAtlas(texture, xml);
			}
			return shopTextureAtlas;
		}
		
		public static function getTexture(textureName:String):Texture
		{
			if(shopTextures[textureName] == undefined)//not found : create it
			{
				var bitmap:Bitmap = new ShopAssets[textureName]();
				shopTextures[textureName] = Texture.fromBitmap(bitmap);
			}
			return shopTextures[textureName];
		}
	}
}