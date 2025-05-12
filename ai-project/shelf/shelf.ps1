New-Item -Path "../.out/shelf" -ItemType Directory -Force

$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./shelf.csv"
$outDir = (Resolve-Path "../.out/shelf").Path
if (Test-Path -Path $outDir) { Remove-Item -Path $outDir -Recurse -Force }
foreach ($line in $csv) {
    $name = "$($line.length)-$($line.depth)"
    New-Item -Path $outDir -ItemType Directory -Force

    # Run ccfunc
    $url = "$api/Developer/Run?clear=1&length=$($line.length)&depth=$($line.depth)&ft=$($line.ft)"
    curl $url --data-binary "@shelf.ccfunc" --header "Content-Type: application/octet-stream" -sS
    Write-Host ""

    # Save ofb
    $file = [URI]::EscapeDataString("$outDir/$name.ofb")
    curl -sS "$api/BaseModeler_v1/save?file=$file" -d ""
    Write-Host ""

    # Save iwp
    $file = [URI]::EscapeDataString("$($outDir)/$($name)_binary.iwp")
    $iwp = [URI]::EscapeDataString("{`"binary`": 0 }")
    curl -sS "$api/BaseModeler_v1/save?file=$file&iwp=$iwp" -d ""
    Write-Host ""
}
