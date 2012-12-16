package display.bullet{	import display.enemy.Enemy;		import flash.display.MovieClip;	import flash.events.Event;

	public class Rock extends Bullet {				public var spread:Number;				public function Rock(root:TowerDefense, _spread:Number) {			super(root);						spread = _spread;		}				override protected function beginClass(e:Event):void {			super.beginClass(e);			//drawing this guy (it'll be a small white circle)			this.graphics.clear();			this.graphics.beginFill(0x883300);			this.graphics.drawCircle(0,0,2);			this.graphics.endFill();		}				override protected function onHit():void		{			super.onHit();									//search for enemies close to the spread area			var cEnemy:Enemy;			var distance:Number;			for(var i:uint=0; i < _root.game.enemyHolder.numChildren;i++){//loop through the children in enemyHolder				cEnemy = _root.game.enemyHolder.getChildAt(i) as Enemy;//define a movieclip that will hold the current child				if(cEnemy!=target){					distance = Math.sqrt(Math.pow(cEnemy.y - y, 2) + Math.pow(cEnemy.x - x, 2));//this simple formula with get us the distance of the current enemy					if(distance < spread){						cEnemy.health -= damage*(1-distance/spread);					}				}			}		}	}}