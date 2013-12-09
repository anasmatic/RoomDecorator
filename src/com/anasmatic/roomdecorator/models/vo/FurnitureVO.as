package com.anasmatic.roomdecorator.models.vo
{
	import flash.utils.ByteArray;

	public class FurnitureVO extends Object
	{
		//initial values
		//{id:object.@instance, name:object.@name, cost:object.@cost, rows:object.@rows, cols:object.@cols}
		private var _id:String;
		private var _name:String;
		private var _cost:int;
		private var _rows:int;
		private var _cols:int;
		//after added to map
		private var _xCell:int;
		private var _yCell:int;
		//private var _rotation:Button;//TODO: later alligator
		private var _uniqueID:String;
		
		public function FurnitureVO(id:String,name:String,cost:int,rows:int,cols:int)
		{
			_id = id;
			_name= name;
			_cost = cost;
			_rows = rows;
			_cols = cols;
		}
		
		public function set xCell(value:int):void
		{_xCell = value;}
		
		public function get xCell():int
		{return _xCell;}

		public function set yCell(value:int):void
		{_yCell = value;}
		
		public function get yCell():int
		{return _yCell;}
		
		
		
		public function get cost():int
		{return _cost;}

		public function get name():String
		{return _name;}

		public function get id():String
		{return _id;}

		public function get rows():int
		{return _rows;}
		
		public function get cols():int
		{return _cols;}

		
		
		public function get uniqueID():String
		{
			return _uniqueID;
		}
		
		/**
		 *set value only once, when the Item is created, in its constructor. 
		 * 
		 */
		public function setUniqueID():void
		{
			_uniqueID = id+"_"+new Date().time;
		}

		public function clone():FurnitureVO
		{
			var voClone:FurnitureVO = new FurnitureVO(id,name,cost,rows,cols);
			voClone.xCell = xCell;
			voClone.yCell = yCell;
			voClone._uniqueID = uniqueID;
			return voClone;
		}
	}
}