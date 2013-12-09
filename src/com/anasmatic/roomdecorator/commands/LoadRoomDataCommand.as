package com.anasmatic.roomdecorator.commands
{
	import robotlegs.bender.bundles.mvcs.Command;
	import com.anasmatic.roomdecorator.services.RoomDataService;
	
	public class LoadRoomDataCommand extends Command
	{
		[Inject]
		public var service:RoomDataService 
		
		public override function execute():void
		{
			service.loadRoomData();
		}
	}
}