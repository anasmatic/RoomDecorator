package com.anasmatic.roomdecorator.models.events
{
	import flash.events.Event;
	
	public class CloseShopEvent extends Event
	{
		public static const CLOSE_SHOP:String = "_closeShop";
		
		public var isBuying:Boolean;
	
		public function CloseShopEvent(type:String, isBuying:Boolean=false)
		{
			this.isBuying = isBuying;
			super(type);
		}
		
		override public function clone():Event
		{
			return new CloseShopEvent(type,isBuying);
		}
		
		
	}
}