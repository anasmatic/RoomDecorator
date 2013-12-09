package com.anasmatic.roomdecorator.helpers
{
	import starling.core.Starling;

	public class Constants
	{
		//iso
		public static const CELL_SIZE:uint = 16;
		public static const GRID_SIZE:uint = 18;
		public static const VIEW_SIZE_W:uint = Starling.current.viewPort.width;;
		public static const VIEW_SIZE_H:uint = 20;
		
		//urls
		public static const ROOM_DATA_FILE_URL:String = "/resources/room1data.xml";
		public static const SHOP_DATA_FILE_URL:String = "/resources/shopdata.xml";
		
		//fonts
		public static const HUD_FONT_NAME:String = "Tahoma";
		
		public function Constants()
		{
		}
	}
}