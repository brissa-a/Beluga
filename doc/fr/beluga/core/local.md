#La localisation

Beluga implémente son propre systeme de localisation.

##Utilisation simple
Tout d'abord il faut créer un dossier contenant tout les fichiers de localisation quelque part dans l'arboréscence de Beluga.
Le dossier et son contenu doit ressembler a ca:
```
local
|-- en_US.json
`-- fr_FR.json
```
Chaque fichier est un fichier au format json et ne doit contenir qu'une seul langue.
Le contenu d'un fichier est comme ceci:

```json
{
    "key": "Valeur",
    "password": "Mot de passe",
    "alreadyLogged": "Vous êtes déja connecté"
}
```

Récupérer une valeur et changer de langue se fait ensuite ainsi dans le code source:
```haxe
i18n = BelugaI18n.loadI18nFolder("path/to/local/");
Sys.println(i18n.password); //Affiche "Mot de passe"
BelugaI18n.curLang = "en_US";
Sys.println(i18n.password); //Affiche maintenant "Password"
```

##Héritage
Il est possible de hierarchiser plusieurs dossier de local. Imaginons les 2 fichier suivant:

*local_father/fr_FR.json*
```json
{
    "family": "On est de la famille des Locals",
    "hello": "Bonjour je suis le père !"
}
```

*local_child/fr_FR.json*
```json
{
    "hello": "Bonjour je suis le fils !"
}
```

Le code suivant affiche:
```haxe
father = BelugaI18n.loadI18nFolder("local_father");
child = BelugaI18n.loadI18nFolder("local_child", father);

Sys.println(father.hello) //Affiche "Bonjour je suis le père !"
Sys.println(father.family)//Affiche "On est de la famille des Locals"

Sys.println(child.hello) //Affiche "Bonjour je suis le fils !"
Sys.println(child.family)//Affiche "On est de la famille des Locals"
```

##Application dans Beluga
Beluga a 3 niveau de local:
- les locals global a Beluga
- les locals spécifique au module
- les locals spécifique au widget
