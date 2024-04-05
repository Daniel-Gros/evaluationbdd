# MACHINE SOUS WINDOWS
# PENSER A BIEN PLANIFIER UNE NOUVELLE TACHE DE SAUVEGARDE JOURNALIERE DANS LE PLANIFICATEUR DE TACHES

# MACHINE SOUS SYSTEME LINUX
# PENSER A BIEN AJOUTER LE SCRIPT DANS LE CRONTAB
# 0 0 * * * /Utilisateurs/Utilisateur/Documents/Daniel/backupcinéma/backup.sh POUR UNE SAUVEGARDE JOURNALIERE A MINUIT


source config.sh

backup_file="backup_$(date +%Y%m%d_%H%M%S).sql"

mysqldump --user=$db_user --password=$db_password --host=$db_host $db_name > "$backup_dir/$backup_file"