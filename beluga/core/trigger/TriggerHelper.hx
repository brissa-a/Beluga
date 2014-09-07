package beluga.core.trigger;

/**
 * ...
 * @author Alexis Brissard
 */

typedef LastDispatch = { trigger: Dynamic, data : Dynamic };
 
class TriggerHelper
{

	public static function dispatchSaveLast<T>(trigger : Trigger<T>, data : T, container : {lastDispatch : LastDispatch} ) {
		container.lastDispatch = { trigger: trigger, data: data };
		trigger.dispatch(data);		
	}

}

class TriggerVoidHelper
{
	public static function dispatchSaveLast(trigger : TriggerVoid, container : { lastDispatch : LastDispatch } ) {
		container.lastDispatch = { trigger: trigger, data: null };
		trigger.dispatch();
	}

}