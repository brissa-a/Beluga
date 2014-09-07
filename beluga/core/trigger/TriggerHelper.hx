package beluga.core.trigger;

/**
 * ...
 * @author Alexis Brissard
 */

typedef LastDispatch = { trigger: Dynamic, data : Dynamic };
 
class TriggerHelper
{

	public static function dispatchSaveLast<T>(trigger : Trigger<T>, data : T ) : LastDispatch {
		trigger.dispatch(data);		
		return { trigger: trigger, data: data };
	}

}

class TriggerVoidHelper
{
	public static function dispatchSaveLast(trigger : TriggerVoid) : LastDispatch {
		trigger.dispatch();
		return { trigger: trigger, data: null };
	}

}