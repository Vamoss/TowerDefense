package display.shooter{//creating the basic skeleton		import flash.events.Event;

	public class Freezer extends Shooter{				public var iceFactor:Number;//how much the bullet deaccelerate the target				public function Freezer(root:TowerDefense){						super(root);						cost = 15;			damage = 1;			range = 50;			iceFactor = 0.5;		}				override protected function beginClass(e:Event):void{						super.beginClass(e);						//drawing the turret, it will have a gray, circular, base with a white gun			this.graphics.beginFill(0x999999);			this.graphics.drawRect(-_root.gridScaleHalf,-_root.gridScaleHalf,_root.gridScale,_root.gridScale);			this.graphics.endFill();			this.graphics.beginFill(0xFFFFFF);			this.graphics.drawRect(-2.5, 0, 5, 20);			this.graphics.endFill();		}	}}