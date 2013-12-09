package com.anasmatic.roomdecorator
{
	import com.anasmatic.roomdecorator.view.HudView;
	import com.anasmatic.roomdecorator.view.RoomView;
	import com.anasmatic.roomdecorator.view.ShopButtonView;
	import com.anasmatic.roomdecorator.view.ShopView;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded():void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			addChild(new RoomView());
			addChild(new HudView());
			addChild(new ShopView());
			addChild(new ShopButtonView());
		}
	}
}