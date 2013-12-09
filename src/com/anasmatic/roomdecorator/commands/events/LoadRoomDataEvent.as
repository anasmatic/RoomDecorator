package com.anasmatic.roomdecorator.commands.events
{
	import flash.events.Event;
	
	public class LoadRoomDataEvent extends Event
	{
		public static const LOAD_DATA:String = "loadData";
		public function LoadRoomDataEvent(type:String)
		{
			super(type);
		}
		
		public override function clone():Event 
		{
			return new LoadRoomDataEvent(type); 
		}  
	}
}