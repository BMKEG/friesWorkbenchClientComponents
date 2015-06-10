package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRuleSetOnArticleCitationResultEvent extends Event 
	{
		
		public static const RUN_RULE_SET_ON_ARTICLE_CITATION_RESULT:String = 
			"runRuleSetOnArticleCitationResult";
		
		public var articleId:Number;
		
		public function RunRuleSetOnArticleCitationResultEvent(
			articleId:Number)
		{
			super(RUN_RULE_SET_ON_ARTICLE_CITATION_RESULT);
			this.articleId = articleId;
		}
		
		override public function clone() : Event
		{
			return new RunRuleSetOnArticleCitationResultEvent(
				articleId
			);
		}
		
	}
	
}
