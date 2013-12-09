package com.anasmatic.roomdecorator.view.events
{
	/**
	 * used by Feathers Button ShopButtonView, and StarlingMediator ShopButtonMediator 
	 */	
	
	import starling.events.Event;
	
	public class ShopButtonTouchEvent extends Event
	{
		public static const OPEN_SHOP_TOUCH:String = "openShopTouch";
		public static const CLOSE_SHOP_TOUCH:String = "closeShopTouch";
		public static var CLOSE_SHOP_TOUCH_KEEP_EDIT_STATE:String = "closeShopButKeepGameState=EditState";
		
		public function ShopButtonTouchEvent(type:String)
		{
			super(type);
		}
	}
}