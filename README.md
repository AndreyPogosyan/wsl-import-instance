This script accepts a WSL instance name and a tar filename as parameters. It terminates the instance if running, unregisters it, and then imports the tar file from a hardcoded base path as a new WSL instance.

PARAMETER InstanceName - The name of the WSL instance to manage.
PARAMETER TarFileName - The name of the tar backup file (without path). This must be created manually or through automation and needs to exists.

EXAMPLE:
.\ManageWSLInstance.ps1 -InstanceName "Learn-React" -TarFileName "Ubuntu.tar"
