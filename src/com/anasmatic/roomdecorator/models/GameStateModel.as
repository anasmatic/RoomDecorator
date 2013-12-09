package com.anasmatic.roomdecorator.models
{
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	
	import flash.events.IEventDispatcher;

	public class GameStateModel
	{
		[Inject]
		public var eventDispacher:IEventDispatcher;
		
		private var _state:String;
		private var _isShopOpened:Boolean;
		
		public function GameStateModel()
		{
		}

		public function get isShopOpened():Boolean
		{
			return _isShopOpened;
		}

		public function set isShopOpened(value:Boolean):void
		{
			_isShopOpened = value;
		}

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
			eventDispacher.dispatchEvent(new GameStateEvent(GameStateEvent.STATE_CHANGED,state,true));
		}
		
	}
}