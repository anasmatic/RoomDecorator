package com.anasmatic.roomdecorator.mediators
{
	import com.anasmatic.roomdecorator.commands.events.LoadRoomDataEvent;
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	import com.anasmatic.roomdecorator.models.events.NewItemFromShopEvent;
	import com.anasmatic.roomdecorator.models.events.RoomDataEvent;
	import com.anasmatic.roomdecorator.view.RoomView;
	import com.anasmatic.roomdecorator.view.events.GameStateViewEvent;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	
	public class RoomViewMediator extends StarlingMediator
	{
		[Inject]
		public var view:RoomView;
		
		override public function initialize():void
		{
			//TODO: try using viewComponent, with out injecting view:RoomView !;
			
			//item on the map was selected, so we should be in EDIT state right now, go tell the gameStateComand
			view.addEventListener(GameStateViewEvent.STATE_CHANGE, onStateChangeByView);
			
			
			dispatch(new LoadRoomDataEvent(LoadRoomDataEvent.LOAD_DATA));
			
		// init room data!
			eventDispatcher.addEventListener(RoomDataEvent.DATA_READY, onRoomDataReady);
			eventDispatcher.addEventListener(RoomDataEvent.UPDATE_ROOM_DATA, updateRoomData);

		// buy item from shop 
			//first place item on room floor
			eventDispatcher.addEventListener(NewItemFromShopEvent.INIT_PLACEMENT, onNewItemPlacement);
			//update view due gamestate change
			eventDispatcher.addEventListener(GameStateEvent.STATE_CHANGED, onGameStateChanged);
			
			//after deleting an Item
			eventDispatcher.addEventListener(ItemConfirmControlEvent.ITEM_DELETED, onItemDeleteCommand);
		}
		
		private function onItemDeleteCommand(e:ItemConfirmControlEvent):void
		{
			view.deleteSelectedItem();
		}
		
		private function onStateChangeByView(e:GameStateViewEvent):void
		{
			dispatch(new GameStateEvent(GameStateEvent.CHANGE_STATE,e.data.toString(),false));
		}
		
		private function onGameStateChanged(e:GameStateEvent):void
		{
			view.gameState = e.state;
		}
		
		private function onNewItemPlacement(e:NewItemFromShopEvent):void
		{
			//create the item, set it on map
			view.furnitureFactory(e.furnitureVO);
		}
		
		private function onRoomDataReady(e:RoomDataEvent):void
		{
			view.createMap(e.roomData as XML);
		}
		private function updateRoomData(e:RoomDataEvent):void
		{
			//new roomData, after saving!
			view.roomData = e.roomData as Vector.<Vector.<String>>;
			
		}
			
	}
}