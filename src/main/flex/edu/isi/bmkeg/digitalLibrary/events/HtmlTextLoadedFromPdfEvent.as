package edu.isi.bmkeg.digitalLibrary.events
{

	import flash.events.Event;
	import edu.isi.bmkeg.ftd.model.FTD;

	public class HtmlTextLoadedFromPdfEvent extends Event {

		public static const HTML_TEXT_LOADED_FROM_PDF:String = "htmlTextLoadedFromPdf";

		public var html:String;
		
		public function HtmlTextLoadedFromPdfEvent(html:String)
		{
			super(HTML_TEXT_LOADED_FROM_PDF);
			this.html = html;
		}

		override public function clone() : Event
		{
			return new HtmlTextLoadedFromPdfEvent(html);
		}

	}
}
