package com.anasmatic.roomdecorator.view
{
	import com.anasmatic.roomdecorator.view.events.ShopItemTouchEvent;
	import com.anasmatic.roomdecorator.view.viewcontroles.ShopAssets;
	
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import feathers.data.ListCollection;
	import feathers.display.Scale9Image;
	import feathers.layout.TiledRowsLayout;
	import feathers.textures.Scale9Textures;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class ShopView extends Sprite
	{
		private static const SHOP_WIDTH:int = 150;
		private var list:List;
		
		//touch handler helpers
		private var touchPointID:int = -1;
		private static const HELPER_POINT:Point = new Point();
		
		// allow mediator to access
		public var selectedItemIndex:int;
		
		public function ShopView()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			x = -SHOP_WIDTH;
		}
		
		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			const listLayout:TiledRowsLayout = new TiledRowsLayout();
			listLayout.paging = TiledRowsLayout.PAGING_VERTICAL;
			listLayout.useSquareTiles = true;
			listLayout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_MIDDLE;
			listLayout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_MIDDLE;
			listLayout.manageVisibility = true;
			listLayout.gap = 5;
			

			list = new List();
			list.y = 30;
			list.layout = listLayout;
			list.snapToPages = true;
			list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			list.verticalScrollPolicy = List.SCROLL_POLICY_AUTO;
			
			list.itemRendererProperties.gap = 5;
			
			const texture:Texture = ShopAssets.getAtlas().getTexture("shopbg");
			const scale9texture:Scale9Textures = new Scale9Textures(texture, new Rectangle(8,8,34,84));
			const scale9Image:Scale9Image = new Scale9Image(scale9texture);
			scale9Image.width = SHOP_WIDTH;
			scale9Image.height = Starling.current.viewPort.height-list.y;
			
			list.backgroundSkin = scale9Image;
			
			list.width = SHOP_WIDTH;
			list.height = stage.width - list.y;
			
			addChild(list);
		}
		
		public function initShop(shopData:ListCollection):void
		{
			list.dataProvider = shopData;
			
			list.itemRendererFactory = itemFactory;				
			
			list.validate();
			
			openShop();
		}
		
		private function itemFactory():IListItemRenderer
		{
			var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
			renderer.addEventListener(TouchEvent.TOUCH, onItemTouch);
			renderer.defaultSkin = new Image(ShopAssets.getAtlas().getTexture("shopitemskin"));
			renderer.labelField = "name";
			renderer.labelFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			}
			renderer.defaultLabelProperties.textFormat = new TextFormat("Tahoma",12);
			renderer.defaultLabelProperties.wrapWord = true;
			
			//TODO: make item non-resizeable, wrap label text
			return renderer;
		}
		
		private function onItemTouch(e:TouchEvent):void
		{
			const touches:Vector.<Touch> = e.getTouches(this);
			if(touches.length == 0)
				return;

			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					var item:DefaultListItemRenderer = e.currentTarget as DefaultListItemRenderer;
					if(item)
					{
						this.touchPointID = -1;
						
						touch.getLocation(this, HELPER_POINT);
						
						//check if the touch is still over the target
						const isInBounds:Boolean = item.contains(this.hitTest(HELPER_POINT, true));
						if(isInBounds)
						{
							selectedItemIndex = item.index;
							dispatchEvent(new ShopItemTouchEvent(ShopItemTouchEvent.SHOP_ITEM_TOUCH_END));
						}
						return;
					}
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
			
		}
		
		public function openShop():void
		{
			Starling.juggler.tween(this,.2,{x:0,onComplete:onOpenShopAnimationComplete});
		}
		
		private function onOpenShopAnimationComplete():void
		{
			//TODO: mmmmm
		}
		
		public function closeShop():void
		{
			Starling.juggler.tween(this,.2,{x:-SHOP_WIDTH});
		}
	}
}