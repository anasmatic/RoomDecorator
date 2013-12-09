package com.anasmatic.roomdecorator.models.events
{
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	
	import flash.events.Event;
	
	public class ItemConfirmControlEvent extends Event
	{
		public static const CREATE:String = "createConfirmView";
		
		public static var ACCEPT_ITEM:String = "acceptItem,Please";
		
		public static var DELETE_ITEM:String = "deleteItem,Please";
		public static var ITEM_DELETED:String = "itemDeleted";
		
		public var vo:FurnitureVO;
		
		public function ItemConfirmControlEvent(type:String,vo:FurnitureVO=null)
		{
			this.vo = vo;
			super(type);
		}
		
		override public function clone():Event
		{
			return new ItemConfirmControlEvent(type,vo);
		}
		
		
	}
}