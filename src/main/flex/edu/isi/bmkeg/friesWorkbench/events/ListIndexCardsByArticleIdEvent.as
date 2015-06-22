package edu.isi.bmkeg.friesWorkbench.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.ArticleCitation_qo;

	import mx.rpc.events.FaultEvent;
	
	public class ListIndexCardsByArticleIdEvent extends Event 
	{
		
		public static const LIST_INDEX_CARDS_BY_ARTICLE_PAGED:String = "listIndexCardsByArticlePaged";
		
		public var object:Number;
				
		public function ListIndexCardsByArticleIdEvent(object:Number, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(LIST_INDEX_CARDS_BY_ARTICLE_PAGED, bubbles, cancelable);
			this.object = object;
		}
		
		override public function clone() : Event
		{
			return new ListIndexCardsByArticleIdEvent(object, bubbles, cancelable);
		}

	}
	
}
