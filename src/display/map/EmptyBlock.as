﻿package display.map{	import display.shooter.Turret;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
		public class EmptyBlock extends Block{				public function EmptyBlock(root:TowerDefense, iniX:Number, iniY:Number){			super(root, iniX, iniY);		}				override protected function beginClass(e:Event):void{			super.beginClass(e);						graphics.beginFill(0x333333);			graphics.drawRect(0,0,_root.gridScale,_root.gridScale);			graphics.endFill();						this.buttonMode = true;//make this act like a button			this.addEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);//adding function for mouseOver			this.addEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);//adding function for mouseOut			this.addEventListener(MouseEvent.CLICK, thisClick);//adding function for clicking		}				override protected function destroy():void{			super.destroy();						this.removeEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);			this.removeEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);			this.removeEventListener(MouseEvent.CLICK, thisClick);		}				override public function disable():void		{			//remove all the listeners so it can't be clicked on again			this.buttonMode = false;			this.graphics.beginFill(0x333333);			this.graphics.drawRect(0,0,_root.gridScale,_root.gridScale);			this.graphics.endFill();			this.removeEventListener(MouseEvent.MOUSE_OVER, thisMouseOver);			this.removeEventListener(MouseEvent.MOUSE_OUT, thisMouseOut);			this.removeEventListener(MouseEvent.CLICK, thisClick);			}				private function thisMouseOver(e:MouseEvent):void{			//changing the background so the user know's it's clickable			this.graphics.beginFill(0x006600);			this.graphics.drawRect(0,0,_root.gridScale,_root.gridScale);			this.graphics.endFill();		}				private function thisMouseOut(e:MouseEvent):void{			//changing the background back			this.graphics.beginFill(0x333333);			this.graphics.drawRect(0,0,_root.gridScale,_root.gridScale);			this.graphics.endFill();		}				private function thisClick(e:MouseEvent):void{			_root.game.shooterSelector.select(this);		}	}}