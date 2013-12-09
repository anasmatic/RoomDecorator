package com.anasmatic.roomdecorator.view
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	
	import com.anasmatic.roomdecorator.helpers.Constants;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	import com.anasmatic.roomdecorator.models.vo.FurnitureVO;
	import com.anasmatic.roomdecorator.view.viewcontroles.FurnitureIsoAssets;
	
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	
	public class FurnitureItem extends IsoSprite
	{
		private var roomView:RoomView;
		private var isoView:IsoView;
		private var vo:FurnitureVO;
		
		private var isoPt:Pt=new Pt();
		private var pt:Pt=new Pt();

		private var confirmView:ItemConfirmView;
		private var _gameState:String;
		private var pressAndHoldCounter:Number = 0;
		private var invaledFilter:ColorMatrixFilter;

		private var xCell:int;

		private var yCell:int;

		public function FurnitureItem(roomView:RoomView, vo:FurnitureVO)
		{
			this.roomView = roomView;
			this.isoView = roomView.isoView;
			this.vo = vo;
			
			name=vo.name;
			
			vo.setUniqueID();
			id = vo.uniqueID;

			//setSize(vo.rows*Constants.CELL_SIZE,vo.cols*Constants.CELL_SIZE,0);
			var tile:Image = new Image(FurnitureIsoAssets.getAtlas().getTexture(vo.id));
			tile.pivotX = vo.cols*Constants.CELL_SIZE;
			//tile.pivotX = Math.floor(Constants.CELL_SIZE*(vo.cols/vo.rows));
			
			
			container.addEventListener(TouchEvent.TOUCH, onTouch);
			
			confirmView = new ItemConfirmView();
			confirmView.vo = vo;
			sprites = [tile,confirmView];
			
			confirmView.x = ((vo.cols*Constants.CELL_SIZE) + (confirmView.width*.5))*-1;
			confirmView.y = 0;//(confirmView.height*-0.5);

			invalidateSprites();

			//invaled location sprite, to be added if location is invaled!
			invaledFilter = new ColorMatrixFilter()
			invaledFilter.adjustSaturation(-1);
			
		}
		
		private function onTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(container);
			if(touch == null)return;
			if(_gameState == GameStates.NORMAL_STATE)//wait for press and hold action
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					pressAndHoldCounter = 0;
					container.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
				}
				else if(touch.phase == TouchPhase.ENDED || touch.phase == TouchPhase.MOVED )
				{
					vo.xCell = xCell;
					vo.yCell = yCell;
					
					container.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
				}
			}
			else if(_gameState == GameStates.EDIT_STATE)//move the item
			{
				e.stopImmediatePropagation();
				
				if(touch.phase == TouchPhase.BEGAN)//get ready to move
				{
					pt.x = touch.globalX;//getLocation((parent as IsoScene).container).x//
					pt.y = touch.globalY;//getLocation((parent as IsoScene).container).y//	
					isoPt = isoView.localToIso(pt);
				}
				else if(touch.phase == TouchPhase.MOVED)
				{
					xCell =  Math.floor(isoPt.x/Constants.CELL_SIZE);
					yCell = Math.floor(isoPt.y/Constants.CELL_SIZE);

					////IsoBox(cellIndicator.children[0]).fill = new SolidColorFill(0x00ff00, .3); 
					if(roomView.isValedLocation(vo.rows,vo.cols,xCell,yCell))//valed
					{
						container.filter = null;
						
						if(!confirmView.acceptBtn.visible)
							confirmView.acceptBtn.visible = true;	
					}
					else
					{
						container.filter = invaledFilter;
						
						if(confirmView.acceptBtn.visible)
							confirmView.acceptBtn.visible = false;
					}
					//move
					moveTo(xCell*Constants.CELL_SIZE, yCell*Constants.CELL_SIZE,0);
					//save last touch x and y
	
					pt.x = touch.globalX;//getLocation((parent as IsoScene).container).x//
					pt.y = touch.globalY;//getLocation((parent as IsoScene).container).y//
					isoPt = isoView.localToIso(pt);
					
					(parent as IsoScene).render();
				}
				else if(touch.phase == TouchPhase.ENDED)
				{
					vo.xCell = xCell;
					vo.yCell = yCell;
				}
			}
		}
		
		private function onEnterFrame(e:EnterFrameEvent):void
		{
			pressAndHoldCounter += e.passedTime;
			
			if(pressAndHoldCounter > 0.8)
			{
				container.removeEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);			
				
				//add the confirmation view	
				confirmView.addListeners();
				sprites.push(confirmView);
				invalidateSprites();
				
				(parent as IsoScene).render();
				
				//now that I'm flying, clear my data from the view
				roomView.clearItemDataOnMap(xCell,yCell,(xCell+vo.rows),(yCell+vo.cols));
				//tell my parent that I have been choosen!
				roomView.currentSelectedFurnitureItem = this;
				//and now we should be in EDIT state
				roomView.changeGameState(GameStates.EDIT_STATE);
			}
		}
		
		public function set gameState(value:String):void
		{
			_gameState = value;
			
			if(_gameState == GameStates.NORMAL_STATE && sprites.indexOf(confirmView) > -1)
			{
				sprites.pop();
				invalidateSprites();
				
				(parent as IsoScene).render();
			}
		}
	}
}