# Starship
Invoke-Expression (&starship init powershell)

# Pretty LS
Remove-Item alias:\ls
Import-Module PrettyLs

# PSCompletion
Import-Module PSCompletions

# PSReadLine
Import-Module PSReadLine
#menu-style completion (like Bash’s cycling menu)
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
# Predictive suggestions (from your history)
Set-PSReadLineOption -PredictionSource History
# Show completion suggestions inline (grey text)
Set-PSReadLineOption -PredictionViewStyle InlineView
# Case-insensitive completion
Set-PSReadLineOption -CompletionQueryItems 256

Import-Module PSFzf
