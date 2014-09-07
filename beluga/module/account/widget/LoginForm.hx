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
		id: Int
	};
	
	public static var id(default, null) = 0;
	
	
	private function new (mttfile = "beluga_account_login.mtt") {
		super(mttfile);
		var acc = Beluga.getInstance().getModuleInstance(Account);

		this.context = {
			isLogged : acc.isLogged,
			loggedUser : acc.loggedUser,
			base_url : ConfigLoader.getBaseUrl(),
			id: LoginForm.id++
		};
	}

	override public function render() : String {
        return template.execute(context);
	}

}
