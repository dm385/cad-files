New-Item -Path "../.out/column" -ItemType Directory -Force

$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./column.csv"
$outDir = (Resolve-Path "../.out/column").Path
if (Test-Path -Path $outDir) { Remove-Item -Path $outDir -Recurse -Force }
foreach ($line in $csv) {
    $name = "$($line.height)-$($line.length)-$($line.depth)"
    New-Item -Path $outDir -ItemType Directory -Force

    # Run ccfunc
    $url = "$api/Developer/Run?clear=1&height=$($line.height)&length=$($line.length)&depth=$($line.depth)"
    curl $url --data-binary "@column.ccfunc" --header "Content-Type: application/octet-stream" -sS
    Write-Host ""

    # Save ofb
    $file = [URI]::EscapeDataString("$outDir/$name.ofb")
    curl -sS "$api/BaseModeler_v1/save?file=$file" -d ""
    Write-Host ""
}
