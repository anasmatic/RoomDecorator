package com.anasmatic.roomdecorator.view.events
{
	import starling.events.Event;
	
	public class GameStateViewEvent extends Event
	{
		public static var STATE_CHANGE:String = "stateChangedViaView";
		public function GameStateViewEvent(type:String, bubbles:Boolean=false, state:String = null)
		{
			super(type, bubbles, state);
		}
	}
}