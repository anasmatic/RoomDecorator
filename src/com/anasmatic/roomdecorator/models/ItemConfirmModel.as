package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	
	import flash.events.IEventDispatcher;

	public class ItemConfirmModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function ItemConfirmModel():void
		{
		}
		
		public function initConfirmButtons():void
		{
			//ItemConfirmMediator is listening for this
			eventDispatcher.dispatchEvent(new ItemConfirmControlEvent(ItemConfirmControlEvent.CREATE));
		}
		
	}
}