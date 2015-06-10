package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RemoveAnnotationEvent extends Event 
	{
		
		public static const REMOVE_ANNOTATION:String = "removeAnnotation";
		
		public var ftdAnn:FTDFragmentBlock;
			
		public function RemoveAnnotationEvent(ftdAnn:FTDFragmentBlock,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.ftdAnn = ftdAnn;
			super(REMOVE_ANNOTATION, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new RemoveAnnotationEvent(ftdAnn, bubbles, cancelable);
		}
		
	}
	
}
