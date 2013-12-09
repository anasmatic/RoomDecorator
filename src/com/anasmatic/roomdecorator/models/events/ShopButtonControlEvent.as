package com.anasmatic.roomdecorator.models.events
{
	import flash.events.Event;
	
	public class ShopButtonControlEvent extends Event
	{
		public static const OPEN_SHOP:String = "openShop";
		public static const CLOSE_SHOP:String = "closeShop";
		public static const HIDE_SHOP_BUTTON:String = "hideButton";
		public static const SHOW_SHOP_BUTTON:String = "showButton";
		
		/**
		 *after buying new item, close shop , but stay in GameState = EDIT_STATE 
		 */
		public static const CLOSE_SHOP_KEEP_EDIT_STATE:String="closeShopButKeepGameState=Edit";
		
		public function ShopButtonControlEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			return new ShopButtonControlEvent(type);
		}
		
	}
}