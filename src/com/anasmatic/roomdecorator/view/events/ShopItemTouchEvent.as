package com.anasmatic.roomdecorator.view.events
{
	import starling.events.Event;
	
	public class ShopItemTouchEvent extends Event
	{
		public static const SHOP_ITEM_TOUCH_END:String = "shopItemTouchEnd";
		
		public function ShopItemTouchEvent(type:String)
		{
			super(type);
		}
	}
}