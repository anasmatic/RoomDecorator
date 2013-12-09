package com.anasmatic.roomdecorator.view
{
	import com.anasmatic.roomdecorator.helpers.Constants;
	import com.anasmatic.roomdecorator.view.viewcontroles.ShopAssets;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class HudView extends Sprite
	{
		private var playerName:TextField;
		public var playerLevel:TextField;
		private var playerMoney:TextField;
		
		public function HudView()
		{
			var image:Image = new Image(ShopAssets.getAtlas().getTexture("hud"));
			image.width = Starling.current.viewPort.width;
			addChild(image);
			
			playerName = new TextField(80,20,"Player: Anas",Constants.HUD_FONT_NAME,12,0,true);
			playerName.x = Starling.current.stage.width * 0.5;
			addChild(playerName);
			
			playerLevel = new TextField(60,20,"level 100",Constants.HUD_FONT_NAME,12,0,true);
			playerLevel.x = Starling.current.stage.width - playerLevel.width;
			addChild(playerLevel);
			
			playerMoney = new TextField(80,20,"123456789",Constants.HUD_FONT_NAME,12,0,true);
			playerMoney.x = 70;
			addChild(playerMoney);
		}
	}
}