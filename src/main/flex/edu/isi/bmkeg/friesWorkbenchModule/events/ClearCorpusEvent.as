package edu.isi.bmkeg.friesWorkbenchModule.events
{
	
	import flash.events.Event;
	
	public class ClearCorpusEvent extends Event
	{
		public static const CLEAR_CORPUS:String = "clearCorpus";
		

		/**
		 * selected Article or null if none is selected
		 */
		public var code:String;
		
		public function ClearCorpusEvent(bubbles:Boolean=false, 
												 cancelable:Boolean=false)
		{
			super(CLEAR_CORPUS, bubbles, cancelable);
		}

		override public function clone():Event
		{
			return new ClearCorpusEvent(bubbles, cancelable)
		}

	}
}