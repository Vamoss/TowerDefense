package display.shooter{//creating the basic skeleton		import flash.events.Event;

	public class Catapult extends Shooter{				public var spread:Number;//how much the bullet spread				public function Catapult(root:TowerDefense){						super(root);						cost = 30;			damage = 5;			range = 100;			spread = 60;		}				override protected function beginClass(e:Event):void{						super.beginClass(e);						//drawing the turret, it will have a gray, circular, base with a white gun			this.graphics.beginFill(0x999999);			var angle:Number;			var sides:Number = 5;			for(var i:uint = 0; i<sides; i++)			{				angle = i/sides*Math.PI*2;				if(i==0){					graphics.moveTo(Math.sin(angle) * _root.gridScaleHalf, Math.cos(angle) * _root.gridScaleHalf);				}				graphics.lineTo(Math.sin(angle) * _root.gridScaleHalf, Math.cos(angle) * _root.gridScaleHalf);			}			this.graphics.endFill();			this.graphics.beginFill(0xFFFFFF);			this.graphics.drawRect(-2.5, 0, 5, 20);			this.graphics.endFill();		}	}}