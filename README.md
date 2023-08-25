# Admissions-OFPRA
Ce code permet une représentation cartographique des admissions par l'OFPRA à la protection internationale (taux d'admission annuel  et nombre annuel de demandes statuées), exportée dans une application Rshiny et visible sur https://juliadescamps.shinyapps.io/admissions-ofpra/ 

## Contexte
L'Office Français de Protection des Réfugiés et Apatrides (OFPRA) est un établissement public administratif qui statue sur les demandes de protection internationale qui lui sont soumises.

"Les mineurs (...) déposent désormais une demande d'asile en leur nom propre, via leurs représentants légaux" (voir le fichier pdf "documentation-ofpra-décisions" sur data.gouv). Le champ concerne donc les majeur-es et les mineur-es. 

Attention, les données utilisées concernent l’activité de l’OFPRA. Comme précisé sur data.gouv : les demandes de protection internationale qui y sont comptabilisées "ne correspondent pas au nombre total de demandes d’asile publié par le service statistique de la direction générale étrangers en France du ministère de l’Intérieur, qui inclut notamment les demandeurs d’asile sous procédure Dublin".
De plus, les décisions statuées une année donnée ne correspondent pas forcément aux demandes déposées la même année, mais peuvent porter sur des demandes déposées lors des années antérieures - ce qui est le cas lorsque les démarches administratives sont longues. Enfin, les pays pour lesquels les demandes concernaient moins de 5 personnes ne sont pas représentés.

Le taux d'admission à la protection internationale est défini comme rapport entre le nombre de décisions positives (pour l'obtention du statut de réfugié-e ou de la protection subsidiaire) et le nombre total de demandes statuées sur une année donnée.


## Aspects techniques
Les données sont disponibles sur data.gouv (https://www.data.gouv.fr/fr/datasets/decisions-relatives-aux-demandes-dasile-et-de-statut-dapatride/). Je les ai remises en forme pour pouvoir appliquer les fonctions de leaflet.

L'affichage est long en raison de la taille des fichiers et des différentes couches, mais je n'ai pas encore trouvé de moyen de l'améliorer (cela serait peut-être possible avec un fond de carte moins lourd). 
