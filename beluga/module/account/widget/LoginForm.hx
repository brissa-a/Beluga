package beluga.module.account.widget;

import beluga.core.Beluga;
import beluga.core.widget.MttWidget;
import beluga.core.macro.ConfigLoader;
import beluga.module.account.Account;
import beluga.module.account.AccountImpl;
import beluga.module.account.model.User;
import beluga.core.widget.AccountWidget;

/**
 * ...
 * @author brissa_A
 */
class LoginForm extends AccountWidget
{
	public var context : {
		isLogged : Bool,
		loggedUser : User,
		base_url : String,
		id: Int,
		error: String
	};
	
	public static var id(default, null) = 0;
	
	private function new (mttfile = "beluga_account_login.mtt") {
		super(mttfile);
		var acc = Beluga.getInstance().getModuleInstance(Account);
		var error = null;
		trace(acc.lastDispatch);
		if (acc.lastDispatch.trigger == acc.triggers.loginWrongLogin) {
			error = "Invalid login and / or password";
		} else if (acc.lastDispatch.trigger == acc.triggers.loginWrongPassword) {			
			error = "Invalid login and / or password";
		} else if (acc.lastDispatch.trigger == acc.triggers.loginInternalError) {
			error = "Something's wrong in database";			
		} else if (acc.lastDispatch.trigger == acc.triggers.loginUserBanned) {
			error = "Your account as been banned";			
		}
		this.context = {
			isLogged : acc.isLogged,
			loggedUser : acc.loggedUser,
			base_url : ConfigLoader.getBaseUrl(),
			id: LoginForm.id++,
			error: error
		};
	}

	override public function render() : String {
        return template.execute(context);
	}

}
