package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class FullyDeleteArticleResultEvent extends Event 
	{
		
		public static const FULLY_DELETE_ARTICLE_RESULT:String = "fullyDeleteArticleResult";
		
		public var success:Boolean;
			
		public function FullyDeleteArticleResultEvent(success:Boolean,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.success = success;
			super(FULLY_DELETE_ARTICLE_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new FullyDeleteArticleResultEvent(success, bubbles, cancelable);
		}
		
	}
	
}
