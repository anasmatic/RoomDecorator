package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.RoomDataModel;
	import com.anasmatic.roomdecorator.models.ShopButtonModel;
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ItemAcceptedConfirmCommand extends Command
	{
		[Inject]
		public var shopButtonModel:ShopButtonModel;
		
		[Inject]
		public var roomDataModel:RoomDataModel;
		
		[Inject]
		public var e:ItemConfirmControlEvent;
		
		override public function execute():void
		{
			roomDataModel.updateMapData(e.vo);
			//now that we are in NormalState, show toggle shop button
			shopButtonModel.showButton();
		}
		
	}
}