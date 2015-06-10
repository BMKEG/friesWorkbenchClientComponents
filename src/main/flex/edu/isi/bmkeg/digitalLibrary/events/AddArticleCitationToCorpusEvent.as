package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	public class AddArticleCitationToCorpusEvent extends Event 
	{
		
		public static const ADD_ARTICLE_CITATION_TO_CORPUS:String = "addArticleCitationToCorpus";
		
		public var articleIds:ArrayCollection;
		public var corpusId:Number;
		
		public function AddArticleCitationToCorpusEvent(articleIds:ArrayCollection, 
														corpusId:Number,
														bubbles:Boolean=false)
		{
			this.articleIds = articleIds;
			this.corpusId = corpusId;
			super(ADD_ARTICLE_CITATION_TO_CORPUS, bubbles);
		}
		
		override public function clone() : Event
		{
			return new AddArticleCitationToCorpusEvent(articleIds, corpusId);
		}
		
	}
	
}
