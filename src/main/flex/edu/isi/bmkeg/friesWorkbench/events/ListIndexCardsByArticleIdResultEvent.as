package edu.isi.bmkeg.friesWorkbench.events
{
	
	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import edu.isi.bmkeg.digitalLibrary.model.qo.citations.Corpus_qo;

	import mx.rpc.events.FaultEvent;
	
	public class ListIndexCardsByArticleIdResultEvent extends Event 
	{
		
		public static const LIST_INDEX_CARDS_BY_ARTICLE_PAGED_RESULT:String = "listIndexCardsByArticlePagedResult";
		
		public var list:ArrayCollection;
		
		public function ListIndexCardsByArticleIdResultEvent(list:ArrayCollection, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(LIST_INDEX_CARDS_BY_ARTICLE_PAGED_RESULT);
			this.list = list;
		}
		
		override public function clone() : Event
		{
			return new ListIndexCardsByArticleIdResultEvent(list, bubbles, cancelable);
		}

	}
	
}
