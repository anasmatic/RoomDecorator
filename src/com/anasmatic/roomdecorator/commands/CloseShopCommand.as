package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.ShopModel;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class CloseShopCommand extends Command
	{
		
		[Inject]
		public var shopModel:ShopModel;

		[Inject]
		public var event:ShopButtonControlEvent;
		
		
		override public function execute():void
		{
			shopModel.closeShop();
		}
		
	}
}