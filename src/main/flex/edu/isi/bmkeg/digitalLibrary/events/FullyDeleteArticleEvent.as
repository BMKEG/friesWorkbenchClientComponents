package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class FullyDeleteArticleEvent extends Event 
	{
		
		public static const FULLY_DELETE_ARTICLE:String = "fullyDeleteArticle";
		
		public var articleId:Number;
			
		public function FullyDeleteArticleEvent(articleId:Number,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.articleId = articleId;
			super(FULLY_DELETE_ARTICLE, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new FullyDeleteArticleEvent(articleId, bubbles, cancelable);
		}
		
	}
	
}
