package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	import com.anasmatic.roomdecorator.models.events.NewItemFromShopEvent;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	
	import flash.events.IEventDispatcher;

	public class RoomViewModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
		
		public function placeNewItemFromShop(furnitureVO:FurnitureVO):void
		{
			//RoomViewMediator is listening to this
			eventDispatcher.dispatchEvent(new NewItemFromShopEvent(NewItemFromShopEvent.INIT_PLACEMENT,furnitureVO));
		}
		
		public function deleteSelected():void
		{
			//to mediator, item is deleted from dataMap, delete it from view
			eventDispatcher.dispatchEvent(new ItemConfirmControlEvent(ItemConfirmControlEvent.ITEM_DELETED));
		}
	}
}