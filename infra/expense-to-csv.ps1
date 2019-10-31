param (
    [string]$inputfile =$(throw "-inputfile is required."),
    [string]$outputfile = $(throw "-outputfile is required.")
)

# $outputfile="C:\repos\powershell\psexport.csv"
# $inputfile="C:\Users\juanb\OneDrive\Documents\Personal\Family expenses.xlsm"
$expenses = Import-Excel -Path $inputfile -WorksheetName "Expenses DB" -StartRow 10 -StartColumn 10
$incomes = Import-Excel -Path $inputfile -WorksheetName "Income DB" -StartRow 10 -StartColumn 10 

$consolidateRecords = @()
foreach ($i in $incomes) {
    $consolidateRecords += [PSCustomObject]@{
    date= [DateTime]::FromOADate($i.Date)
    store = "NA"
    category = $i.'Type '
    amount = $i.Amount
    excludeinwe = "NA"
    description = $i.Description
    }  
}

foreach ($e in $expenses) {
    $consolidateRecords += [PSCustomObject]@{
    date= [DateTime]::FromOADate($e.Date)
    store = $e.store
    category = $e.Category
    amount = $e.Amount * -1
    excludeinwe = $e.'Exclude in WE'
    description = $e.Description
    }
}

$consolidateRecords | Sort-Object -Property date |  export-Csv  -LiteralPath $outputfile -NoTypeInformation -Force
#Export-Csv -LiteralPath C:\repos\powershell/export.csv -InputObject $consolidateRecords