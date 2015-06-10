package edu.isi.bmkeg.digitalLibraryModule.view
{
	import edu.isi.bmkeg.ftd.model.FTDFragmentBlock;
	
	import flash.display.Sprite;
	import flash.text.*;
	
	public class FragmentSprite extends Sprite
	{
		private var r:Number = 4.0;
		
		public var ftdAnn:FTDFragmentBlock;
		public var sf:Number;
		public var frgId:String;
		public var blkId:int;
		public var fill:uint;
		
		public var dismissControl:Sprite;
		
		public var addCodeControl:TextField;

		public var idControl:Sprite;
		
		
		public function FragmentSprite(frgId:String, 
									   blkId:int, 
									   ftdAnn:FTDFragmentBlock, 
									   sf:Number, 
									   fill:uint=0xffff00)
		{
			super();
			this.ftdAnn = ftdAnn;
			this.sf = sf;
			this.frgId = frgId;
			this.blkId = blkId;
			this.fill = fill;
			
			this.graphics.lineStyle(1, 0xff0000, 0.2)
			this.graphics.moveTo(ftdAnn.x1 * sf,ftdAnn.y1 * sf);
			this.graphics.beginFill(fill, 0.2);
			//
			// this is what happens if the fragment is on the same line
			//
			if( ftdAnn.y2 == ftdAnn.y3 ) {
				this.graphics.lineTo(ftdAnn.x1*sf, ftdAnn.y3*sf);
				this.graphics.lineTo(ftdAnn.x3*sf, ftdAnn.y3*sf);
				this.graphics.lineTo(ftdAnn.x3*sf, ftdAnn.y1*sf);
				this.graphics.lineTo(ftdAnn.x1*sf, ftdAnn.y1*sf);
				
				this.dismissControl = this.generateDismissControl(
					ftdAnn.x3*sf, ftdAnn.y3*sf);
				
				this.addCodeControl = this.generateAddCodeControl(
					(ftdAnn.x3-3*(r+3))*sf, 
					(ftdAnn.y3+r+1)*sf);
								
			} 
			// 
			// multi-line
			// 
			else {
				this.graphics.lineTo(ftdAnn.x1*sf, ftdAnn.y2*sf);
				this.graphics.lineTo(ftdAnn.x2*sf, ftdAnn.y2*sf);
				this.graphics.lineTo(ftdAnn.x2*sf, ftdAnn.y3*sf);
				this.graphics.lineTo(ftdAnn.x3*sf, ftdAnn.y3*sf);
				this.graphics.lineTo(ftdAnn.x3*sf, ftdAnn.y4*sf);
				this.graphics.lineTo(ftdAnn.x4*sf, ftdAnn.y4*sf);
				this.graphics.lineTo(ftdAnn.x4*sf, ftdAnn.y1*sf);
				this.graphics.lineTo(ftdAnn.x1*sf, ftdAnn.y1*sf);
				
				this.dismissControl = this.generateDismissControl(
					ftdAnn.x2 * this.sf,
					ftdAnn.y2 * this.sf);
				
				this.addCodeControl = this.generateAddCodeControl(
					(ftdAnn.x2-3*(r+1)) * this.sf, 
					(ftdAnn.y2+r+1) * this.sf);
							
			}
			this.graphics.endFill();
			
			this.idControl = this.generateIdControl(this.frgId, this.blkId);
			this.addChild(this.idControl);
			
		}
	
		public function generateAddCodeControl(x:Number, y:Number):TextField {
			
			var ctl:TextField= new TextField();
			
			var f:TextFormat = new TextFormat(); 
			f.color = 0xFF0000; 
			f.bold = true;
			ctl.setTextFormat(f);
			
			ctl.x = x;
			ctl.y = y;
			ctl.text= ftdAnn.code;
				
			return ctl;
			
		}
				
		public function generateDismissControl(x:Number, y:Number):Sprite {
						
			var ctl:Sprite = new Sprite();
			var r:Number = 4.0;
			
			ctl.graphics.lineStyle(1, 0x000000, 1.0)
			ctl.graphics.beginFill(0xff0000, 1.0);
			ctl.graphics.drawCircle(x,y,r+2);
			ctl.graphics.lineStyle(2, 0xffffff, 1.0)
			ctl.graphics.endFill();
			ctl.graphics.moveTo(x,y);
			ctl.graphics.lineTo(x - r * Math.cos(45), y + r * Math.cos(45) );
			ctl.graphics.moveTo(x,y);
			ctl.graphics.lineTo(x + r * Math.cos(45), y - r * Math.cos(45) );
			ctl.graphics.moveTo(x,y);
			ctl.graphics.lineTo(x + r * Math.cos(45), y + r * Math.cos(45) );
			ctl.graphics.moveTo(x,y);
			ctl.graphics.lineTo(x - r * Math.cos(45), y - r * Math.cos(45) );
			
			return ctl;
			
		}
		
		public function generateIdControl(frgId:String, blkId:int):Sprite {

			var idControl:Sprite = new Sprite();
			
			var t:TextField = new TextField();
			t.selectable = false;
			var tf:TextFormat = new TextFormat(); 
			tf.size = 10; 
			tf.font = "Courier"; 
			t.setTextFormat(tf);
			var s:String = String(frgId + "." + (blkId+1) );
			t.text = s;
			t.textColor = 0xff0000;			
			t.height = t.textHeight + 4;
			t.width = t.textWidth + 4;
			
			var r:Number = (Math.max(t.textHeight, t.textWidth) / 2 ) + 2;
			var x:Number = (ftdAnn.x1 - r ) * this.sf;
			var y:Number = (ftdAnn.y2 - (t.textHeight + 6)/2 ) * this.sf;
			
			idControl.graphics.lineStyle(1, 0xff0000)
			idControl.graphics.beginFill(this.fill);
			idControl.graphics.drawRoundRect(x, y, 2*r + 4, t.textHeight + 6, 6);
			idControl.graphics.endFill();
			
			idControl.addChild(t);
			t.x = x + 2;
			t.y = y + 3;
			
			return idControl;
			
		}
		
		
	}
	
}