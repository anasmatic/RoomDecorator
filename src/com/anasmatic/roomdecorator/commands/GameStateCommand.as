package com.anasmatic.roomdecorator.commands
{
	import com.anasmatic.roomdecorator.models.GameStateModel;
	import com.anasmatic.roomdecorator.models.ShopButtonModel;
	import com.anasmatic.roomdecorator.models.ShopModel;
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	import com.anasmatic.roomdecorator.models.helpers.GameStates;
	
	import robotlegs.bender.bundles.mvcs.Command;

	public class GameStateCommand extends Command
	{
		[Inject]
		public var gameStateModel:GameStateModel;
		
		[Inject]
		public var shopButtonModel:ShopButtonModel;
		
		[Inject]
		public var shopModel:ShopModel;
		
		[Inject]
		public var e:GameStateEvent;
		
		override public function execute():void
		{
			gameStateModel.state = e.state;
			gameStateModel.isShopOpened = e.isShopOpened;
			
			if(e.state == GameStates.EDIT_STATE && !e.isShopOpened)
				shopButtonModel.hideButton();
		}
		
	}
}