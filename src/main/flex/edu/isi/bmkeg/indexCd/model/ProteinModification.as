package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Feature;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ProteinModification extends Feature
	{
		public function ProteinModification(){}

	
		public var modification_type:String;
	
		public var site:int;
	}
}