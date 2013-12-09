package com.anasmatic.roomdecorator.models.events
{
	import flash.events.Event;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	
	public class NewItemFromShopEvent extends Event
	{
		public static const INIT_PLACEMENT:String = "initPlacement";
		
		public var furnitureVO:FurnitureVO;
		
		public function NewItemFromShopEvent(type:String,furnitureVO:FurnitureVO = null)
		{
			this.furnitureVO = furnitureVO;
			super(type);
		}
		
		override public function clone():Event
		{
			return new NewItemFromShopEvent(type,furnitureVO);
		}
		
		
	}
}