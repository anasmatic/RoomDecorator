package com.anasmatic.roomdecorator.view.events
{
	import flash.events.Event;
	
	public class ShopItemSelectedEvent extends Event
	{
		public static const SHOP_ITEM_SELECTED:String = "shopItemSelected";
		public var itemIndex:int;
		
		public function ShopItemSelectedEvent(type:String, itemIndex:int)
		{
			this.itemIndex = itemIndex;
			super(type);
		}
		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			return new ShopItemSelectedEvent(type,itemIndex);
		}
		
		
	}
}