package com.anasmatic.roomdecorator.models.events
{
	import feathers.data.ListCollection;
	
	import flash.events.Event;
	
	public class OpenShopEvent extends Event
	{
		/**
		 *open shop view for the first time, so this event is carring shopData. 
		 */
		public static const INIT_OPEN_SHOP:String = "initOpenShop";
		
		/**
		 * open shop view, data was already sent. so shopData is null.
		 */
		public static const OPEN_SHOP:String = "_openShop";
		
		public var shopData:ListCollection;
		
		public function OpenShopEvent(type:String, shopData:ListCollection=null)
		{
			this.shopData = shopData;
			
			super(type);
		}
		
		override public function clone():Event
		{
			return new OpenShopEvent(type, shopData);
		}
		
		
	}
}