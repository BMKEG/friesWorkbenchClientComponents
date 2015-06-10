package edu.isi.bmkeg.digitalLibrary.events
{
	import edu.isi.bmkeg.ftd.model.*;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mx.rpc.events.FaultEvent;
	
	public class RemoveAnnotationResultEvent extends Event 
	{
		
		public static const REMOVE_ANNOTATION_RESULT:String = "removeAnnotationResult";
		
		public var completed:Boolean;
		
		public var p:int;
		public var x:int;
		public var y:int;
		public var sf:Number;
		
		public function RemoveAnnotationResultEvent(completed:Boolean,
										 bubbles:Boolean=false, 
										 cancelable:Boolean=false )
		{
			this.completed = completed;
			super(REMOVE_ANNOTATION_RESULT, bubbles, cancelable);
		}
		
		override public function clone() : Event
		{
			return new RemoveAnnotationResultEvent(completed, bubbles, cancelable);
		}
		
	}
	
}
