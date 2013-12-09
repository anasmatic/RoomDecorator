package com.anasmatic.roomdecorator.view
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.Stroke;
	
	import com.anasmatic.roomdecorator.helpers.Constants;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.view.events.GameStateViewEvent;
	import com.anasmatic.roomdecorator.view.viewcontroles.IsoAssets;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class RoomView extends Sprite
	{
		[Inject]
		public var shopButtonView:ShopButtonView;
		
		private var grid:IsoGrid;
		private var scene:IsoScene;
//		private var gridScene:IsoScene;
		private var _isoView:IsoView;

		private var SimpleSceneLayoutRenderer:Class;
		
		private var touchPointID:int = -1;
		
		private var panHelperPt:Point;

		private var bg:Quad;
		private var _gameState:String;

		private var _currentSelectedFurnitureItem:FurnitureItem;
		private var _roomData:Vector.<Vector.<String>>;//for fast validating cell,
		
		public function RoomView() 
		{
			setupBG();
			setupIsoWorld();
		}

		private function setupBG():void
		{
			bg = new Quad(Starling.current.viewPort.width, Starling.current.viewPort.height, 0x999000);
			//bg.alpha = 0;
			addChild(bg);
		}
		
		private function setupIsoWorld():void
		{
			scene = new IsoScene();
			
//			gridScene = new IsoScene();
//			gridScene.addChild(grid);
			
			_isoView = new IsoView();
			_isoView.name = "7amada";
			_isoView.setSize(500, 375);//TODO:Use Starling viewPort
			_isoView.touchable = true;
			_isoView.clipContent = true;
			_isoView.centerOnPt(new Pt(0,Starling.current.viewPort.height*.5),false);
		//	bg = new Quad(Starling.current.viewPort.width, Starling.current.viewPort.height, 0x999000);
		//	bg.x = -bg.width *0.5;
		//	_isoView.backgroundContainer.addChild(bg);
			
			_isoView.addScene(scene);
		//	_isoView.addScene(gridScene);
			_isoView.showBorder = true;
			addChild(_isoView);
			
			//var centerValue:uint = Constants.CELL_SIZE * Constants.GRID_SIZE * .5;
			//var pt:Pt = new Pt(centerValue,centerValue);
			//_isoView.centerOnPt(pt);
			createGrid();
		//	gridScene.render();
			scene.render();
			
			addEventListener(TouchEvent.TOUCH, onStageTouch);
		}
		
		private function createGrid():void
		{
			//TODO: create grid using iso objects
			//gridScene.render();
		}
		
		protected function onStageTouch(e:TouchEvent):void
		{
			var touch:Touch;
			const touches:Vector.<Touch> = e.getTouches(this);
			
			if(touches.length == 0 || touches.length > 2)
				return;
			else if(touches.length == 1)// move map
			{
				touch = e.getTouch(this);
				if(touch.phase == TouchPhase.BEGAN)//get ready to move
				{
					panHelperPt = new Point(touch.globalX, touch.globalY);
				}
				else if(touch.phase == TouchPhase.MOVED)
				{
					//move
					_isoView.panBy(panHelperPt.x - touch.globalX, panHelperPt.y - touch.globalY);
					//save last touch x and y
					panHelperPt.x = touch.globalX;
					panHelperPt.y = touch.globalY;
				}
			}
			else if(touches.length == 2)// zoom pinch
			{
				//refrance: https://github.com/PrimaryFeather/Starling-Framework/blob/master/samples/demo/src/utils/TouchSheet.as
				
				var touchA:Touch = touches[0];
				var touchB:Touch = touches[1];
				
				if(touchA.phase == TouchPhase.MOVED && touchB.phase == TouchPhase.MOVED)
				{
					var currentPosA:Point = touchA.getLocation(parent);
					var previousPosA:Point = touchA.getPreviousLocation(parent);
					var currentPosB:Point = touchB.getLocation(parent);
					var previousPosB:Point = touchB.getPreviousLocation(parent);
				
					var currentVector:Point = currentPosA.subtract(currentPosB);
					var previousVector:Point = previousPosA.subtract(previousPosB);
					
					var previousLocalA:Point = touchA.getPreviousLocation(this);
					var previousLocalB:Point = touchB.getPreviousLocation(this);
					pivotX = (previousLocalA.x + previousLocalB.x) * 0.5;
					pivotY = (previousLocalA.y + previousLocalB.y) * 0.5;
					
					// update location based on the current center
					x = (currentPosA.x + currentPosB.x) * 0.5;
					y = (currentPosA.y + currentPosB.y) * 0.5;
					
					var sizeDiff:Number = currentVector.length / previousVector.length;
					scaleX *= sizeDiff;
					scaleY *= sizeDiff;
					trace("zoom",sizeDiff, scaleX);
				}
			}
		}
		
		//TODO, use the roomData Vector insted of XML
		public function createMap(roomDataXML:XML):void
		{
			var wall:IsoSprite;
			var tile:Image;
			for each (var object:XML in roomDataXML..object) 
			{
//				trace(object.toXMLString());
//				trace(object.@instance, object.@row+"*"+object.@col);
				tile = new Image(IsoAssets.getAtlas().getTexture(object.@instance));
				
				wall = new IsoSprite();
				//wall.setSize(Constants.CELL_SIZE, Constants.CELL_SIZE,0);
				wall.moveTo(object.@col*Constants.CELL_SIZE, object.@row*Constants.CELL_SIZE, 0);
				tile.x = tile.width * -0.5;
				wall.sprites = [tile];
				wall.invalidateSprites();
				
				wall.id ="wall_"+ object.@row+"*"+object.@col;
					
				scene.addChild(wall);
			}
			
			
			scene.render();
			
		}
		
		public function furnitureFactory(furnitureVO:FurnitureVO):void
		{
			var furnitureItem:FurnitureItem = new FurnitureItem(this,furnitureVO);
			furnitureItem.moveTo(4*Constants.CELL_SIZE,5*Constants.CELL_SIZE, 0);//(_isoView.size.x*.5)*Constants.CELL_SIZE, (_isoView.size.y*.5)*Constants.CELL_SIZE,0);
			furnitureItem.gameState = _gameState;
			
			scene.addChild(furnitureItem);
			
			scene.render();
			
			// the new item is the current selected 
			currentSelectedFurnitureItem = furnitureItem;
		}
		
		public function deleteSelectedItem():void
		{
			if(currentSelectedFurnitureItem)
				scene.removeChild(currentSelectedFurnitureItem);
			scene.render();
			
			currentSelectedFurnitureItem = null;
		}
		
		public function set gameState(value:String):void
		{
			_gameState = value;
			
			if(currentSelectedFurnitureItem != null)
				currentSelectedFurnitureItem.gameState = _gameState;
			
			if(_gameState == GameStates.NORMAL_STATE)
				currentSelectedFurnitureItem = null;
			
		}
		
		public function changeGameState(newState:String):void
		{
			dispatchEvent(new GameStateViewEvent(GameStateViewEvent.STATE_CHANGE,false,newState));
			//TODO: Hide Shop
		}
		
		
		//TODO : move to a helper class
		public function isValedLocation(wCell:int, lCell:int, xCell:int, yCell:int):Boolean
		{
			var i:int;
			var j:int;
			
			var isFree:Boolean = true;
			
			widthLoop:for (i = 0; i < wCell; i++) 
			{
				for (j = 0; j < lCell; j++)
				{
					try	
					{
						if(roomData[xCell + i][yCell + j] != "")
						{
							isFree = false;
							break widthLoop;
						}
					}catch(e:RangeError)//index out of range
					{
						return false;
					}
				}
			}
			
			if(isFree)
				return true;
			else
				return false
			
		}
		public function clearItemDataOnMap(xCell:int, yCell:int, rows:int, cols:int):void
		{
			for (var i:int = xCell; i < rows; i++)
			{
				for (var o:int = yCell; o < cols; o++)
				{
					roomData[i][o] = "";
				}
			}
		}
		
		//and we don't need a setter
		public function get isoView():IsoView
		{
			return _isoView;
		}
		
		public function set currentSelectedFurnitureItem(value:FurnitureItem):void
		{
			_currentSelectedFurnitureItem = value;
		}
		public function get currentSelectedFurnitureItem():FurnitureItem
		{
			return _currentSelectedFurnitureItem;
		}

		public function get roomData():Vector.<Vector.<String>>
		{
			return _roomData;
		}
		
		public function set roomData(value:Vector.<Vector.<String>>):void
		{
			_roomData = value;
		}
	}
}