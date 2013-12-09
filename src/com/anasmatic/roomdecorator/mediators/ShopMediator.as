package com.anasmatic.roomdecorator.mediators
{
	import com.anasmatic.roomdecorator.models.events.CloseShopEvent;
	import com.anasmatic.roomdecorator.models.events.OpenShopEvent;
	import com.anasmatic.roomdecorator.view.events.ShopItemSelectedEvent;
	import com.anasmatic.roomdecorator.view.events.ShopItemTouchEvent;
	
	import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
	import com.anasmatic.roomdecorator.view.ShopView;
	
	public class ShopMediator extends StarlingMediator
	{
		
		[Inject]
		public var shopView:ShopView;
		
		override public function initialize():void
		{
			//events related to ShopButtonView
			eventDispatcher.addEventListener(OpenShopEvent.INIT_OPEN_SHOP, onInitOpenShop);
			eventDispatcher.addEventListener(OpenShopEvent.OPEN_SHOP, onOpenShop);
			
			//there is a same type listener @ ShopButtonMediator 
			eventDispatcher.addEventListener(CloseShopEvent.CLOSE_SHOP, onCloseShop);
			
			//events related to shop items
			shopView.addEventListener(ShopItemTouchEvent.SHOP_ITEM_TOUCH_END, onShopItemTouched);
			
			
		}
		

		//events related to ShopButtonView -----------------------------------------
		
		private function onInitOpenShop(e:OpenShopEvent):void
		{
			// add shop items
			shopView.initShop(e.shopData);
		}
		
		private function onOpenShop(e:OpenShopEvent):void
		{
			shopView.openShop();
		}
		
		private function onCloseShop(e:CloseShopEvent):void
		{
			shopView.closeShop();
		}
		
		
		//events related to shop items ------------------------------------
		
		private function onShopItemTouched(e:ShopItemTouchEvent):void
		{
			dispatch(new ShopItemSelectedEvent(ShopItemSelectedEvent.SHOP_ITEM_SELECTED, shopView.selectedItemIndex));
		}
	}
}