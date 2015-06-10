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
	
	public class UploadPdfFileResultCommand extends Command
	{
		
		[Inject]
		public var event:UploadPdfFileResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		override public function execute():void
		{
			model.citation = event.ac;
			
			var acQo:ArticleCitation_qo = new ArticleCitation_qo();
			if( model.corpus != null ) {
				var cQo:Corpus_qo = new Corpus_qo();
				acQo.corpora.addItem(cQo);
				cQo.vpdmfId = model.corpus.vpdmfId + "";
			}
			dispatch( new ListArticleCitationPagedEvent(acQo, 0, 100) );
		}
		
	}
	
}