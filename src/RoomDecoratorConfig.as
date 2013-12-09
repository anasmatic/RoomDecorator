package
{
	import com.anasmatic.roomdecorator.commands.BuyShopItemCommand;
	import com.anasmatic.roomdecorator.commands.CloseShopCommand;
	import com.anasmatic.roomdecorator.commands.GameStateCommand;
	import com.anasmatic.roomdecorator.commands.ItemAcceptedConfirmCommand;
	import com.anasmatic.roomdecorator.commands.ItemDeletedConfirmCommand;
	import com.anasmatic.roomdecorator.commands.LoadRoomDataCommand;
	import com.anasmatic.roomdecorator.commands.OpenShopCommand;
	import com.anasmatic.roomdecorator.commands.events.LoadRoomDataEvent;
	import com.anasmatic.roomdecorator.mediators.ItemConfirmMediator;
	import com.anasmatic.roomdecorator.mediators.RoomViewMediator;
	import com.anasmatic.roomdecorator.mediators.ShopButtonMediator;
	import com.anasmatic.roomdecorator.mediators.ShopMediator;
	import com.anasmatic.roomdecorator.models.GameStateModel;
	import com.anasmatic.roomdecorator.models.ItemConfirmModel;
	import com.anasmatic.roomdecorator.models.RoomDataModel;
	import com.anasmatic.roomdecorator.models.RoomViewModel;
	import com.anasmatic.roomdecorator.models.ShopButtonModel;
	import com.anasmatic.roomdecorator.models.ShopModel;
	import com.anasmatic.roomdecorator.models.events.GameStateEvent;
	import com.anasmatic.roomdecorator.models.events.ItemConfirmControlEvent;
	import com.anasmatic.roomdecorator.models.events.ShopButtonControlEvent;
	import com.anasmatic.roomdecorator.services.RoomDataService;
	import com.anasmatic.roomdecorator.services.ShopDataService;
	import com.anasmatic.roomdecorator.view.ItemConfirmView;
	import com.anasmatic.roomdecorator.view.RoomView;
	import com.anasmatic.roomdecorator.view.ShopButtonView;
	import com.anasmatic.roomdecorator.view.ShopView;
	import com.anasmatic.roomdecorator.view.events.ShopItemSelectedEvent;
	
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.viewProcessorMap.impl.ViewProcessorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	
	public class RoomDecoratorConfig implements IConfig
	{
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		private var viewProcessorMap:ViewProcessorMap;
		
		public function configure():void
		{
			mediatorMap.map(RoomView).toMediator(RoomViewMediator);
			mediatorMap.map(ShopButtonView).toMediator(ShopButtonMediator);
			mediatorMap.map(ShopView).toMediator(ShopMediator);
			mediatorMap.map(ItemConfirmView).toMediator(ItemConfirmMediator);
			

			//map services
			context.injector.map(RoomDataService).asSingleton();
			context.injector.map(ShopDataService).asSingleton();
			//map models
			context.injector.map(RoomDataModel).asSingleton();
			context.injector.map(RoomViewModel).asSingleton();
			context.injector.map(ShopButtonModel).asSingleton();
			context.injector.map(ShopModel).asSingleton();
			context.injector.map(GameStateModel).asSingleton();
			context.injector.map(ItemConfirmModel).asSingleton();
			//startApp
			commandMap.map(LoadRoomDataEvent.LOAD_DATA,LoadRoomDataEvent).toCommand(LoadRoomDataCommand);
			
			//shop
			commandMap.map(ShopButtonControlEvent.OPEN_SHOP,ShopButtonControlEvent).toCommand(OpenShopCommand);
			commandMap.map(ShopButtonControlEvent.CLOSE_SHOP,ShopButtonControlEvent).toCommand(CloseShopCommand);
			commandMap.map(ShopButtonControlEvent.CLOSE_SHOP_KEEP_EDIT_STATE,ShopButtonControlEvent).toCommand(CloseShopCommand);
			commandMap.map(ShopItemSelectedEvent.SHOP_ITEM_SELECTED,ShopItemSelectedEvent).toCommand(BuyShopItemCommand);
			
			//shop to iso stage
			commandMap.map(ItemConfirmControlEvent.ACCEPT_ITEM,ItemConfirmControlEvent).toCommand(ItemAcceptedConfirmCommand);
			commandMap.map(ItemConfirmControlEvent.DELETE_ITEM,ItemConfirmControlEvent).toCommand(ItemDeletedConfirmCommand);
			commandMap.map(GameStateEvent.CHANGE_STATE,GameStateEvent).toCommand(GameStateCommand);
		}
	}
}