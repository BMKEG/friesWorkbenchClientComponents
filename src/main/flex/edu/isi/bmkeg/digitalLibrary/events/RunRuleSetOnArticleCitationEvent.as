package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RunRuleSetOnArticleCitationEvent extends Event 
	{
		
		public static const RUN_RULE_SET_ON_ARTICLE_CITATION:String = 
			"runRuleSetOnArticleCitation";
		
		public var ruleSetId:Number;
		public var articleId:Number;
		
		public function RunRuleSetOnArticleCitationEvent(
			ruleSetId:Number, articleId:Number)
		{
			super(RUN_RULE_SET_ON_ARTICLE_CITATION);
			this.ruleSetId = ruleSetId;
			this.articleId = articleId;
		}
		
		override public function clone() : Event
		{
			return new RunRuleSetOnArticleCitationEvent(
				ruleSetId, articleId
			);
		}
		
	}
	
}
