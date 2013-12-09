package com.anasmatic.roomdecorator.services
{
	import com.anasmatic.roomdecorator.helpers.Constants;
	import com.anasmatic.roomdecorator.models.RoomDataModel;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class RoomDataService
	{
		[Inject]
		public var model:RoomDataModel;
		
		public function loadRoomData():void
		{
			
			//var file:File = File.userDirectory.resolvePath(Constants.ROOM_DATA_FILE_URL);
			var urlLoader:URLLoader = new URLLoader();
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			urlLoader.addEventListener(Event.COMPLETE,onLoadComplete);
			urlLoader.load(new URLRequest(Constants.ROOM_DATA_FILE_URL));
			
			
		}
		
		protected function onLoadComplete(e:Event):void
		{
			model.updateRoomData(new XML(e.currentTarget.data));
		}
		
		protected function onIOError(e:IOErrorEvent):void
		{
			trace("IOError",e);
		}
		
		public function saveRoomData():void
		{
			// TODO save in database, then pass to model to save it there for collision detection purposes
			
		}
	}
}