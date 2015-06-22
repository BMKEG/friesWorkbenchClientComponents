package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Entity;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Protein extends Entity
	{
		public function Protein(){}

		public var indentifier:String;

		public var not_features:ArrayCollection = new ArrayCollection();

		public var features:ArrayCollection = new ArrayCollection();
	}
}