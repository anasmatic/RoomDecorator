package
{
	import com.anasmatic.roomdecorator.Game;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.impl.Context;
	import robotlegs.extensions.starlingViewMap.StarlingViewMapExtension;
	
	import starling.core.Starling;
	
	public class RoomDecorator extends Sprite 
	{

		protected var _starling:Starling;
		protected var _context:Context;
		
		public function RoomDecorator()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode	= StageScaleMode.NO_SCALE;
			
			initStarling();
			initRobotlegs();
		}
		
		private function initRobotlegs():void
		{
			_context = new Context();
			_context.install( MVCSBundle, StarlingViewMapExtension);
			_context.configure( RoomDecoratorConfig, _starling, new ContextView( this ) );
		}
		
		private function initStarling():void
		{
			Starling.multitouchEnabled = true;
			
			_starling = new Starling(Game,stage);
		//	_starling.showStats = true;
			
			const viewPort:Rectangle = _starling.viewPort;
			viewPort.width = stage.stageWidth;
			viewPort.height = stage.stageHeight;
			_starling.viewPort = viewPort;
		//	_starling.viewPort.height = stage.stageHeight;
			
			_starling.start();
			
			
		//stage.addEventListener(Event.RESIZE, stageResized);//multiscreen handling, later

			
		}
	}
}