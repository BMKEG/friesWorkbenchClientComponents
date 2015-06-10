package edu.isi.bmkeg.digitalLibraryModule.controller
{
	import org.robotlegs.mvcs.Command;
	
	import edu.isi.bmkeg.pagedList.model.*;
	
	import edu.isi.bmkeg.digitalLibraryModule.model.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	
	import flash.events.Event;
	
	public class CountArticleCitationResultCommand extends Command
	{
		
		[Inject]
		public var event:CountArticleCitationResultEvent;
		
		[Inject]
		public var model:DigitalLibraryPagedListModel;
		
		override public function execute():void
		{
			model.pagedListLength = event.count;
		}
		
	}

}