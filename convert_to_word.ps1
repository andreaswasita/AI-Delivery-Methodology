# PowerShell Script to Convert Markdown to Word Document
param(
    [string]$MarkdownFile = "c:\Users\anwasita\AI-Delivery-Methodology\guides\program-governance-framework.md",
    [string]$OutputFile = "c:\Users\anwasita\AI-Delivery-Methodology\guides\program-governance-framework.docx"
)

Write-Host "Converting markdown to Word document..." -ForegroundColor Green

try {
    # Read the markdown content
    $content = Get-Content $MarkdownFile -Raw
    
    # Create Word Application
    $word = New-Object -ComObject Word.Application
    $word.Visible = $false
    
    # Create new document
    $doc = $word.Documents.Add()
    $selection = $word.Selection
    
    # Process content line by line
    $lines = $content -split "`r`n|`n"
    
    $inCodeBlock = $false
    
    foreach ($line in $lines) {
        $trimmedLine = $line.Trim()
        
        if ($trimmedLine -eq "") {
            $selection.TypeParagraph()
            continue
        }
        
        # Handle code blocks
        if ($trimmedLine -match '^```') {
            $inCodeBlock = -not $inCodeBlock
            if ($inCodeBlock) {
                $selection.Font.Name = "Courier New"
                $selection.Font.Size = 9
            } else {
                $selection.Font.Name = "Calibri"
                $selection.Font.Size = 11
            }
            continue
        }
        
        if ($inCodeBlock) {
            $selection.TypeText($trimmedLine)
            $selection.TypeParagraph()
            continue
        }
        
        # Handle headers
        if ($trimmedLine -match '^# (.+)$') {
            $selection.Style = "Heading 1"
            $headerText = $matches[1]
            $selection.TypeText($headerText)
            $selection.TypeParagraph()
        }
        elseif ($trimmedLine -match '^## (.+)$') {
            $selection.Style = "Heading 2"
            $headerText = $matches[1]
            $selection.TypeText($headerText)
            $selection.TypeParagraph()
        }
        elseif ($trimmedLine -match '^### (.+)$') {
            $selection.Style = "Heading 3"
            $headerText = $matches[1]
            $selection.TypeText($headerText)
            $selection.TypeParagraph()
        }
        elseif ($trimmedLine -match '^#### (.+)$') {
            $selection.Style = "Heading 4"
            $headerText = $matches[1]
            $selection.TypeText($headerText)
            $selection.TypeParagraph()
        }
        elseif ($trimmedLine -match '^##### (.+)$') {
            $selection.Style = "Heading 5"
            $headerText = $matches[1]
            $selection.TypeText($headerText)
            $selection.TypeParagraph()
        }
        # Handle horizontal rules
        elseif ($trimmedLine -match '^---+$') {
            $selection.TypeParagraph()
        }
        # Handle bullet points
        elseif ($trimmedLine -match '^\- (.+)$') {
            $selection.Style = "List Bullet"
            $bulletText = $matches[1] -replace '\*\*(.+?)\*\*', '$1' -replace '`(.+?)`', '$1'
            $selection.TypeText($bulletText)
            $selection.TypeParagraph()
        }
        # Handle tables
        elseif ($trimmedLine -match '^\|') {
            $selection.Style = "Normal"
            $selection.Font.Size = 9
            $selection.TypeText($trimmedLine)
            $selection.TypeParagraph()
            $selection.Font.Size = 11
        }
        # Normal text
        else {
            $selection.Style = "Normal"
            # Remove markdown formatting
            $cleanText = $trimmedLine -replace '\*\*(.+?)\*\*', '$1' -replace '`(.+?)`', '$1' -replace '\[(.+?)\]\(.+?\)', '$1'
            $selection.TypeText($cleanText)
            $selection.TypeParagraph()
        }
    }
    
    # Format document
    $doc.PageSetup.TopMargin = $word.InchesToPoints(1)
    $doc.PageSetup.BottomMargin = $word.InchesToPoints(1)
    $doc.PageSetup.LeftMargin = $word.InchesToPoints(1)
    $doc.PageSetup.RightMargin = $word.InchesToPoints(1)
    
    # Save document
    Write-Host "Saving document to: $OutputFile" -ForegroundColor Yellow
    $doc.SaveAs([ref]$OutputFile, [ref]16) # 16 = wdFormatDocumentDefault (.docx)
    
    # Close document and Word
    $doc.Close()
    $word.Quit()
    
    # Release COM objects
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($selection) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($doc) | Out-Null
    [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
    [System.GC]::Collect()
    [System.GC]::WaitForPendingFinalizers()
    
    Write-Host "Successfully created Word document!" -ForegroundColor Green
    Write-Host "Location: $OutputFile" -ForegroundColor Yellow
    Write-Host "Opening the document..." -ForegroundColor Yellow
    
    # Open the document
    Start-Process $OutputFile
    
} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host "Stack Trace: $($_.ScriptStackTrace)" -ForegroundColor Red
    if ($word) {
        $word.Quit()
        [System.Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
    }
}
