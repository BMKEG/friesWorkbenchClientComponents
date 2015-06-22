package edu.isi.bmkeg.indexCd.model
{
	import edu.isi.bmkeg.indexCd.model.Entity;
	
	import mx.collections.ArrayCollection;

	[Bindable]
	public class Complex extends Entity
	{
		public function Complex(){}

		public var entities:ArrayCollection = new ArrayCollection();
	}
}