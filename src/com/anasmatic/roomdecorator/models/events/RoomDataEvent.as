package com.anasmatic.roomdecorator.models.events
{
	import flash.events.Event;
	
	public class RoomDataEvent extends Event
	{
		public static const DATA_READY:String = "dataReady";
		public static const UPDATE_ROOM_DATA:String = "updateRoomDate";
		
		public var roomData:Object;
		
		public function RoomDataEvent(type:String, roomData:Object) 
		{
			this.roomData = roomData;
			super(type);
		}
		
		public override function clone():Event 
		{
			return new RoomDataEvent(type, roomData);
		}
	}
}