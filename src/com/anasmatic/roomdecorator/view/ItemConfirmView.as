package com.anasmatic.roomdecorator.view
{
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.view.events.ItemConfirmTouchEvent;
	import com.anasmatic.roomdecorator.view.viewcontroles.ShopAssets;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ItemConfirmView extends Sprite
	{
		private var _acceptBtn:Button;
		private var deleteBtn:Button;
		//private var rotator:Button;//TODO: later alligator
		
		private var _vo:FurnitureVO;
		
		public function ItemConfirmView()
		{
			createButtons();
			addEventListener(Event.REMOVED, onRemoved);
		}
		
		public function get acceptBtn():Button
		{
			return _acceptBtn;
		}

		private function createButtons():void
		{
			_acceptBtn = new Button(ShopAssets.getAtlas().getTexture("shopbtnopenicon"));
			_acceptBtn.scaleX = acceptBtn.scaleY = .7;
			addChild(_acceptBtn);
			
			deleteBtn = new Button(ShopAssets.getAtlas().getTexture("shopbtncloseicon"));
			deleteBtn.y = acceptBtn.height + 10;
			deleteBtn.scaleX = deleteBtn.scaleY = .7;
			addChild(deleteBtn);
			
		}
		
		public function addListeners():void
		{
			//touch event
			_acceptBtn.addEventListener(Event.TRIGGERED, onAccept);
			deleteBtn.addEventListener(Event.TRIGGERED, onDelete);
		//	acceptBtn.addEventListener(TouchEvent.TOUCH, onTouch);
		//	deleteBtn.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this,TouchPhase.ENDED);
			if(touch == null)return;
		//	e.
			//if(e.currentTarget == acceptBtn)
		}
		
		private function onAccept(e:Event):void
		{
			//to ItemConfirmMediator
			dispatchEvent(new ItemConfirmTouchEvent(ItemConfirmTouchEvent.ACCEPT_TOUCH,false,vo));
		}
		
		private function onDelete(e:Event):void
		{
			//to ItemConfirmMediator
			dispatchEvent(new ItemConfirmTouchEvent(ItemConfirmTouchEvent.DELETE_TOUCH,false,vo));			
		}

		public function get vo():FurnitureVO
		{
			return _vo;
		}
		
		public function set vo(value:FurnitureVO):void
		{
			_vo = value;
		}
		
		
		private function removeListeners():void
		{
			_acceptBtn.removeEventListener(Event.TRIGGERED, onAccept);
			deleteBtn.removeEventListener(Event.TRIGGERED, onDelete);
		}
		
		private function onRemoved():void
		{
			removeListeners();
		}
	}
}