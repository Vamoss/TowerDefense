﻿package display.shooter{//creating the basic skeleton		import flash.events.Event;

	public class Turret extends Shooter{				private var destRotation:Number = 0;				public function Turret(root:TowerDefense){						super(root);					}				override protected function beginClass(e:Event):void{						super.beginClass(e);						//drawing the turret, it will have a gray, circular, base with a white gun			this.graphics.beginFill(0x999999);			this.graphics.drawCircle(0,0,_root.gridScaleHalf);			this.graphics.endFill();			this.graphics.beginFill(0xFFFFFF);			this.graphics.drawRect(-2.5, 0, 5, 20);			this.graphics.endFill();		}				override protected function update(e:Event):void{						super.update(e);						//ROTATING TOWARDS TARGET			if(enTarget != null){//if we have a defined target				//turn this baby towards it				this.rotation = Math.atan2((enTarget.y+_root.gridScaleHalf-y), enTarget.x+_root.gridScaleHalf-x)/Math.PI*180 - 90;								//TODO apply easing to rotation				//destRotation = Math.atan2((enTarget.y+_root.gridScaleHalf-y), enTarget.x+_root.gridScaleHalf-x)/Math.PI*180 - 90;				//if(destRotation - this.rotation > 180) destRotation -= 360;			}						//this.rotation += (destRotation - this.rotation) * 0.09;		}	}}