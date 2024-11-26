New-Item -Path "../.out/asm" -ItemType Directory -Force

$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./asm.csv"
$inDir = (Resolve-Path "../.out").Path
$outDir = (Resolve-Path "../.out/asm").Path
if (Test-Path -Path $outDir) { Remove-Item -Path $outDir -Recurse -Force }
foreach ($line in $csv) {
    $name = "asm-$($line.id)"
    New-Item -Path "$outDir" -ItemType Directory -Force

    # Run ccfunc
    $dir = [URI]::EscapeDataString("$inDir/")
    $url = "$api/Developer/Run?clear=1&height=$($line.height)&depth=$($line.depth)&length=$($line.length)&nShelves=$($line.nShelves)&col_file=$($line.col_file)&shelf_file=$($line.shelf_file)&dir=$dir"
    curl $url --data-binary "@asm.ccfunc" --header "Content-Type: application/octet-stream" -sS
    Write-Host ""

    # Save ofb
    $file = [URI]::EscapeDataString("$outDir/$name.ofb")
    curl -sS "$api/BaseModeler_v1/save?file=$file" -d ""
    Write-Host ""

    # Save iwp
    $file = [URI]::EscapeDataString("$($outDir)/$($name)_binary.iwp")
    $option = [URI]::EscapeDataString("{`"asPart`": 1, `"useAsciiFile`": 0 }")
    curl -sS "$api/BaseModeler_v1/save?file=$file&option=$option" -d ""
    Write-Host ""
}
