package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Feature;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class LocationFeature extends Feature
	{
		public function LocationFeature(){}

		public var location_text:String;
	
		public var location_id:String;
	}
}