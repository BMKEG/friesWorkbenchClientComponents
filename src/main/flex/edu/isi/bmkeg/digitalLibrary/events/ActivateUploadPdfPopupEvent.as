package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	
	public class ActivateUploadPdfPopupEvent extends Event
	{
		public static const ACTIVATE_PDF_UPLOAD_POPUP:String = "activatePdfUploadPopup";

		public function ActivateUploadPdfPopupEvent(bubbles:Boolean=false, 
												 	cancelable:Boolean=false)
		{
			super(ACTIVATE_PDF_UPLOAD_POPUP, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ActivateUploadPdfPopupEvent(bubbles, 
				cancelable)
		}

	}
}