package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.ShopModel;
	import com.anasmatic.roomdecorator.services.ShopDataService;
	
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class OpenShopCommand extends Command
	{
		[Inject]
		public var shopDataService:ShopDataService;
		
		[Inject]
		public var shopModel:ShopModel;
		
		override public function execute():void
		{
			if(shopModel.shopDataList != null)// we have shop data already
				shopModel.openShop();
			else
				shopDataService.loadShopData();//and when load is complete it will give it to the model !
		}
		
	}
}