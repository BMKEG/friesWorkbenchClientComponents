package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ActivateCorpusListPopupEvent extends Event 
	{
		
		public static const ACTIVATE_CORPUS_LIST_POPUP:String = "activateCorpusListPopup";
		
		public var corpus:Corpus;
		
		public function ActivateCorpusListPopupEvent(corpus:Corpus = null)
		{
			this.corpus = corpus;
				
			super(ACTIVATE_CORPUS_LIST_POPUP);
		}
		
		override public function clone() : Event
		{
			return new ActivateCorpusListPopupEvent(corpus);
		}
		
	}
	
}
