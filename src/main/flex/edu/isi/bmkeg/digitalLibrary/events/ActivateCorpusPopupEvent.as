package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ActivateCorpusPopupEvent extends Event 
	{
		
		public static const ACTIVATE_CORPUS_POPUP:String = "activateCorpusPopup";
		
		public var corpus:Corpus;
		
		public function ActivateCorpusPopupEvent(corpus:Corpus = null)
		{
			this.corpus = corpus;
				
			super(ACTIVATE_CORPUS_POPUP);
		}
		
		override public function clone() : Event
		{
			return new ActivateCorpusPopupEvent(corpus);
		}
		
	}
	
}
