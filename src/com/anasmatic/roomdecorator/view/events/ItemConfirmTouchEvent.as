package com.anasmatic.roomdecorator.view.events
{
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	
	import starling.events.Event;

	public class ItemConfirmTouchEvent extends Event
	{
		public static var ACCEPT_TOUCH:String = "acceptTouch";
		public static var DELETE_TOUCH:String = "deleteTouch";
		
		
		public function ItemConfirmTouchEvent(type:String,bubbles:Boolean = false, vo:FurnitureVO=null)
		{
			super(type,false,vo);
		}
		
		
	}
}