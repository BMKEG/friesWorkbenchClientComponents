package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.ftd.model.*;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	
	public class RetrieveFTDRuleSetForArticleCitationResultEvent extends Event 
	{
		
		public static const RETRIEVE_FTDRULESET_FOR_ARTICLE_CITATION_RESULT:String = 
			"retrieveFTDRuleSetForArticleCitationResult";

		public var ruleSet:FTDRuleSet;
		
		public function RetrieveFTDRuleSetForArticleCitationResultEvent( ruleSet:FTDRuleSet)
		{
			this.ruleSet = ruleSet;
			super(RETRIEVE_FTDRULESET_FOR_ARTICLE_CITATION_RESULT);
		}
		
		override public function clone() : Event
		{
			return new RetrieveFTDRuleSetForArticleCitationResultEvent(ruleSet);
		}
		
	}
	
}
