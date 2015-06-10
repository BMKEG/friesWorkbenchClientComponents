package edu.isi.bmkeg.digitalLibraryModule.view.forms
{

	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	
	import flash.events.Event;
	
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class ArticleQueryPopupMediator extends Mediator
	{
		
		[Inject]
		public var view:ArticleQueryPopup;
		
		[Inject]
		public var model:DigitalLibraryModel;

		override public function onRegister():void {
			
			addViewListener(ListArticleCitationPagedEvent.LIST_ARTICLECITATION_PAGED, 
					dispatch);
			addViewListener(ClosePopupEvent.CLOSE_POPUP, closePopup);

		}
		
		private function closePopup(event:ClosePopupEvent):void {
			
			mediatorMap.removeMediatorByView( event.popup );
			PopUpManager.removePopUp( event.popup );
			
		}
		
		
	}

}