package edu.isi.bmkeg.digitalLibraryModule.controller
{	
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	import edu.isi.bmkeg.digitalLibrary.rl.events.ListArticleCorpusResultEvent;
	import edu.isi.bmkeg.digitalLibraryModule.model.DigitalLibraryModel;
	import edu.isi.bmkeg.vpdmf.model.instances.LightViewInstance;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	
	import org.robotlegs.mvcs.Command;
	
	public class ListArticleCorpusResultCommand extends Command
	{
		
		[Inject]
		public var event:ListArticleCorpusResultEvent;
		
		[Inject]
		public var model:DigitalLibraryModel;
		
		
		override public function execute():void
		{
		
			var l:ArrayCollection = new ArrayCollection();
			
			l.addItem(new Object());
			
			for each(var lvi:LightViewInstance in event.list) {
				
				var o:Object = lvi.convertToIndexTupleObject()				
				l.addItem(o);
				
			}
			
			model.corpora = l;
			
		}
		
	}
	
}