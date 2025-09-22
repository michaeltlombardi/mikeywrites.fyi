<#

#>

[CmdletBinding()]
param(
  [ValidateSet(
    'vale-sync',
    'vale-clean',
    'vale-get-rules',
    'vale-docs'
  )]
  [string[]]$Task
)

begin {
  class ValeStyleRuleDefinition {
    [string] $Level
    [string] $Scope
    [string] $Description
    [string] $Message
    [bool]   $HasAction
  }
  class ValeStyleRule {
    [string]$Style
    [string]$Name
    [System.IO.FileInfo]$FileInfo
    [ValeStyleRuleDefinition]$Definition
    hidden [System.Nullable[bool]] $IsValidForDocumentation

    [string] PackageRootPath() {
      if ($null -eq $this.FileInfo) {
        return [NullString]::Value
      }

      return $this.FileInfo.Directory.Parent.Parent.FullName
    }

    [string] MarkdownDocumentationHeading() {
      if (-not $this.ValidateForDocumentation()) {
        throw "Unable to document rule"
      }

      $fullName = '{0}.{1}' -f $this.Style, $this.Name
      $anchor   = '<a id="{0}"></a>' -f $fullName

      if ($null -eq $this.FileInfo) {
        return '### {0}{1}' -f $anchor, $fullName
      }

      $resolving = @{
        Path             = $this.FileInfo.FullName
        RelativeBasePath = $this.PackageRootPath()
        Relative         = $true
      }
      $rulePath = (Resolve-Path @resolving) -replace '\\', '/'
      $link     = '[Definition file]({0})' -f $rulePath

      return ('### {0} `{1}` ({2})' -f $anchor, $fullName, $link)
    }

    [bool] ValidateForDocumentation() {
      if ($null -ne $this.IsValidForDocumentation) {
        return $this.IsValidForDocumentation
      }

      $missing = @()
      if ([string]::IsNullOrWhiteSpace($this.Style)) {
        $missing += 'Style'
      }
      if ([string]::IsNullOrWhiteSpace($this.Style)) {
        $missing += 'Name'
      }
      if ($null -eq $this.Definition) {
        $missing += 'Definition'
      }

      if ($missing.Length -gt 0) {
        Write-Warning "Missing required properties: $missing"
        return ($this.IsValidForDocumentation = $false)
      }

      return ($this.IsValidForDocumentation = $true)
    }

    [string] ToMarkdownDocumentationTableEntry() {
      if (-not $this.ValidateForDocumentation()) {
        throw "Unable to document rule"
      }
      $fullName = '{0}.{1}' -f $this.Style, $this.Name

      $columns = @{
        Rule    = '[`{0}`](#{0})' -f $fullName
        Level   = '`{0}`' -f $this.Definition.Level
        Scope   = '`{0}`' -f $this.Definition.Scope
        Fixable = ($this.Definition.HasAction) ? 'Yes' : 'No'
      }

      return '| {0} | {1} | {2} | {3} |' -f @(
        $columns.Rule
        $columns.Level
        $columns.Scope
        $columns.Fixable
      )
    }

    [string] ToMarkdownDocumentationSection() {
      if (-not $this.ValidateForDocumentation()) {
        throw "Unable to document rule"
      }

      $sb = [System.Text.StringBuilder]::new()
      $sb.Append($this.MarkdownDocumentationHeading())
      $sb.Append("`n`n")
      if ([string]::IsNullOrEmpty($this.Definition.Description)) {
        $sb.append("_No description._`n`n")
      } else {
        $sb.Append([string]($this.Definition.Description -replace "`r`n", "`n"))
        $sb.Append("`n`n")
      }

      $sb.Append('```yaml').Append("`n")
      $sb.Append('Level   : {0}' -f $this.Definition.Level).Append("`n")
      $sb.Append('Scope   : {0}' -f $this.Definition.Scope).Append("`n")
      $sb.Append('Fixable : {0}' -f $this.Definition.HasAction).Append("`n")
      $sb.Append('```').Append("`n")
      return $sb.ToString()
    }

    ValeStyleRule() {}

    ValeStyleRule([System.IO.FileInfo]$ruleFile) {
      if ($null -eq $ruleFile) {
        throw "nope"
      }
      $data = Get-Content -Raw -Path $ruleFile.FullName
      | yayaml\ConvertFrom-Yaml -ErrorAction Stop

      $this.FileInfo   = $ruleFile
      $this.Name       = $ruleFile.BaseName
      $this.Style      = $ruleFile.Directory.Name
      $this.Definition = [ValeStyleRuleDefinition]@{
        Level       = ($null -ne $data.level) ? $data.level : 'suggestion'
        Scope       = ($null -ne $data.scope) ? $data.scope : 'text'
        Description = (-not [string]::IsNullOrEmpty($data.description)) ?
                      $data.description : ''
        Message     = (-not [string]::IsNullOrEmpty($data.message)) ?
                      $data.message : ''
        HasAction   = $null -ne $data.action
      }
    }
  }
  function Get-ValeStyleRule {
    [cmdletbinding()]
    [OutputType([ValeStyleRule])]
    param(
      [string[]]$DirectoryPath,
      [switch]$Recurse
    )

    begin {}

    process {
      foreach ($directory in $DirectoryPath) {
        Get-ChildItem -Path $directory -Recurse:$Recurse -File -Filter '*.yml'
        | ForEach-Object -Process {
          [ValeStyleRule]::new($_)
        }
      }
    }
  }

  function Update-ValeStyleDocumentation {
    [cmdletbinding()]
    param(
      [string[]]$DirectoryPath
    )

    begin {}

    process {
      foreach ($directory in $DirectoryPath) {
        $readmeFile = Get-Item -Path $directory/readme.md
        if ($null -eq $readmeFile) {
          throw "oops! expected '$directory/readme.md' to exist!"
        }
        
        $style = $readmeFile.Directory.Name
        Write-Verbose "Updating docs for '$style' in: '$readmeFile'..."

        $readmeContent = Get-Content -Raw $readmeFile
        $readmeMunged  = ($readmeContent -split '## Rules')[0].Trim()
        $rules = Get-ValeStyleRule -DirectoryPath $directory -Recurse
        $sb = [System.Text.StringBuilder]::new($readmeMunged)
        $null = $sb.Append("`n`n").Append('## Rules').Append("`n`n")
        $null = $sb.Append('<!-- Remainder of document is generated, do not edit -->').Append("`n")
        $null = $sb.Append('<!-- markdownlint-disable MD033-->').Append("`n`n")
        $preludeTemplate = 'The following table summarizes the available rules for the `{0}` style:'
        $null = $sb.Append($preludeTemplate-f $readmeFile.Directory.Name).Append("`n`n")
        $null = $sb.Append('| Rule | Level | Scope | Fixable |').Append("`n")
        $null = $sb.Append('|:-----|:-----:|:-----:|:-------:|').Append("`n")
        foreach($rule in $rules) {
          $null = $sb.Append($rule.ToMarkdownDocumentationTableEntry()).Append("`n")
        }
        
        foreach($rule in $rules) {
          $null =$sb.Append("`n").Append($rule.ToMarkdownDocumentationSection())
        }

        $readmeMunged = $sb.ToString().Trim()

        "$readmeMunged" | Out-File -FilePath $readmeFile.FullName -Encoding utf8 -Force
        Write-Verbose "Updated docs for '$style'."
      }
    }
  }
  function Sync-Vale {
    [CmdletBinding()]
    param()

    process {
      # First, sync vale
      vale sync
      # Next, fix the names for any edited ini files. For more information,
      # see: https://github.com/errata-ai/vale/issues/991
      Get-ChildItem -Path $PSScriptRoot/.vale/packages -Recurse -File -Filter *.ini
      | Rename-Item -NewName '.vale.ini'
    }
  }
  function Reset-ValeSyncDirectory {
    [CmdletBinding()]
    param(
      [string]$SyncDirectory = (Resolve-Path "$PSScriptRoot/.vale/sync")
    )

    begin {
    }

    process {
      if (-not (Test-Path $SyncDirectory)) {
        Write-Verbose "Sync directory '$SyncDirectory' doesn't exist."
        return
      }

      # Remove all non-config folders.
      Get-ChildItem -Path $SyncDirectory -Exclude 'config'
      | Remove-Item -Recurse -Force

      # Remove all non-vocabulary config folders
      Get-ChildItem -Path "$SyncDirectory/config" -Exclude 'vocabularies'
      | Remove-Item -Recurse -Force
    }
  }

  $RuleDirectories = @(
    "$PSScriptRoot/.vale/packages/en_US"
    "$PSScriptRoot/.vale/packages/en_US_bias"
    "$PSScriptRoot/.vale/packages/en_US_grammar"
    "$PSScriptRoot/.vale/packages/en_US_hugo"
    "$PSScriptRoot/.vale/packages/en_US_numerals"
    "$PSScriptRoot/.vale/packages/en_US_punctuation"
    "$PSScriptRoot/.vale/packages/en_US_readability"
    "$PSScriptRoot/.vale/packages/en_US_style"
  )
}

process {
  foreach ($t in $Task){
    switch ($t) {
      'vale-sync'  {
        Write-Verbose "Syncing Vale..."
        Sync-Vale
        Write-Verbose "Vale synced."
      }
      'vale-clean' {
        Write-Verbose "Cleaning Vale sync directory..."
        Reset-ValeSyncDirectory
        Write-Verbose "Cleaned Vale sync directory."
      }
      'vale-get-rules' {
        Get-ValeStyleRule -DirectoryPath "$PSScriptRoot/.vale/packages/en_US" -Recurse
      }
      'vale-docs' {
        Write-Verbose "Updating reference documentation for Vale styles..."
        Update-ValeStyleDocumentation -DirectoryPath $RuleDirectories
        Write-Verbose "Updated reference documentation for Vale styles."
      }
      Default {}
    }
  }
}