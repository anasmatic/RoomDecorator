package com.anasmatic.roomdecorator.view
{
	import com.anasmatic.roomdecorator.view.events.ShopButtonTouchEvent;
	import com.anasmatic.roomdecorator.view.viewcontroles.ShopAssets;
	
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	
	import flash.text.TextFormat;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class ShopButtonView extends Button
	{
		public function ShopButtonView()
		{
			y = x = 5;
			initButton();
		}
		
		private function initButton():void
		{
			labelFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			}
			defaultLabelProperties.textFormat = new TextFormat("Tahoma",14);
			label = "Shop";
			
			verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;
			iconPosition = Button.ICON_POSITION_TOP;

			this.isToggle = true;

			defaultSkin = new Image(ShopAssets.getAtlas().getTexture("shopbtnopenskin"));
			defaultIcon = new Image(ShopAssets.getAtlas().getTexture("shopbtnopenicon"));
			defaultSelectedSkin= new Image(ShopAssets.getAtlas().getTexture("shopbtncloseskin"));
			defaultSelectedIcon= new Image(ShopAssets.getAtlas().getTexture("shopbtncloseicon"));
			
			addEventListener(Event.CHANGE, onShopButtonChange);
		}
		
		private function onShopButtonChange(e:Event):void
		{
			if(this.isSelected)
			{
				label = "Close Shop";
				dispatchEvent(new ShopButtonTouchEvent(ShopButtonTouchEvent.OPEN_SHOP_TOUCH));
			}
			else
			{
				label = "Shop";
				if(visible)
					dispatchEvent(new ShopButtonTouchEvent(ShopButtonTouchEvent.CLOSE_SHOP_TOUCH));
				else
					dispatchEvent(new ShopButtonTouchEvent(ShopButtonTouchEvent.CLOSE_SHOP_TOUCH_KEEP_EDIT_STATE));
			}
		}
		
		public function hideAndDeselect():void
		{
			visible = false;//have to be before isSelected = false, because we are going to check visibilty in onShopButtonChange()
			isSelected = false;
		}
		
		public function show():void
		{
			visible = true;
		}
	}
}