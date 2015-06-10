package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RetrieveFTDRuleSetForArticleCitationEvent extends Event 
	{
		
		public static const RETRIEVE_FTDRULESET_FOR_ARTICLE_CITATION:String = 
			"retrieveFTDRuleSetForArticleCitation";
		
		public var articleId:Number;
		
		public function RetrieveFTDRuleSetForArticleCitationEvent(articleId:Number)
		{
			super(RETRIEVE_FTDRULESET_FOR_ARTICLE_CITATION);
			this.articleId = articleId;
		}
		
		override public function clone() : Event
		{
			return new RetrieveFTDRuleSetForArticleCitationEvent(articleId);
		}
		
	}
	
}
