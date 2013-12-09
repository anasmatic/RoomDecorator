package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.ItemConfirmModel;
	import com.anasmatic.roomdecorator.models.RoomViewModel;
	import com.anasmatic.roomdecorator.models.ShopButtonModel;
	import com.anasmatic.roomdecorator.models.ShopModel;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.view.events.ShopItemSelectedEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class BuyShopItemCommand extends Command
	{
		[Inject]
		public var event:ShopItemSelectedEvent;
		
		[Inject]
		public var shopModel:ShopModel;
		
		[Inject]
		public var shopButtonModel:ShopButtonModel;
		
		[Inject]
		public var shopItemConfermModel:ItemConfirmModel;
		
		[Inject]
		public var roomViewModel:RoomViewModel;
		
		override public function execute():void
		{
			//iform model, so it may hide the shop voew
			shopModel.buyItem(event.itemIndex);
			
			//hide toggle shop button
			shopButtonModel.hideButton();
			
			//place item first on map!
			var vo:FurnitureVO = shopModel.shopDataList.getItemAt(event.itemIndex) as FurnitureVO;
			roomViewModel.placeNewItemFromShop(vo.clone());
			
			//then init its listeners - confirm buttons are created inside the item we've just bought
			shopItemConfermModel.initConfirmButtons();
			
		}
		
	}
}