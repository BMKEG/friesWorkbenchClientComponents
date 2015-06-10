package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	import mx.collections.ArrayCollection;
	
	public class RemoveArticleCitationFromCorpusEvent extends Event 
	{
		
		public static const REMOVE_ARTICLE_CITATION_FROM_CORPUS:String = "removeArticleCitationFromCorpus";
		
		public var articleIds:ArrayCollection;
		public var corpusId:Number;
		
		public function RemoveArticleCitationFromCorpusEvent(articleIds:ArrayCollection, corpusId:Number) {
			this.articleIds = articleIds;
			this.corpusId = corpusId;
			super(REMOVE_ARTICLE_CITATION_FROM_CORPUS);
		}
		
		override public function clone() : Event
		{
			return new RemoveArticleCitationFromCorpusEvent(articleIds, corpusId);
		}
		
	}
	
}