package com.anasmatic.roomdecorator.models.events
{
	import flash.events.Event;
	
	public class GameStateEvent extends Event
	{
		public static const CHANGE_STATE:String = "changeState,please!";
		public static var STATE_CHANGED:String = "stateChanged";
		
		public var state:String;
		public var isShopOpened:Boolean;
		
		public function GameStateEvent(type:String, state:String,isShopOpened:Boolean, bubbles:Boolean=false)
		{
			this.state = state;
			this.isShopOpened = isShopOpened;
			super(type,bubbles);
		}
		
		override public function clone():Event
		{
			// TODO Auto Generated method stub
			return new GameStateEvent(type, state,isShopOpened,bubbles);
		}
		
		
	}
}