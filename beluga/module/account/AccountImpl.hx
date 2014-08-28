package beluga.module.account;

import haxe.xml.Fast;
import haxe.Session;
import sys.db.Types.SId;
import sys.db.Types;

import beluga.core.Beluga;
import beluga.core.module.ModuleImpl;
import beluga.module.account.model.User;
import beluga.module.account.exception.LoginAlreadyExistException;
import beluga.module.account.ESubscribeFailCause;
import beluga.core.macro.MetadataReader;	
import beluga.core.validation.Validator;


class AccountImpl extends ModuleImpl implements AccountInternal implements MetadataReader {

    private static inline var SESSION_USER = "session_user";

	public var triggers = new AccountTrigger();
	public var widgets : AccountWidget;

	public var lastLoginError : Null<LastLoginErrorType> = null;

	public var loggedUser(get, set) : User;

	public var isLogged(get, never) : Bool;

	public function new() {
		super();
    }

	override public function initialize(beluga : Beluga) {
		this.widgets = new AccountWidget();
	}

    public function logout() : Void {
		Session.remove(SESSION_USER);
		triggers.afterLogout.dispatch();
    }

    public function login(args : {
        login : String,
        password : String
    }) {
        var user : List<User> = User.manager.dynamicSearch({
            login : args.login,
            hashPassword: haxe.crypto.Md5.encode(args.password)
        });
        if (user.length > 1) {
            //Somethings wrong in database
			triggers.loginInternalError.dispatch();
        } else if (user.length == 0) {
            //login or password wrong
            triggers.loginWrongPassword.dispatch();
        } else {
            loggedUser = user.first();
			triggers.loginSuccess.dispatch();
		}
		triggers.afterLogin.dispatch();
    }

	public function loginValidation(args : {
        login : String,
        password : String
    }) {
		//Form validation
		var validations = {
			login: {
				sizeBetween: Validator.rangeLength(args.login, 2, 255),
				notBlanckOrNull:Validator.notBlanckOrNull(args.login)
			},
			password: {
				sizeBetween: Validator.rangeLength(args.login, 2, 255),
				notBlanckOrNull: Validator.notBlanckOrNull(args.login)
			}
		};

		//Update widget
		if (!Validator.validate(validations)) {
			widgets.loginForm.loginErrorKeys = Validator.getErrorKeys(validations.login);
			widgets.loginForm.passwordErrorKeys = Validator.getErrorKeys(validations.password);
			triggers.loginValidationError.dispatch();
			return false;
		}
		return true;
	}
	
    public function subscribe(args : {
        login : String,
        password : String,
        password_conf : String,
        email : String
    }) {
        var error = "";
        if (error == "") {
            var user = new User();
            user.login = args.login;
            user.setPassword(args.password);
            //Save user in db
            user.emailVerified = true;//TODO AB Change when activation mail sended.
            user.subscribeDateTime = Date.now();
            user.email = args.email;
            user.insert();
			//TODO AB Send activation mail
            triggers.subscribeSuccess.dispatch({user: user});
        } else {
            triggers.subscribeFail.dispatch({error : error});
        }
    }

	public function getUser(userId : SId) : Null<User> {
		try
		{
			return User.manager.get(userId);
		}
		catch (e : Dynamic)
		{
			return null;
		}
	}


    public function activateUser(userId : SId) {
        var user = User.manager.get(userId);
        user.emailVerified = true;
        user.update();
    }

    public function set_loggedUser(user : User) : User {
        Session.set(SESSION_USER, user);
        return user;
    }

    public function get_loggedUser() : User {
        return Session.get(SESSION_USER);
    }

    public function get_isLogged() : Bool {
        return Session.get(SESSION_USER) != null;
    }

    public function editEmail(user : User, email : String) : Void {
        if (user != null) {
            user.email = email;
            user.update();
            beluga.triggerDispatcher.dispatch("beluga_account_edit_success", []);
            return;
        }
        beluga.triggerDispatcher.dispatch("beluga_account_edit_fail", []);
    }
}
