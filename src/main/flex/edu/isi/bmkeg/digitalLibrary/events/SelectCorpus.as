package edu.isi.bmkeg.digitalLibrary.events
{
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class SelectCorpus extends Event 
	{
		
		public static const SELECT_CORPUS:String = "selectCorpus";
		
		public var corpusId:Number;
		
		public function SelectCorpus(corpusId:Number,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false ) {
			this.corpusId = corpusId;
			super(SELECT_CORPUS, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new SelectCorpus(corpusId, bubbles, cancelable);
		}
		
	}
	
}
