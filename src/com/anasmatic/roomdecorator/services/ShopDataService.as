package com.anasmatic.roomdecorator.services
{
	import com.anasmatic.roomdecorator.helpers.Constants;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import com.anasmatic.roomdecorator.models.ShopModel;

	public class ShopDataService
	{
		[Inject]
		public var model:ShopModel;
		
		public function ShopDataService()
		{}
		
		public function loadShopData():void
		{
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			urlLoader.addEventListener(Event.COMPLETE,onLoadComplete);
			urlLoader.load(new URLRequest(Constants.SHOP_DATA_FILE_URL));
		}
		
		protected function onLoadComplete(e:Event):void
		{
			model.updateShopData(new XML(e.currentTarget.data));			
		}
		
		protected function onIOError(e:IOErrorEvent):void
		{
			trace("ShopDataService.IOError",e);			
		}
	}
}