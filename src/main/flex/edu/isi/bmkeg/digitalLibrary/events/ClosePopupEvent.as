package edu.isi.bmkeg.digitalLibrary.events
{
	
	import edu.isi.bmkeg.digitalLibrary.model.citations.Corpus;
	
	import flash.events.Event;
	import flash.utils.ByteArray;
	import spark.components.TitleWindow;

	import mx.rpc.events.FaultEvent;
	
	public class ClosePopupEvent extends Event 
	{
		
		public static const CLOSE_POPUP:String = "closePopup";
		
		public var popup:TitleWindow;
		
		public function ClosePopupEvent(popup:TitleWindow)
		{
			this.popup = popup;
				
			super(CLOSE_POPUP);
		}
		
		override public function clone() : Event
		{
			return new ClosePopupEvent(popup);
		}
		
	}
	
}
