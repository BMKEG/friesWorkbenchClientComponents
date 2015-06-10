package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.digitalLibrary.events.*;
	import edu.isi.bmkeg.digitalLibrary.model.citations.*;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListArticleCitationPagedEvent;
	import edu.isi.bmkeg.digitalLibrary.services.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Command;
	
	public class UploadPdfFileFaultCommand extends Command
	{
		
		[Inject]
		public var event:UploadPdfFileFaultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{
			trace( event.event.message );
		}		
	}
	
}