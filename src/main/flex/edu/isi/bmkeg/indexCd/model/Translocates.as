package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Interaction;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Translocates extends Interaction
	{
		public function Translocates(){}

		public var from_location_text:String;

		public var from_location_id:String;

		public var to_location_text:String;

		public var to_location_id:String;

	}
}