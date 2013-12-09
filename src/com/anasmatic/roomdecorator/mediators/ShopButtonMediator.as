package com.anasmatic.roomdecorator.mediators
{
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	import com.anasmatic.roomdecorator.view.ShopButtonView;
	import com.anasmatic.roomdecorator.view.events.ShopButtonTouchEvent;
	
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	
	public class ShopButtonMediator extends StarlingMediator
	{
		[Inject]
		public var view:ShopButtonView;
		
		override public function initialize():void
		{
			view.addEventListener(ShopButtonTouchEvent.OPEN_SHOP_TOUCH, onTouchOpenShop);
			view.addEventListener(ShopButtonTouchEvent.CLOSE_SHOP_TOUCH, onTouchCloseShop);
			view.addEventListener(ShopButtonTouchEvent.CLOSE_SHOP_TOUCH_KEEP_EDIT_STATE, onTouchCloseShop);
			
			//there is a same type listener @ ShopMediator
			eventDispatcher.addEventListener(ShopButtonControlEvent.HIDE_SHOP_BUTTON, onHideButtonCommand);
			//dispached from ButtonShopModel
			eventDispatcher.addEventListener(ShopButtonControlEvent.SHOW_SHOP_BUTTON, onShowButtonCommand);
		}
		
		private function onTouchCloseShop(e:ShopButtonTouchEvent):void
		{
			if(e.type == ShopButtonTouchEvent.CLOSE_SHOP_TOUCH)
			{
				//to CloseShopCommand
				eventDispatcher.dispatchEvent(new ShopButtonControlEvent(ShopButtonControlEvent.CLOSE_SHOP));
				
				//to GameStateCommand
				eventDispatcher.dispatchEvent(new GameStateEvent(GameStateEvent.CHANGE_STATE, GameStates.NORMAL_STATE,false));
			}
			else if(e.type == ShopButtonTouchEvent.CLOSE_SHOP_TOUCH_KEEP_EDIT_STATE)
				//to CloseShopCommand
				eventDispatcher.dispatchEvent(new ShopButtonControlEvent(ShopButtonControlEvent.CLOSE_SHOP_KEEP_EDIT_STATE));				
		}
		
		private function onTouchOpenShop(e:ShopButtonTouchEvent):void
		{
			//to OpenShopCommand
			eventDispatcher.dispatchEvent(new ShopButtonControlEvent(ShopButtonControlEvent.OPEN_SHOP));
			//to GameStateComand
			eventDispatcher.dispatchEvent(new GameStateEvent(GameStateEvent.CHANGE_STATE,GameStates.EDIT_STATE,true));
		}
		
		public function onShowButtonCommand(e:ShopButtonControlEvent):void
		{
			view.show();
		}
		
		private function onHideButtonCommand(e:ShopButtonControlEvent):void
		{
			view.hideAndDeselect();
		}
	}
}