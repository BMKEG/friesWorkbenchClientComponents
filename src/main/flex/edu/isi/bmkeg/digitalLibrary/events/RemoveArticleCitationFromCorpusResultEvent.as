package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RemoveArticleCitationFromCorpusResultEvent extends Event 
	{
		
		public static const REMOVE_ARTICLE_CITATION_FROM_CORPUS_RESULT:String = "removeArticleCitationFromCorpusResult";
		
		public var count:int;
		
		public function RemoveArticleCitationFromCorpusResultEvent(count:int)
		{
			this.count = count;
			super(REMOVE_ARTICLE_CITATION_FROM_CORPUS_RESULT);
		}
		
		override public function clone() : Event
		{
			return new RemoveArticleCitationFromCorpusResultEvent(count);
		}
		
	}
	
}