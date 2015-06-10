package edu.isi.bmkeg.digitalLibraryModule.view.forms
{

	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.ftd.model.qo.FTDRuleSet_qo;
	import edu.isi.bmkeg.ftd.rl.events.*;
	import edu.isi.bmkeg.pagedList.*;
	import edu.isi.bmkeg.pagedList.model.*;
	import edu.isi.bmkeg.utils.serverUpdates.services.IServerUpdateService;
	import edu.isi.bmkeg.utils.updownload.*;
	import edu.isi.bmkeg.utils.uploadDirectoryControl.*;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ItemResponder;
	import mx.collections.errors.ItemPendingError;
	import mx.controls.Alert;
	import mx.events.CollectionEvent;
	import mx.managers.PopUpManager;
	import mx.utils.StringUtil;
	
	import org.robotlegs.mvcs.Mediator;
	
	public class UploadPdfsPopupMediator extends Mediator
	{
		
		[Inject]
		public var view:UploadPdfsPopup;
		
		[Inject]
		public var model:DigitalLibraryModel;

		[Inject]
		public var service:IServerUpdateService;
		
		override public function onRegister():void {
			
			addViewListener(ClosePopupEvent.CLOSE_POPUP, closePopup);

			addViewListener(UploadCompleteEvent.UPLOAD_COMPLETE, 
				uploadCodesHandler);
			
			addViewListener(UploadToBrowserCompleteEvent.UPLOAD_TO_BROWSER_COMPLETE, 
				uploadPdfsToDatabase);

			addViewListener(AllFileUploadsCompleteEvent.ALL_FILE_UPLOADS_COMPLETE, 
				uploadComplete);
			
			addContextListener(UploadPdfFileResultEvent.UPLOAD_PDF_FILE_RESULT, 
				startNextFileHandler);
			
			addContextListener(UploadPdfFileFaultEvent.UPLOAD_PDF_FILE_FAULT, 
				startNextFileFromFaultHandler);
			
			this.dispatch(new ListFTDRuleSetEvent(new FTDRuleSet_qo()));

		}

		private function uploadComplete(event:AllFileUploadsCompleteEvent):void {
		
			this.closePopup(new ClosePopupEvent(view));
		
		}
		
		private function closePopup(event:ClosePopupEvent):void {
			
			if( view.consumer != null ) 
				view.consumer.unsubscribe();

			mediatorMap.removeMediatorByView( event.popup );
			
			PopUpManager.removePopUp( event.popup );
			
		}
		
		private function uploadCodesHandler(event:UploadCompleteEvent):void {
						
			view.codeFile = event.file;			
			
		}
		
		private function uploadPdfsToDatabase(event:UploadToBrowserCompleteEvent):void {
			
			var cName:String = null;
			if( view.tc != null )
				cName = view.tc.name;
			
			var upEvent:UploadPdfFileEvent = new UploadPdfFileEvent(
				event.file.data,
				event.file.name,
				cName);
				
			this.dispatch(upEvent);			
			
		}
		
		private function startNextFileHandler(event:UploadPdfFileResultEvent):void {
			
			view.count++;
			view.progressBar.setProgress(view.count, view.max);
			view.pdfUploadButton.startLoadingNextFile();
			
		}
	
		private function startNextFileFromFaultHandler(event:UploadPdfFileFaultEvent):void {
			
			view.progressBar.setProgress(view.count, view.max);
			view.pdfUploadButton.startLoadingNextFile();
			
		}
		
	}

}