#
# Manifeste de module pour le module ��PSGet_PoshCCat��
#
# G�n�r� par�: Karrakis
#
# G�n�r� le�: 21/12/2020
#

@{

    # Module de script ou fichier de module binaire associ� � ce manifeste
    RootModule        = 'PoshCCat.psm1'

    # Num�ro de version de ce module.
    ModuleVersion     = '0.0.2'

    # �ditions PS prises en charge
    # CompatiblePSEditions = @()

    # ID utilis� pour identifier de mani�re unique ce module
    GUID              = '620da2d4-843f-4cf3-a0a6-aba6e6518c50'

    # Auteur de ce module
    Author            = 'Karrakis'

    # Soci�t� ou fournisseur de ce module
    CompanyName       = 'Inconnu'

    # D�claration de copyright pour ce module
    Copyright         = '(c) 2020 Karrakis. Tous droits r�serv�s.'

    # Description de la fonctionnalit� fournie par ce module
    Description       = 'Like oh-my-zsh colorize allow to have a colorized version of get-content.'

    # Version minimale du moteur Windows PowerShell requise par ce module
    # PowerShellVersion = ''

    # Nom de l'h�te Windows PowerShell requis par ce module
    # PowerShellHostName = ''

    # Version minimale de l'h�te Windows PowerShell requise par ce module
    # PowerShellHostVersion = ''

    # Version minimale du Microsoft .NET Framework requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # DotNetFrameworkVersion = ''

    # Version minimale de l�environnement CLR (Common Language Runtime) requise par ce module. Cette configuration requise est valide uniquement pour PowerShell Desktop Edition.
    # CLRVersion = ''

    # Architecture de processeur (None, X86, Amd64) requise par ce module
    # ProcessorArchitecture = ''

    # Modules qui doivent �tre import�s dans l'environnement global pr�alablement � l'importation de ce module
    RequiredModules   = @("Pansies")

    # Assemblys qui doivent �tre charg�s pr�alablement � l'importation de ce module
    # RequiredAssemblies = @()

    # Fichiers de script (.ps1) ex�cut�s dans l�environnement de l�appelant pr�alablement � l�importation de ce module
    # ScriptsToProcess = @()

    # Fichiers de types (.ps1xml) � charger lors de l'importation de ce module
    # TypesToProcess = @()

    # Fichiers de format (.ps1xml) � charger lors de l'importation de ce module
    # FormatsToProcess = @()

    # Modules � importer en tant que modules imbriqu�s du module sp�cifi� dans RootModule/ModuleToProcess
    # NestedModules = @()

    # Fonctions � exporter � partir de ce module. Pour de meilleures performances, n�utilisez pas de caract�res g�n�riques et ne supprimez pas l�entr�e. Utilisez un tableau vide si vous n�avez aucune fonction � exporter.
    FunctionsToExport = 'Get-ColorizedContent', 'Set-CcatColor', 'Get-CcatColor'

    # Applets de commande � exporter � partir de ce module. Pour de meilleures performances, n�utilisez pas de caract�res g�n�riques et ne supprimez pas l�entr�e. Utilisez un tableau vide si vous n�avez aucune applet de commande � exporter.
    CmdletsToExport   = @()

    # Variables � exporter � partir de ce module
    # VariablesToExport = @()

    # Alias � exporter � partir de ce module. Pour de meilleures performances, n�utilisez pas de caract�res g�n�riques et ne supprimez pas l�entr�e. Utilisez un tableau vide si vous n�avez aucun alias � exporter.
    AliasesToExport   = 'ccat'

    # Ressources DSC � exporter depuis ce module
    # DscResourcesToExport = @()

    # Liste de tous les modules empaquet�s avec ce module
    # ModuleList = @()

    # Liste de tous les fichiers empaquet�s avec ce module
    FileList          = 'PoshCCat.psm1'

    # Donn�es priv�es � transmettre au module sp�cifi� dans RootModule/ModuleToProcess. Cela peut �galement inclure une table de hachage PSData avec des m�tadonn�es de modules suppl�mentaires utilis�es par PowerShell.
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

    # Le pr�fixe par d�faut des commandes a �t� export� � partir de ce module. Remplacez le pr�fixe par d�faut � l�aide d�Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}



######################################################################
# Analyze                                                            #
######################################################################
# PSUseBOMForUnicodeEncodedFile occured 1                            #
######################################################################

