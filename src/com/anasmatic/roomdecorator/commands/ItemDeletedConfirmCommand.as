package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.RoomViewModel;
	import com.anasmatic.roomdecorator.models.ShopButtonModel;
	import com.anasmatic.roomdecorator.services.RoomDataService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	import com.anasmatic.roomdecorator.models.RoomDataModel;
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	
	public class ItemDeletedConfirmCommand extends Command
	{
		[Inject]
		public var shopButtonModel:ShopButtonModel;
		
		[Inject]
		public var roomDataModel:RoomDataModel;
		
		[Inject]
		public var e:ItemConfirmControlEvent;
		
		[Inject]
		public var roomViewModel:RoomViewModel;
		
		override public function execute():void
		{
			
			roomDataModel.updateMapData(e.vo,true);
			//now that we are in NormalState, show toggle shop button
			shopButtonModel.showButton();
			
			roomViewModel.deleteSelected();
		}
		
	}
}