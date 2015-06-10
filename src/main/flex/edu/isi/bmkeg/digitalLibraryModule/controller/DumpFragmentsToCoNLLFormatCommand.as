package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.digitalLibrary.services.IExtendedDigitalLibraryService;
	import edu.isi.bmkeg.digitalLibrary.events.*;

	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;

	import flash.events.Event;	
	import edu.isi.bmkeg.utils.*;
	import flash.net.*;
	
	public class DumpFragmentsToCoNLLFormatCommand extends Command
	{
	
		[Inject]
		public var event:DumpFragmentsToCoNLLFormatEvent;		
				
		override public function execute():void
		{
			// External link to spawn off a new panel to this address. 
//			var stem:String = ServiceUtils.getAppUrl();
//			var url:URLRequest = new URLRequest(stem + "rest/" + event.result);
//			navigateToURL(url,"_blank");			
		}
		
	}
	
}