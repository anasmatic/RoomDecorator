package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.models.events.CloseShopEvent;
	import com.anasmatic.roomdecorator.models.events.OpenShopEvent;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	
	import feathers.data.ListCollection;
	
	import flash.events.IEventDispatcher;

	public class ShopModel
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;

		public var shopDataList:ListCollection;
		
		public function ShopModel()
		{
		}
		
		public function updateShopData(shopXML:XML):void
		{
			shopDataList = new ListCollection();
			
			var furnitureVO:FurnitureVO;
			for each (var object:XML in shopXML..object)
			{
				furnitureVO = new FurnitureVO(object.@instance,object.@name,object.@cost,object.@rows,object.@cols);
				shopDataList.addItem(furnitureVO);
			}
			
			updateShopView();
		}
		
		public function updateShopView():void
		{
			//send data to mediator, and tell view it to open.
			eventDispatcher.dispatchEvent(new OpenShopEvent(OpenShopEvent.INIT_OPEN_SHOP,shopDataList));
		}
		
		
		public function openShop():void
		{
			eventDispatcher.dispatchEvent(new OpenShopEvent(OpenShopEvent.OPEN_SHOP));
		}
		
		public function closeShop(isBuying:Boolean = false):void
		{
			eventDispatcher.dispatchEvent(new CloseShopEvent(CloseShopEvent.CLOSE_SHOP,isBuying));
		}
		
		public function buyItem(itemIndex:int):void
		{
			closeShop(true);
			
			//TODO:check money
			//TODO: notify hud
		}
	}
}