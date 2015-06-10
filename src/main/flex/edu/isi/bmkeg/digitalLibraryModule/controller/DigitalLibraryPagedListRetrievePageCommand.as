package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	import edu.isi.bmkeg.pagedList.events.*;
	import edu.isi.bmkeg.digitalLibrary.rl.events.*;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class DigitalLibraryPagedListRetrievePageCommand extends Command
	{
	
		[Inject]
		public var event:PagedListRetrievePageEvent;

		[Inject]
		public var model:DigitalLibraryModel;
				
		override public function execute():void
		{
			if( model.queryLiteratureCitation != null ) {
				this.dispatch( new ListArticleCitationPagedEvent(
						model.queryLiteratureCitation, event.offset, event.count));
			}
			
		}
		
	}
	
}