package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.helpers.Constants;
	import com.anasmatic.roomdecorator.models.events.RoomDataEvent;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	
	import flash.events.IEventDispatcher;

	public class RoomDataModel
	{
		//vo
		private var roomWallsXML:XML;
		private var mapData:Vector.<Vector.<String>>;
		
		[Inject]
		public var eventDispatcher:IEventDispatcher
		
		public function updateRoomData(xml:XML):void
		{
			roomWallsXML = xml;
			initFillMapData();
			eventDispatcher.dispatchEvent(new RoomDataEvent(RoomDataEvent.DATA_READY, roomWallsXML));
		}
		
		private function initFillMapData():void
		{
			const GRID_SIZE:int = Constants.GRID_SIZE;
			mapData = new Vector.<Vector.<String>>();
			
			//draw empty map
			var rowVect:Vector.<String>;
			for (var i:int = 0; i < GRID_SIZE; i++) 
			{
				rowVect = new Vector.<String>();
				mapData[i] = rowVect;
				for (var o:int = 0; o < GRID_SIZE; o++)
				{
					rowVect[o] = "";
				}
			}
			//add walls
			for each (var object:XML in roomWallsXML..object) 
			{
				mapData[int(object.@col)][int(object.@row)] = object.@instance;
			}

			eventDispatcher.dispatchEvent(new RoomDataEvent(RoomDataEvent.UPDATE_ROOM_DATA, mapData));
		//	for (var i:int = 0; i < GRID_SIZE; i++)
		//		for (var o:int = 0; o < GRID_SIZE; o++)
		//			trace();
			/*
			
			var map:Array = [];
			if(usersave != null)
				map = String(usersave.Map).split(",");
			var length = map.length;
			
			var counter:int = 0;
			var i:int=0;
			var j:int=0;
			var arr:Vector.<int>;
			if(length > 0)
			{
				for (i = 0; i < GRID_SIZE; i++) 
				{
					arr = new Vector.<int>();
					gridArray[i] = arr;
					for (j = 0; j < GRID_SIZE; j++)
					{
						gridArray[i][j] = map[counter];//0 means you can build on this cell
						counter++;
						if(gridArray[i][j] > 0)
							autoBuild(gridArray[i][j], i , j);
					}
				}
			}
			*/
		}
		
		public function updateMapData(vo:FurnitureVO,isDeleting:Boolean = false):void
		{
			trace("updateMapData",isDeleting,vo.uniqueID);
			var colVect:Vector.<String>;
			var colVectLength:int = 0;
			var mapDataLength:int = mapData.length;
			mainLoop:for (var i:int = 0; i < mapDataLength; i++) 
			{
				colVect = mapData[i];
				colVectLength = colVect.length;
				for (var o:int = 0; o < colVectLength; o++)
				{
					if(colVect[o] == vo.uniqueID)//this Item was found on the map,
					{
						//clear the old cells it was occupying
						changeItemDataOnMap(i, o, (i+vo.rows), (o+vo.cols));
						
						break mainLoop;
						
					}
				}
			}
			
			if(isDeleting)//if this is all about deleting this Item from map, stop here.
			{
				eventDispatcher.dispatchEvent(new RoomDataEvent(RoomDataEvent.UPDATE_ROOM_DATA, mapData));				
				return;
			}
			//else, set you map with the new vals
			changeItemDataOnMap(vo.xCell, vo.yCell, (vo.xCell+vo.rows), (vo.yCell+vo.cols), vo.uniqueID);
			
			eventDispatcher.dispatchEvent(new RoomDataEvent(RoomDataEvent.UPDATE_ROOM_DATA, mapData));
			//TODO: save() via service, db, xml, whatever
		}
		
		private function changeItemDataOnMap(xCell:int, yCell:int, rows:int, cols:int, newVal:String = ""):void
		{
			trace("changeItemDataOnMap","x:"+xCell,"y:"+yCell, "r:"+rows, "c:"+cols, "val:"+newVal);
			
			for (var i:int = xCell; i < rows; i++)
			{
				for (var o:int = yCell; o < cols; o++)
				{
					mapData[i][o] = newVal == ""? "":"block";
				}
			}
			mapData[xCell][yCell] = newVal;
			
			for (var i:int = 0; i < mapData.length; i++) 
			{
					trace(i+":"+mapData[i]);
			}
					
		}
	}
}