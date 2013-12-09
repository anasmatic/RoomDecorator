package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	
	import flash.events.IEventDispatcher;

	public class ShopButtonModel
	{
		
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function showButton():void
		{
			eventDispatcher.dispatchEvent(new ShopButtonControlEvent(ShopButtonControlEvent.SHOW_SHOP_BUTTON));
		}
		
		public function hideButton():void
		{
			eventDispatcher.dispatchEvent(new ShopButtonControlEvent(ShopButtonControlEvent.HIDE_SHOP_BUTTON));
		}
	}
}