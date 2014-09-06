package beluga.core.trigger ;

/**
 * ...
 * @author Alexis Brissard
 */
class Dispatcher
{
	public var lastTrigger : Dynamic;
	public var lastData : Dynamic;

	public function new() 
	{
		
	}
	
	public function dispatchVoid(trigger : TriggerVoid) {
		this.lastTrigger = trigger;
		this.lastData = null;
		trigger.dispatch();
	}
	
	public function dispatch<T>(trigger : Trigger<T>, data : T) {
		this.lastTrigger = trigger;
		this.lastData = data;
		trigger.dispatch(data);
	}

	
}