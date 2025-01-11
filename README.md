# Common Hostnames

Ce dépôt contient une liste de noms d'hôtes courants utilisés dans les environnements informatiques. Ces noms sont utiles lors des tests de pénétration (pentesting) pour identifier rapidement les services ou infrastructures vulnérables en fonction des conventions de dénomination standard.

## Structure des noms d'hôtes

Les noms suivent une convention qui aide à identifier les rôles des serveurs, comme par exemple :
- `srv-ad1` : Serveur Active Directory 1
- `srv-dns01` : Serveur DNS 1
- `srv-wsus01` : Serveur WSUS
- `srv-glpi` : Serveur de gestion de parc (GLPI)
- `srv-esxi` : Serveur de virtualisation ESXi

## Cas d'usage en Pentesting

1. **Enumeration des services de domaine** :
   - Utilisez des noms comme `srv-ad` ou `srv-dc` pour cibler les contrôleurs de domaine et les services liés à Active Directory.
   - Recherchez des serveurs nommés `srv-dns` pour identifier des serveurs DNS potentiellement mal configurés.

2. **Exploration des serveurs de mise à jour et de distribution** :
   - Ciblez des serveurs comme `srv-wsus` ou `srv-updates` pour rechercher des vulnérabilités dans les services de mise à jour, qui peuvent être mal sécurisés.

3. **Identification des systèmes de gestion** :
   - Les outils comme `srv-glpi` ou `srv-otrs` sont souvent utilisés pour la gestion de parc informatique, et leur accès peut révéler des informations sensibles sur l'infrastructure.

4. **Découverte des systèmes de virtualisation** :
   - Utilisez des noms comme `srv-esx` ou `srv-hyperv` pour repérer des hôtes hyperviseurs, qui peuvent permettre d'attaquer les machines virtuelles hébergées sur ces serveurs.

5. **Exploitation des services de gestion de code** :
   - Recherchez des serveurs comme `srv-gitlab` ou `srv-jenkins` qui peuvent exposer des vulnérabilités liées à l'intégration continue ou à la gestion de versions de code.

6. **Énumération des serveurs de stockage** :
   - Cibler des serveurs comme `srv-storage` ou `srv-nas` pour repérer des volumes de données sensibles, souvent partagés ou mal sécurisés.

## Contribuer

Si vous avez d'autres suggestions de noms d'hôtes courants dans les environnements que vous testez, n'hésitez pas à proposer des modifications via une Pull Request.
