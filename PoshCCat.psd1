#
# Manifeste de module pour le module « PSGet_PoshCCat »
#
# Généré par : Karrakis
#
# Généré le : 21/12/2020
#

@{

    # Module de script ou fichier de module binaire associé à ce manifeste
    RootModule        = 'PoshCCat.psm1'

    # Numéro de version de ce module.
    ModuleVersion     = '0.0.2'

    # Éditions PS prises en charge
    # CompatiblePSEditions = @()

    # ID utilisé pour identifier de manière unique ce module
    GUID              = '620da2d4-843f-4cf3-a0a6-aba6e6518c50'

    # Auteur de ce module
    Author            = 'Karrakis'

    # Société ou fournisseur de ce module
    CompanyName       = 'Inconnu'

    # Déclaration de copyright pour ce module
    Copyright         = '(c) 2020 Karrakis. Tous droits réservés.'

    # Description de la fonctionnalité fournie par ce module
    Description       = 'Like oh-my-zsh colorize allow to have a colorized version of get-content.'

    # Version minimale du moteur Windows PowerShell requise par ce module
    # PowerShellVersion = ''

    # Nom de l'hôte Windows PowerShell requis par ce module
    # PowerShellHostName = ''

    # Version minimale de l'hôte Windows PowerShell requise par ce module
    # PowerShellHostVersion = ''

    # Version minimale du Microsoft .NET Framework requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # DotNetFrameworkVersion = ''

    # Version minimale de l’environnement CLR (Common Language Runtime) requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # CLRVersion = ''

    # Architecture de processeur (None, X86, Amd64) requise par ce module
    # ProcessorArchitecture = ''

    # Modules qui doivent être importés dans l'environnement global préalablement à l'importation de ce module
    RequiredModules   = @("Pansies")

    # Assemblys qui doivent être chargés préalablement à l'importation de ce module
    # RequiredAssemblies = @()

    # Fichiers de script (.ps1) exécutés dans l’environnement de l’appelant préalablement à l’importation de ce module
    # ScriptsToProcess = @()

    # Fichiers de types (.ps1xml) à charger lors de l'importation de ce module
    # TypesToProcess = @()

    # Fichiers de format (.ps1xml) à charger lors de l'importation de ce module
    # FormatsToProcess = @()

    # Modules à importer en tant que modules imbriqués du module spécifié dans RootModule/ModuleToProcess
    # NestedModules = @()

    # Fonctions à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune fonction à exporter.
    FunctionsToExport = 'Get-ColorizedContent', 'Set-CcatColor', 'Get-CcatColor'

    # Applets de commande à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune applet de commande à exporter.
    CmdletsToExport   = @()

    # Variables à exporter à partir de ce module
    # VariablesToExport = @()

    # Alias à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucun alias à exporter.
    AliasesToExport   = 'ccat'

    # Ressources DSC à exporter depuis ce module
    # DscResourcesToExport = @()

    # Liste de tous les modules empaquetés avec ce module
    # ModuleList = @()

    # Liste de tous les fichiers empaquetés avec ce module
    FileList          = 'PoshCCat.psm1'

    # Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess. Cela peut également inclure une table de hachage PSData avec des métadonnées de modules supplémentaires utilisées par PowerShell.
    PrivateData       = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = @('PSEdition_Desktop', 'Windows', 'Module')

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/belotn/PoshCCat/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/belotn/PoshCCat'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

            # External dependent modules of this module
            # ExternalModuleDependencies = ''

        } # End of PSData hashtable
    
    } # End of PrivateData hashtable

    # URI HelpInfo de ce module
    HelpInfoURI       = 'https://github.com/belotn/PoshCCat/blob/main/README.md'

    # Le préfixe par défaut des commandes a été exporté à partir de ce module. Remplacez le préfixe par défaut à l’aide d’Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}



######################################################################
# Analyze                                                            #
######################################################################
# PSUseBOMForUnicodeEncodedFile occured 1                            #
######################################################################

