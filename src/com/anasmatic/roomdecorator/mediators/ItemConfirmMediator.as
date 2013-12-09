package com.anasmatic.roomdecorator.mediators
{
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.view.ItemConfirmView;
	import com.anasmatic.roomdecorator.view.events.ItemConfirmTouchEvent;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class ItemConfirmMediator extends StarlingMediator
	{
		[Inject]
		public var itemConfirmView:ItemConfirmView;
		
		override public function initialize():void
		{
			//event comming from ItemConfirmModel
			eventDispatcher.addEventListener(ItemConfirmControlEvent.CREATE, onConfirmCreate);
			
			//events from ItemConfirmView
			itemConfirmView.addEventListener(ItemConfirmTouchEvent.ACCEPT_TOUCH, onAcceptTouch);
			itemConfirmView.addEventListener(ItemConfirmTouchEvent.DELETE_TOUCH, onDeleteTouch);
		}
		
		private function onAcceptTouch(e:ItemConfirmTouchEvent):void
		{
			//ItemAcceptedConfirmCommand is wating for this dispatch :)
			dispatch(new ItemConfirmControlEvent(ItemConfirmControlEvent.ACCEPT_ITEM,(e.data as FurnitureVO)));
			
			//to GameStateCommand
			dispatch(new GameStateEvent(GameStateEvent.CHANGE_STATE, GameStates.NORMAL_STATE,false));
		}
		
		private function onDeleteTouch(e:ItemConfirmTouchEvent):void
		{
			e.stopImmediatePropagation();
			
			//TODO: change later, if that was a new item recently added from shop, open shop again, keep edit mode

			//ItemDeletedConfirmCommand is wating for this dispatch :)
			dispatch(new ItemConfirmControlEvent(ItemConfirmControlEvent.DELETE_ITEM,(e.data as FurnitureVO)));
			
			//to GameStateCommand
			dispatch(new GameStateEvent(GameStateEvent.CHANGE_STATE, GameStates.NORMAL_STATE,false));
		}
		
		private function onConfirmCreate(e:ItemConfirmControlEvent):void
		{
			itemConfirmView.addListeners();
		}		
		
	}
}