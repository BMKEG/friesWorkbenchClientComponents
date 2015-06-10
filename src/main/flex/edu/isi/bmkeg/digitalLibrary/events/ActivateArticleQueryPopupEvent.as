package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class ActivateArticleQueryPopupEvent extends Event 
	{
		
		public static const ACTIVATE_ARTICLE_QUERY_POPUP:String = "activateArticleQueryPopup";
		
		public var corpus:Corpus;
		
		public function ActivateArticleQueryPopupEvent(corpus:Corpus = null)
		{
			this.corpus = corpus;
				
			super(ACTIVATE_ARTICLE_QUERY_POPUP);
		}
		
		override public function clone() : Event
		{
			return new ActivateArticleQueryPopupEvent(corpus);
		}
		
	}
	
}
